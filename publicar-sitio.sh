#!/bin/bash
# Uso:
#   bash publicar-sitio.sh probar                      -> genera el sitio y NO sube nada
#   bash publicar-sitio.sh USUARIO_GITHUB NOMBRE_REPO  -> genera y publica
set -e

if [ "$1" = "probar" ]; then
  MODO="probar"
else
  MODO="publicar"
  USUARIO="$1"; REPO="$2"
  if [ -z "$USUARIO" ] || [ -z "$REPO" ]; then
    echo "Uso: bash publicar-sitio.sh probar"
    echo "  o: bash publicar-sitio.sh USUARIO REPO"
    exit 1
  fi
fi

PROYECTO="$HOME/blog-ss2026"
OUT=/tmp/sitio-estatico
PUERTO=8000
URL="http://127.0.0.1:$PUERTO"

cd "$PROYECTO"

if command -v pg_isready >/dev/null 2>&1 && ! pg_isready -q; then
  echo "PostgreSQL no esta encendido. Ejecuta primero: sudo service postgresql start"
  exit 1
fi

rm -rf "$OUT"; mkdir -p "$OUT"

echo ">> Iniciando Laravel en local..."
php artisan serve --host=127.0.0.1 --port=$PUERTO > /tmp/serve.log 2>&1 &
PID=$!
trap "kill $PID 2>/dev/null || true" EXIT

for i in $(seq 1 20); do
  if wget -q --spider "$URL/"; then break; fi
  sleep 1
done
if ! wget -q --spider "$URL/"; then
  echo "Laravel no respondio. Revisa /tmp/serve.log"; exit 1
fi

echo ">> Descargando el sitio..."
wget -nv --mirror --page-requisites --adjust-extension --convert-links \
     --no-host-directories --no-parent \
     --reject-regex '(admin|login|logout)' \
     -P "$OUT" "$URL/" 2>&1 | tail -n 5 || true

if [ ! -f "$OUT/index.html" ]; then
  echo "No se genero index.html. Revisa /tmp/serve.log"; exit 1
fi

kill $PID 2>/dev/null || true

echo ">> Limpiando enlaces y nombres..."
mkdir -p "$OUT/js"

cat > "$OUT/js/buscador.js" << 'JSEOF'
(function () {
  var input = document.querySelector('form input[name="q"]');
  if (!input) return;
  var form = input.closest('form');

  function norm(s) {
    return (s || '').normalize('NFD').replace(/[\u0300-\u036f]/g, '').toLowerCase();
  }

  var cards = [];
  [].slice.call(document.querySelectorAll('a[href^="entradas/"]')).forEach(function (a) {
    var c = a.closest('[class~="col"], [class*="col-"]') || a.closest('article, .card');
    if (c && cards.indexOf(c) < 0) cards.push(c);
  });
  if (!cards.length) return;

  var vacio = document.createElement('p');
  vacio.textContent = 'No se encontraron entradas con esa busqueda.';
  vacio.style.display = 'none';
  vacio.className = 'text-center my-4';
  cards[0].parentNode.appendChild(vacio);

  var pag = document.querySelector('.pagination');
  var pagBox = pag ? (pag.closest('nav') || pag) : null;

  function filtrar() {
    var q = norm(input.value.trim());
    var visibles = 0;
    cards.forEach(function (c) {
      var ok = !q || norm(c.textContent).indexOf(q) !== -1;
      c.style.display = ok ? '' : 'none';
      if (ok) visibles++;
    });
    vacio.style.display = visibles ? 'none' : '';
    if (pagBox) pagBox.style.display = q ? 'none' : '';
  }

  input.addEventListener('input', filtrar);
  form.addEventListener('submit', function (e) { e.preventDefault(); filtrar(); });

  var inicial = new URLSearchParams(location.search).get('q');
  if (inicial) { input.value = inicial; filtrar(); }
})();
JSEOF

cat > /tmp/limpiar.py << 'PYEOF'
import os, re, sys

root = sys.argv[1]

