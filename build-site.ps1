# Recria o site estaticamente a partir do preview original
$ErrorActionPreference = "Stop"
$base = "https://13000-i4shi0gfzauu4u1f3f67q-8f57ffe2.preview.happyseeds.space"
$out = Join-Path $PSScriptRoot "site-recriado"

$mobileMenu = @'
<div id="menu-mobile" class="border-t border-line bg-canvas lg:hidden" hidden>
  <div class="mx-auto w-full max-w-[1320px] px-gutter py-3">
    <nav aria-label="Navegação principal (mobile)">
      <ul class="m-0 flex list-none flex-col p-0">
        <li class="border-b border-line last:border-0"><a href="index.html#inicio" class="inline-flex min-h-[44px] items-center rounded-sm text-sm font-medium text-ink-muted transition-colors hover:text-brand-soft">Início</a></li>
        <li class="border-b border-line last:border-0"><a href="index.html#sobre" class="inline-flex min-h-[44px] items-center rounded-sm text-sm font-medium text-ink-muted transition-colors hover:text-brand-soft">Sobre</a></li>
        <li class="border-b border-line last:border-0"><a href="portfolio.html" class="inline-flex min-h-[44px] items-center rounded-sm text-sm font-medium text-ink-muted transition-colors hover:text-brand-soft">Projetos</a></li>
        <li class="border-b border-line last:border-0"><a href="mailto:fabio.correa.tec@gmail.com" class="inline-flex min-h-[44px] items-center rounded-sm text-sm font-medium text-ink-muted transition-colors hover:text-brand-soft">Contato</a></li>
      </ul>
    </nav>
    <div class="py-4">
      <a href="mailto:fabio.correa.tec@gmail.com" class="glow-btn inline-flex min-h-[46px] w-full items-center justify-center gap-2 rounded-lg bg-brand px-6 py-3 text-sm font-semibold text-white transition-[background-color,box-shadow] duration-300 hover:bg-brand-hover">Vamos conversar</a>
    </div>
  </div>
</div>
'@

# ---- Faixa em movimento (marquee) no fim do hero da pagina inicial ----
$marqueeItems = @(
    'SISTEMAS &amp; CRM',
    'AUTOMA&Ccedil;&Atilde;O DE PROCESSOS',
    'AN&Aacute;LISE DE DADOS',
    'LOW-CODE/NO-CODE',
    'WEB DESIGN',
    'SITES',
    'LANDING PAGES'
)
$star = '<svg class="marquee-star" viewBox="0 0 24 24" fill="currentColor" aria-hidden="true"><path d="M12 2Q13 11 22 12Q13 13 12 22Q11 13 2 12Q11 11 12 2Z"/></svg>'
$marqueeGroup = ($marqueeItems | ForEach-Object { '<span class="marquee-item">' + $star + '<span>' + $_ + '</span></span>' }) -join ''
$marqueeHtml = '<div class="marquee-band"><div class="marquee-track">' +
    '<div class="marquee-group">' + $marqueeGroup + '</div>' +
    '<div class="marquee-group" aria-hidden="true">' + $marqueeGroup + '</div>' +
    '</div></div>'

$marqueeCss = @'

/* ---- Faixa em movimento (marquee) - adicionado na recriacao ---- */
.marquee-band {
  position: relative;
  overflow: hidden;
  border-top: 1px solid var(--line);
  border-bottom: 1px solid var(--line);
  background: linear-gradient(180deg, rgb(8 17 27 / 0.92), rgb(3 8 20 / 0.92));
  padding-block: 14px;
}
.marquee-track {
  display: flex;
  width: max-content;
  animation: marquee-scroll 34s linear infinite;
}
.marquee-group {
  display: flex;
  align-items: center;
  gap: 26px;
  padding-right: 26px;
}
.marquee-item {
  display: inline-flex;
  align-items: center;
  gap: 26px;
  white-space: nowrap;
  font-family: var(--font-display);
  font-size: 0.75rem;
  font-weight: 600;
  letter-spacing: 0.16em;
  text-transform: uppercase;
  color: var(--ink);
}
.marquee-star {
  width: 14px;
  height: 14px;
  flex: none;
  color: var(--brand-soft);
  filter: drop-shadow(0 0 6px rgb(43 134 255 / 0.6));
}
.marquee-band:hover .marquee-track {
  animation-play-state: paused;
}
@keyframes marquee-scroll {
  from { transform: translateX(0); }
  to { transform: translateX(-50%); }
}
@media (prefers-reduced-motion: reduce) {
  .marquee-track { animation: none; }
}
'@

