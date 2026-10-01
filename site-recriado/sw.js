/* Service Worker - FC.tec
   Cache de estaticos + navegacao online-first com fallback offline.
   Gerado por build-site.ps1 (versao fctec-202610011622). */
const CACHE = "fctec-202610011622";
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