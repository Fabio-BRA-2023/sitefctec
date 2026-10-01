# sitefctec

Portfólio profissional de **Fábio Corrêa Guimarães** — gestão, tecnologia e transformação digital.

![Print do site](docs/print-home.png)

## Sobre

Site institucional de página única + portfólio de projetos, com visual dark em azul neon (FC.tec),
foco em performance, acessibilidade e SEO. Apresenta área de atuação, competências, formações,
metodologia de trabalho (organizar → automatizar → integrar → analisar → melhorar), FAQ e contato.

## Stack

- **HTML5 / CSS3 / JavaScript** puros — sem build, sem dependências
- **Tailwind** (classes utilitárias no CSS)
- **PWA** — `manifest.webmanifest` + `sw.js` (service worker com cache offline)
- **Ícones e imagens** próprios em `site-recriado/assets/`
- Ícones de tecnologias em SVG: Docker, n8n, OpenAI, Supabase, Tailwind, Vue.js, Meta, Hermes

## Estrutura

```
site-recriado/
├── index.html          # Página inicial (hero, sobre, método, FAQ, contato)
├── portfolio.html      # Projetos
├── 404.html            # Página de erro
├── styles.css          # Estilos
├── script.js           # Interações (menu, FAQ, animações)
├── manifest.webmanifest
├── sw.js               # Service worker
└── assets/             # Logo, foto, ícones PWA, SVGs de tecnologias
```

## Como rodar local

```powershell
# Servidor em http://localhost:8099/
.\serve.ps1
```

Ou simplesmente abrindo `site-recriado/index.html` no navegador.

## Deploy

O repositório usa a branch `main`. Para publicar no GitHub Pages:

1. **Settings → Pages → Source**: `Deploy from a branch`
2. Branch: `main`, pasta: `/ (root)`
3. O site fica em `https://fabio-bra-2023.github.io/sitefctec/`

> Como os arquivos ficam em `site-recriado/`, é preciso mover o conteúdo para a raiz
> ou apontar o Pages para essa pasta.

## Contato

- E-mail: fabio.correa.tec@gmail.com
- WhatsApp: +55 51 99100-0808

## Licença

Todos os direitos reservados © 2026 Fábio Corrêa Guimarães.