# ---- Secao "Tecnologias" logo apos o FAQ (mensagem + faixa de marcas) ----
$techCaption = 'TECNOLOGIAS ESCOLHIDAS CONFORME AS NECESSIDADES DE CADA PROJETO.'
$techLogos = @(
    @('Hermes', 'hermes.svg'),
    @('Vue.js', 'vuejs.svg'),
    @('OpenAI', 'openai.svg'),
    @('Supabase', 'supabase.svg'),
    @('Tailwind', 'tailwind.svg'),
    @('Docker', 'docker.svg'),
    @('n8n', 'n8n.svg'),
    @('Meta ADS', 'meta.svg')
)
$logoGroup = ($techLogos | ForEach-Object {
    '<span class="logo-item"><img src="assets/tech/' + $_[1] + '" alt="" width="22" height="22" loading="lazy" decoding="async" draggable="false"/><span>' + $_[0] + '</span></span>'
}) -join ''
$techHtml = '<section class="tech-section border-b border-line">' +
    '<div class="tech-caption-wrap"><p class="tech-caption">' + $techCaption + '</p></div>' +
    '<div class="marquee-band marquee-logos"><div class="marquee-track">' +
    '<div class="marquee-group logo-group">' + $logoGroup + '</div>' +
    '<div class="marquee-group logo-group" aria-hidden="true">' + $logoGroup + '</div>' +
    '</div></div></section>'

$techCss = @'

/* ---- Secao Tecnologias (mensagem + faixa de marcas) - adicionado na recriacao ---- */
.tech-section {
  background: linear-gradient(180deg, rgb(3 8 20 / 0.7), rgb(5 11 26 / 0.7));
}
.tech-caption-wrap {
  padding: clamp(36px, 4vw, 52px) clamp(20px, 4vw, 56px) clamp(18px, 2vw, 26px);
}
.tech-caption {
  margin: 0 auto;
  max-width: 44rem;
  text-align: center;
  font-family: var(--font-display);
  font-size: 0.75rem;
  font-weight: 500;
  letter-spacing: 0.17em;
  text-transform: uppercase;
  color: var(--ink-subtle);
}
.marquee-logos {
  background: transparent;
  border-bottom: none;
  padding-block: 18px;
}
.marquee-logos .marquee-track {
  animation-duration: 42s;
}
.marquee-logos .marquee-group.logo-group {
  gap: clamp(36px, 5vw, 64px);
  padding-right: clamp(36px, 5vw, 64px);
}
.logo-item {
  display: inline-flex;
  align-items: center;
  gap: 12px;
  white-space: nowrap;
  font-family: var(--font-sans);
  font-size: 0.9375rem;
  font-weight: 500;
  color: var(--ink-muted);
  transition: color 0.25s ease;
}
.logo-item img {
  width: 22px;
  height: 22px;
  display: block;
  opacity: 0.9;
}
.logo-item:hover {
  color: var(--ink);
}
'@

$hermesSvg = '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" role="img"><title>Hermes</title><rect x="2.5" y="2.5" width="19" height="19" rx="5.5" stroke="#c7d1de" stroke-width="1.6"/><path d="M8 7.5v9M16 7.5v9M8 12h8" stroke="#c7d1de" stroke-width="1.8" stroke-linecap="round"/></svg>'

# ---- Acessibilidade, responsividade e compatibilidade multiplataforma ----
$a11yCss = @'

/* ---- Acessibilidade / compatibilidade (adicionado na recriacao) ---- */
html {
  -webkit-text-size-adjust: 100%;
  text-size-adjust: 100%;
  scroll-padding-top: 96px;
}
a:focus-visible,
button:focus-visible,
summary:focus-visible,
[tabindex]:focus-visible {
  outline: 2px solid var(--focus);
  outline-offset: 3px;
}
summary::-webkit-details-marker {
  display: none;
}
a,
button,
summary {
  -webkit-tap-highlight-color: rgba(43, 134, 255, 0.25);
}
body {
  -webkit-font-smoothing: antialiased;
  text-rendering: optimizeLegibility;
}
body > header {
  padding-top: env(safe-area-inset-top, 0px);
}
body > footer {
  padding-bottom: env(safe-area-inset-bottom, 0px);
}
/* preflight de imagens dentro da camada base, para que as utilidades do
   Tailwind (.h-9, .h-10, .object-cover etc.) continuem vencendo o height:auto */