# 1) Renombrar archivos con "?" en el nombre
for dirpath, _, files in os.walk(root):
    for fn in files:
        old = os.path.join(dirpath, fn)
        new = None
        m = re.match(r'^(.+?\.(?:css|js))\?v=\d+(?:\.css|\.js)?$', fn)
        if m:
            new = m.group(1)
        m = re.match(r'^entradas\?categoria=(.+?)(?:\.html)?$', fn)
        if m:
            new = 'categoria-%s.html' % m.group(1)
        m = re.match(r'^entradas\?page=(\d+)(?:\.html)?$', fn)
        if m:
            new = 'entradas-pagina-%s.html' % m.group(1)
        if new:
            os.replace(old, os.path.join(dirpath, new))

# 2) Corregir el contenido de todos los HTML
for dirpath, _, files in os.walk(root):
    for fn in files:
        if not fn.endswith('.html'):
            continue
        p = os.path.join(dirpath, fn)
        depth = os.path.relpath(dirpath, root).count(os.sep) + (0 if os.path.relpath(dirpath, root) == '.' else 1)
        prefix = '../' * depth
        txt = open(p, encoding='utf-8').read()

        # enlaces a login/admin: se eliminan
        txt = re.sub(r'<a\b[^>]*href="[^"]*/(?:login|admin|logout)[^"]*"[^>]*>.*?</a>', '', txt, flags=re.S)

        # version del css/js
        txt = re.sub(r'(\.(?:css|js))(?:%3F|\?)v=\d+(?:\.css|\.js)?', r'\1', txt)

        # categorias y paginas
        txt = re.sub(r'entradas(?:%3F|\?)categoria(?:=|%3D)([A-Za-z0-9_\-]+)(?:\.html)?(?=["\'])',
                     r'categoria-\1.html', txt)
        txt = re.sub(r'entradas(?:%3F|\?)page(?:=|%3D)(\d+)(?:\.html)?(?=["\'])',
                     r'entradas-pagina-\1.html', txt)

        # formularios: sin servidor, no hay a donde enviar
        txt = re.sub(r'(<form\b[^>]*?)\saction="[^"]*"', r'\1 action="#"', txt)

        # restos de la URL local
        txt = re.sub(r'http://127\.0\.0\.1:8000/?', prefix, txt)
        txt = txt.replace('href=""', 'href="%sindex.html"' % prefix)

        # buscador solo en el listado y en las categorias
        if depth == 0 and (fn == 'entradas.html' or fn.startswith('categoria-') or fn.startswith('entradas-pagina-')):
            txt = txt.replace('</body>', '<script src="js/buscador.js"></script>\n</body>')

        open(p, 'w', encoding='utf-8').write(txt)
PYEOF

python3 /tmp/limpiar.py "$OUT"
rm -f "$OUT/robots.txt"
touch "$OUT/.nojekyll"

echo ">> Revision rapida:"
RESTOS=$(grep -rl "127.0.0.1" "$OUT" --include=*.html 2>/dev/null | wc -l)
INTERR=$(grep -rhoE 'href="[^"]*(\?|%3F)[^"]*"' "$OUT" --include=*.html 2>/dev/null | grep -v 'googleapis\|jsdelivr' | wc -l)
echo "   Archivos con 127.0.0.1: $RESTOS (debe ser 0)"
echo "   Enlaces con '?' restantes: $INTERR (debe ser 0)"
echo "   Archivos HTML: $(find "$OUT" -name '*.html' | wc -l)"

if [ "$MODO" = "probar" ]; then
  echo ""
  echo "Sitio generado en: $OUT"
  echo "Para verlo en tu navegador de Windows ejecuta:"
  echo "   cd $OUT && python3 -m http.server 9000"
  echo "y abre http://localhost:9000  (Ctrl+C para detenerlo)"
  exit 0
fi

echo ">> Subiendo a GitHub..."
cd "$OUT"
git init -q -b main
git add .
git -c user.name="$USUARIO" -c user.email="$USUARIO@users.noreply.github.com" commit -q -m "Publicacion del sitio estatico"
git remote add origin "https://github.com/$USUARIO/$REPO.git"
git push -f origin main

echo ""
echo "Sitio publicado en: https://$(echo "$USUARIO" | tr 'A-Z' 'a-z').github.io/$REPO"
