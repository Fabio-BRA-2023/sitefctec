/* FC.tec — interações do site (menu mobile + reveal ao rolar) */
(function () {
  'use strict';

  /* ---------- Menu mobile ---------- */
  var btn = document.querySelector('[aria-controls="menu-mobile"]');
  var menu = document.getElementById('menu-mobile');

  if (btn && menu) {
    var iconMenu = btn.querySelector('[data-icon="menu"]');
    var iconClose = btn.querySelector('[data-icon="close"]');

    var setOpen = function (open) {
      menu.hidden = !open;
      btn.setAttribute('aria-expanded', String(open));
      btn.setAttribute('aria-label', open ? 'Fechar menu' : 'Abrir menu');
      if (iconMenu) iconMenu.hidden = open;
      if (iconClose) iconClose.hidden = !open;
    };

    btn.addEventListener('click', function () {
      setOpen(menu.hidden);
    });

    Array.prototype.forEach.call(menu.querySelectorAll('a'), function (link) {
      link.addEventListener('click', function () {
        setOpen(false);
      });
    });

    document.addEventListener('keydown', function (event) {
      if (event.key === 'Escape' && !menu.hidden) {
        setOpen(false);
        btn.focus();
      }
    });

    window.addEventListener('resize', function () {
      if (window.innerWidth >= 1024 && !menu.hidden) setOpen(false);
    });
  }

  /* ---------- PWA: registro do Service Worker (com detecção de recurso) ---------- */
  if (
    "serviceWorker" in navigator &&
    (location.protocol === "https:" || location.protocol === "http:")
  ) {
    window.addEventListener("load", function () {
      navigator.serviceWorker.register("sw.js").catch(function () {
        /* sem Service Worker o site continua funcionando normalmente */
      });
    });
  }

  /* ---------- Reveal ao rolar (equivalente ao GSAP ScrollTrigger) ---------- */
  var targets = document.querySelectorAll('[data-reveal]');
  if (!targets.length || typeof IntersectionObserver === 'undefined') return;
  if (window.matchMedia('(prefers-reduced-motion: reduce)').matches) return;

  Array.prototype.forEach.call(targets, function (el) {
    el.style.opacity = '0';
    el.style.transform = 'translateY(20px)';
    el.style.transition =
      'opacity 0.6s cubic-bezier(0.22, 1, 0.36, 1), transform 0.6s cubic-bezier(0.22, 1, 0.36, 1)';
    el.style.willChange = 'opacity, transform';
  });

  var observer = new IntersectionObserver(
    function (entries) {
      entries.forEach(function (entry) {
        if (!entry.isIntersecting) return;
        var el = entry.target;
        el.style.opacity = '1';
        el.style.transform = 'none';
        window.setTimeout(function () {
          el.style.willChange = '';
        }, 650);
        observer.unobserve(el);
      });
    },
    { rootMargin: '0px 0px -8% 0px', threshold: 0 }
  );

  Array.prototype.forEach.call(targets, function (el) {
    observer.observe(el);
  });
})();