@layer base {
  img,
  video {
    max-width: 100%;
    height: auto;
  }
}
@media (prefers-reduced-motion: reduce) {
  html {
    scroll-behavior: auto;
  }
  *,
  *::before,
  *::after {
    animation-duration: 0.01ms !important;
    animation-iteration-count: 1 !important;
    transition-duration: 0.01ms !important;
  }
}
'@

function Convert-Page([string]$html) {
    # remove todos os <script> (streams/HMR do SSR)
    $html = [regex]::Replace($html, '(?is)<script\b[^>]*>.*?</script>', '')
    # remove assets exclusivos do dev server
    $html = [regex]::Replace($html, '(?is)<link rel="modulepreload"[^>]*/>', '')
    $html = [regex]::Replace($html, '(?is)<link rel="stylesheet" href="/@tanstack-start[^>]*/>', '')

    # wrappers animados (GSAP Reveal) -> marcador para o IntersectionObserver
    $html = [regex]::Replace($html, '<div([^>]*?)data-tsd-source="/src/components/site/motion\.tsx:[^"]*" data-tsd-name="div\|Reveal">', '<div$1data-reveal>')

    # remove atributos de debug do TanStack Start
    $html = [regex]::Replace($html, '\s+data-tsd-(source|name)="[^"]*"', '')
    $html = [regex]::Replace($html, '\s+data-tsr-stream-part="[^"]*"', '')
    $html = $html.Replace('<!--$-->', '').Replace('<!--/$-->', '')

    # assets locais
    $html = $html.Replace('href="/logo-fc-tec.png"', 'href="assets/logo-fc-tec.png"')
    $html = $html.Replace('href="/perfil-profissional.jpg"', 'href="assets/perfil-profissional.jpg"')
    $html = $html.Replace('src="/logo-fc-tec.png"', 'src="assets/logo-fc-tec.png"')
    $html = $html.Replace('src="/perfil-profissional.jpg"', 'src="assets/perfil-profissional.jpg"')
    $html = $html.Replace('href="/favicon-32.png"', 'href="assets/favicon-32.png"')
    $html = $html.Replace('href="/apple-touch-icon.png"', 'href="assets/apple-touch-icon.png"')
    $html = $html.Replace('href="/src/styles.css" data-precedence="default"', 'href="styles.css"')

    # rotas -> paginas estaticas
    $html = $html.Replace('href="/portfolio/"', 'href="portfolio.html"')
    $html = $html.Replace('href="/portfolio"', 'href="portfolio.html"')
    $html = $html.Replace('href="/#inicio"', 'href="index.html#inicio"')
    $html = $html.Replace('href="/#sobre"', 'href="index.html#sobre"')

    # encaixe exato da foto de perfil: o container passa a ter a mesma proporcao
    # da imagem (1:1), entao nada e cortado e nao sobram barras
    $html = $html.Replace('class="relative mt-4 aspect-[848/1230] overflow-hidden rounded-lg border border-line-strong bg-canvas-deep/70"', 'class="relative mt-4 aspect-square overflow-hidden rounded-lg border border-line-strong bg-canvas-deep/70"')

    # menu mobile + script
    $html = $html.Replace('</header>', $mobileMenu + '</header>')
    $html = $html.Replace('</body>', '<script src="script.js"></script></body>')
    return $html
}

$pages = @{ "index.html" = "/"; "portfolio.html" = "/portfolio" }
foreach ($name in $pages.Keys) {
    $raw = (Invoke-WebRequest -Uri "$base$($pages[$name])" -UseBasicParsing).Content
    $html = Convert-Page $raw

    # --- melhorias multiplataforma: PWA + deteccao de aparelho ---
    $html = $html.Replace('</head>',
        '<link rel="manifest" href="manifest.webmanifest"/>' +
        '<meta name="mobile-web-app-capable" content="yes"/>' +
        '<meta name="apple-mobile-web-app-capable" content="yes"/>' +
        '<meta name="apple-mobile-web-app-status-bar-style" content="black-translucent"/>' +
        '<meta name="format-detection" content="telephone=no"/>' +
        '</head>')

    # --- imagens: dimensoes intrinsecas (evita salto de layout) e carregamento sob demanda ---
    $html = [regex]::Replace($html, '<img src="assets/logo-fc-tec\.png"([^>]*?)class="h-9 w-auto shrink-0 sm:h-10"',
        '<img width="1275" height="787" fetchpriority="high" decoding="async" src="assets/logo-fc-tec.png"$1class="h-9 w-auto shrink-0 sm:h-10"')
    $html = [regex]::Replace($html, '<img src="assets/logo-fc-tec\.png"([^>]*?)class="h-9 w-auto"',
        '<img width="1275" height="787" loading="lazy" decoding="async" src="assets/logo-fc-tec.png"$1class="h-9 w-auto"')
    $html = [regex]::Replace($html, '<img src="assets/perfil-profissional\.jpg"',
        '<img width="1254" height="1254" fetchpriority="high" decoding="async" src="assets/perfil-profissional.jpg"')

    # --- pagina ativa marcada para leitores de tela (apenas no menu mobile) ---
    if ($name -eq "portfolio.html") {
        $html = $html.Replace('<a href="portfolio.html" class="inline-flex min-h-[44px]',
            '<a href="portfolio.html" aria-current="page" class="inline-flex min-h-[44px]')
    }

    if ($name -eq "index.html") {
        # faixa em movimento fechando a secao #inicio (full-width, fora do Container)
        $pos = $html.IndexOf('</section>')
        if ($pos -ge 0) { $html = $html.Insert($pos, $marqueeHtml) }
        # secao Tecnologias (mensagem + faixa de marcas) logo apos o FAQ
        $pos = $html.IndexOf('</main>')
        if ($pos -ge 0) { $html = $html.Insert($pos, $techHtml) }
    }
    [System.IO.File]::WriteAllText((Join-Path $out $name), $html, [System.Text.UTF8Encoding]::new($false))
    Write-Host "$name -> $($html.Length) chars"
}

# CSS compilado (Tailwind v4 + estilos proprios) sai do modulo Vite /src/styles.css
$cssModule = (Invoke-WebRequest -Uri "$base/src/styles.css" -UseBasicParsing).Content
$marker = 'const __vite__css = "'
$start = $cssModule.IndexOf($marker)
if ($start -lt 0) { throw "marcador __vite__css nao encontrado" }
$start += $marker.Length
$end = $start
while ($end -lt $cssModule.Length) {
    if ($cssModule[$end] -eq '\') { $end += 2; continue }
    if ($cssModule[$end] -eq '"') { break }
    $end++
}
$escaped = $cssModule.Substring($start, $end - $start)
$css = [regex]::Replace($escaped, '\\u(?<h>[0-9a-fA-F]{4})|\\x(?<x>[0-9a-fA-F]{2})|\\(?<c>.)', {
    param($m)
    if ($m.Groups['h'].Success) { return [string][char][convert]::ToInt32($m.Groups['h'].Value, 16) }
    if ($m.Groups['x'].Success) { return [string][char][convert]::ToInt32($m.Groups['x'].Value, 16) }
    switch ($m.Groups['c'].Value) {
        'n' { return "`n" }
        'r' { return "`r" }
        't' { return "`t" }
        'b' { return [string][char]8 }
        'f' { return [string][char]12 }
        default { return $m.Groups['c'].Value }
    }
})
[System.IO.File]::WriteAllText((Join-Path $out "styles.css"), $css + $marqueeCss + $techCss + $a11yCss, [System.Text.UTF8Encoding]::new($false))
Write-Host "styles.css -> $($css.Length) chars"

# ---- logos das marcas (SVG locais, baixados uma unica vez) ----
$techDir = Join-Path $out "assets\tech"
if (-not (Test-Path $techDir)) { New-Item -ItemType Directory -Path $techDir | Out-Null }
if (-not (Test-Path (Join-Path $techDir "hermes.svg"))) {
    [System.IO.File]::WriteAllText((Join-Path $techDir "hermes.svg"), $hermesSvg, [System.Text.UTF8Encoding]::new($false))
}
# arquivo local => slug do Simple Icons
$techDownloads = @(
    @('vuejs.svg', 'vuedotjs'),
    @('supabase.svg', 'supabase'),
    @('tailwind.svg', 'tailwindcss'),
    @('docker.svg', 'docker'),
    @('n8n.svg', 'n8n'),
    @('meta.svg', 'meta'),
    @('openai.svg', 'openai')
)
foreach ($pair in $techDownloads) {
    $file = Join-Path $techDir $pair[0]
    if (-not (Test-Path $file)) {
        $uri = if ($pair[1] -eq 'openai') {
            # removido do Simple Icons oficial; usa um release antigo via jsDelivr
            'https://cdn.jsdelivr.net/npm/simple-icons@11/icons/openai.svg'
        } else {
            "https://cdn.simpleicons.org/$($pair[1])/c7d1de"
        }
        Invoke-WebRequest -Uri $uri -UseBasicParsing -OutFile $file -ErrorAction Stop
        $svg = [System.IO.File]::ReadAllText($file)
        if ($svg -notmatch 'fill="#[0-9a-fA-F]{6}"') {
            # garante cor clara para o fundo escuro
            $svg = $svg -replace '<svg ', '<svg fill="#c7d1de" '
            [System.IO.File]::WriteAllText($file, $svg, [System.Text.UTF8Encoding]::new($false))
        }
        Write-Host "logo $($pair[0]) baixado"
    }
}

# ---- icones PWA (gerados a partir do logo, sem dependencias externas) ----
function New-AppIcon([int]$size, [string]$file, [double]$logoPct) {
    Add-Type -AssemblyName System.Drawing
    $bmp = New-Object System.Drawing.Bitmap($size, $size)
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $g.Clear([System.Drawing.Color]::FromArgb(255, 5, 11, 26))   # #050b1a
    $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
    $logo = [System.Drawing.Image]::FromFile((Join-Path $out "assets\logo-fc-tec.png"))
    $w = [int]($size * $logoPct)
    $h = [int]($w * $logo.Height / $logo.Width)
    $x = [int](($size - $w) / 2)
    $y = [int](($size - $h) / 2)
    $g.DrawImage($logo, $x, $y, $w, $h)
    $logo.Dispose()
    $g.Dispose()
    $bmp.Save($file, [System.Drawing.Imaging.ImageFormat]::Png)
    $bmp.Dispose()
}
New-AppIcon 192 (Join-Path $out "assets\icon-192.png") 0.78
New-AppIcon 512 (Join-Path $out "assets\icon-512.png") 0.78
New-AppIcon 512 (Join-Path $out "assets\icon-maskable-512.png") 0.60

# ---- Service Worker (versao muda a cada build: cache nunca fica obsoleto) ----
$swTemplate = @'
/* Service Worker - FC.tec
   Cache de estaticos + navegacao online-first com fallback offline.
   Gerado por build-site.ps1 (versao @VERSION@). */
const CACHE = "@VERSION@";
const ASSETS = [
  "./",
  "./index.html",
  "./portfolio.html",
  "./styles.css",
  "./script.js",
  "./manifest.webmanifest",
  "./404.html",
  "./assets/logo-fc-tec.png",
  "./assets/perfil-profissional.jpg",
  "./assets/favicon-32.png",
  "./assets/apple-touch-icon.png",
  "./assets/icon-192.png",
  "./assets/icon-512.png",
  "./assets/icon-maskable-512.png"
];

self.addEventListener("install", (event) => {
  event.waitUntil(
    caches.open(CACHE).then((cache) =>
      Promise.all(
        ASSETS.map((url) =>
          fetch(new Request(url, { cache: "reload" }))
            .then((response) => (response.ok ? cache.put(url, response) : undefined))
            .catch(() => undefined)
        )
      )
    ).then(() => self.skipWaiting())
  );
});

self.addEventListener("activate", (event) => {
  event.waitUntil(
    caches
      .keys()
      .then((keys) => Promise.all(keys.filter((key) => key !== CACHE).map((key) => caches.delete(key))))
      .then(() => self.clients.claim())
  );
});

self.addEventListener("fetch", (event) => {
  const request = event.request;
  if (request.method !== "GET") return;
  const url = new URL(request.url);
  if (url.origin !== self.location.origin) return; // CDN externos (fontes) ficam com a rede

  // paginas: online primeiro, cache como fallback offline
  if (request.mode === "navigate") {
    event.respondWith(
      fetch(request)
        .then((response) => {
          const copy = response.clone();
          caches.open(CACHE).then((cache) => cache.put(request, copy));
          return response;
        })
        .catch(() =>
          caches.match(request).then((cached) => cached || caches.match("./index.html"))
        )
    );
    return;
  }

  // estaticos: cache primeiro, atualizando em segundo plano
  event.respondWith(
    caches.match(request).then((cached) => {
      const refresh = fetch(request)
        .then((response) => {
          if (response.ok) {
            const copy = response.clone();
            caches.open(CACHE).then((cache) => cache.put(request, copy));
          }
          return response;
        })
        .catch(() => cached);
      return cached || refresh;
    })
  );
});
'@
$swVersion = "fctec-" + (Get-Date -Format "yyyyMMddHHmm")
[System.IO.File]::WriteAllText((Join-Path $out "sw.js"), $swTemplate.Replace("@VERSION@", $swVersion), [System.Text.UTF8Encoding]::new($false))
Write-Host "sw.js gerado ($swVersion)"
Write-Host "OK"
