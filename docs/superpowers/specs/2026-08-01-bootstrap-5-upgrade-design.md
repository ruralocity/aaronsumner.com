# Bootstrap 3.0.2 → 5.3.8 Upgrade

**Date:** 2026-08-01
**Goal:** Move to current Bootstrap with as little visual change as possible, so future work can use modern Bootstrap utilities. Along the way, drop the site's remaining third-party asset dependencies — every stylesheet, font, and icon ends up same-origin.

## Current State

- **Bootstrap 3.0.2** (2013), vendored as static CSS in `assets/css/`.
- **No build step.** Jekyll 4.4 renders markdown; CSS files are hand-committed dist copies. Netlify runs `bundle exec jekyll build`.
- **No JavaScript.** No jQuery, no `bootstrap.js`, no JS-driven Bootstrap components anywhere.
- **Small Bootstrap surface.** The entire site uses: `container`, `row`, `col-md-4/6/12`, `nav nav-pills`, `btn btn-primary`, `text-muted`, `form-group`/`form-control`/`form-text`.
- **Font Awesome 4** provides five social icons, all on the contact page.
- Site identity lives in `assets/css/site.css` (Source Sans Pro, maroon `#631111` links, `.content` typography), not in Bootstrap.

## Decisions

| Decision | Choice | Rationale |
|---|---|---|
| Delivery | Vendored `bootstrap.min.css` 5.3.8, no build step | Matches existing workflow. Bootstrap 5.3 exposes `--bs-*` custom properties, so theming needs no Sass. Future upgrades replace one file. |
| Icons | Inline SVG, delete Font Awesome | Five icons do not justify a 2016 webfont plus 1339 lines of CSS. No new dependency. |
| Fonts | Self-host Source Sans Pro, drop the Google Fonts link | Removes a live per-visitor request to Google (privacy, third-party availability, extra DNS + TLS on a render-blocking resource). Cross-site font caching stopped working when browsers partitioned the HTTP cache, so the CDN gains nothing. |
| Fidelity | "Close enough" | Accept small heading/spacing drift from Bootstrap 5 defaults. Do not add compatibility CSS that fights the framework. Fix anything that reads as broken. |
| Verification | Automated before/after screenshots | Catches regressions on pages easy to forget. |
| JavaScript | None | No JS components in use. Ship CSS only. |

## Changes

### 1. Stylesheet files

**Delete:**

- `assets/css/bootstrap.css` (3.0.2)
- `assets/css/bootstrap-theme.css` — linked nowhere
- `assets/css/bootstrap-narrow.css` — its two live rules move to `site.css` (see §3)
- `assets/css/all.css` — Middleman scaffold leftover, linked nowhere
- `assets/css/font-awesome.css`, `assets/css/font-awesome.min.css`
- every existing file in `assets/fonts/` (glyphicons, Font Awesome webfonts, `cc-icons`) — the directory itself stays, repopulated with the Source Sans Pro woff2 files below

Verified: no markup or CSS in `_layouts`, `pages`, `index.markdown`, `404.html.markdown`, `_posts`, `_reading`, or `site.css` references `all.css`, `bootstrap-theme`, `cc-icons`, or any `glyphicon` class.

**Add:**

- `assets/css/bootstrap.min.css` — Bootstrap 5.3.8 dist, unmodified
- `assets/fonts/` — 8 Source Sans Pro woff2 files (see §4)

**Result** — `_layouts/default.html` `<head>` carries two stylesheet links, both same-origin:

```html
<link href="/assets/css/bootstrap.min.css" rel="stylesheet" />
<link href="/assets/css/site.css" rel="stylesheet" />
```

The `//fonts.googleapis.com` link is removed.

### 2. Markup changes

**a. Dead ERB** — `_layouts/default.html`

`<body class="<%= page_classes %>">` → `<body>`. Middleman leftover; Jekyll renders it literally today.

**b. Nav components** — `_layouts/default.html` footer, `pages/contact.html.markdown` social list

Bootstrap 5 moved all nav styling onto `.nav-link`; a bare `<li><a>` inside `.nav` renders unstyled. Add `nav-item` to each `<li>` and `nav-link` to each `<a>`. Drop `nav-justify` from the social list — not a real class in Bootstrap 3 or 5.

**c. Form** — `pages/contact.html.markdown`

- `.form-group` → `.mb-3` (`.form-group` was removed in Bootstrap 5; confirmed absent from the 5.3.8 dist)
- Each `<label>` gains `.form-label`
- `.form-control`, `.form-text`, `.text-muted`, `.btn`, `.btn-primary` carry over unchanged (`.text-muted` is deprecated in favor of `.text-body-secondary` but still ships in 5.3.8)
- The `netlify` attribute and form action stay untouched

**d. Grid breakpoint** — `index.markdown`, `_layouts/default.html`

`col-md-*` → `col-lg-*` throughout.

Bootstrap 3's `md` breakpoint is 992px; Bootstrap 5's `md` is 768px. Renaming to `col-lg-*` (992px in Bootstrap 5) preserves the current stacking behavior exactly. This matters here: `.container` is capped at 730px, so columns going side-by-side at 768px would squeeze the project cards and their 100px floated images.

Affected: `col-md-12` (header), `col-md-6` (featured projects, recent posts / bio), `col-md-4` (three project cards).

**e. Icons** — `pages/contact.html.markdown`

Replace each `<i class="fa fa-* fa-2x">` with an inline `<svg>` using the equivalent Bootstrap Icons path, sized to match `fa-2x` (~2em). Five icons, all in the `#social` list: GitHub, Instagram, Flickr, LinkedIn, RSS. Preserve each icon's `title` as an accessible name (`<title>` element inside the SVG, or `aria-label` on the link).

### 3. `site.css` changes

Three additions below, plus the `@font-face` blocks in §4. No compatibility layer, no pinning of Bootstrap 5 defaults back to Bootstrap 3 values.

**a. Link underlines.** Bootstrap 5 sets `--bs-link-decoration: underline` at `:root` and applies it to every `a`; Bootstrap 3 did not underline links. Set `--bs-link-decoration: none` at `:root` in `site.css`. The existing `#content a { text-decoration: underline }` keeps body-copy links underlined. Without this, header and footer nav links gain underlines they do not have today.

**b. Narrow container.** Absorb the live rules from `bootstrap-narrow.css`:

```css
body { padding-top: 20px; padding-bottom: 20px; }
@media (min-width: 768px) { .container { max-width: 730px; } }
```

The remaining rules in that file target `.jumbotron`, `.marketing`, `.header`, `.footer`, and `.container-narrow` — none of those classes appear in any markup (the layout uses bare `<header>` and `<footer>` elements). They are dropped.

**c. Maroon theme via custom properties.** Convert the existing `a` and `.btn-primary` overrides to Bootstrap 5 custom properties so hover, focus, and active states inherit correctly instead of fighting Bootstrap's variable-driven button rules:

- `--bs-link-color` / `--bs-link-hover-color` for `#631111` / `#993333`
- `--bs-btn-bg`, `--bs-btn-hover-bg`, `--bs-btn-color`, `--bs-btn-hover-color`, `--bs-btn-border-width` scoped to `.btn-primary`

The `a:hover` background tint (`rgba(99, 17, 17, 0.1)`) stays as a plain rule.

Everything else in `site.css` is untouched: Source Sans Pro on body and headings, `.content` typography, `#content`, `.project`, `.project-featured`, `.book`, `.floater`, `.reading`, `.amazon-book-cover`, `.photo-credit`, `#bio`, `#social`, `footer`, `time`, `.mt-100`, and the global `img` rule.

### 4. Self-hosted Source Sans Pro

Replaces the `//fonts.googleapis.com` stylesheet link with local `@font-face` rules in `site.css`.

**Files.** Fetch Google's stylesheet with a modern browser User-Agent (so it serves woff2), then download the `latin` and `latin-ext` woff2 for each of the four styles already in use — 400 roman, 400 italic, 600 roman, 600 italic. Eight files total, saved to `assets/fonts/` as `source-sans-pro-{weight}{-italic}-{subset}.woff2`.

Latin-ext is included even though no current content needs it (verified: zero latin-ext codepoints across `_posts`, `_reading`, `pages`, `index.markdown`). Because each `@font-face` carries a `unicode-range`, browsers never download the latin-ext files unless a page actually contains those characters — so it costs 4 files in git and nothing at runtime, and a future accented author name in the reading list won't silently fall back to the system sans.

**CSS.** Eight `@font-face` blocks at the top of `site.css`, copied from Google's own output with the `src` rewritten to `/assets/fonts/…` and `unicode-range` preserved verbatim. Each block adds `font-display: swap` so text renders immediately in the fallback and reflows when the font loads.

```css
@font-face {
  font-family: 'Source Sans Pro';
  font-style: normal;
  font-weight: 400;
  font-display: swap;
  src: url('/assets/fonts/source-sans-pro-400-latin.woff2') format('woff2');
  unicode-range: U+0000-00FF, U+0131, U+0152-0153, /* … as published by Google */;
}
```

The existing `body` and `h1–h6` `font-family: 'Source Sans Pro', sans-serif` rules are unchanged. Only 400 and 600 are loaded, matching today — requests for `font-weight: 700` (default heading weight, `.project a`) resolve to the 600 face exactly as they do now.

No `<link rel="preload">`. The `@font-face` rules live in `site.css`, which is already render-blocking and same-origin; a preload would save at most one round trip and is easy to get wrong (a missing `crossorigin` causes a double fetch). Add it later if font loading measurably hurts.

### 5. Accepted visual drift

Consequences of Bootstrap 5 defaults that will not be corrected:

- Headings grow slightly (`h1` is 2.5rem in Bootstrap 5 vs 36px in Bootstrap 3). `.content` already pins `h2`/`h3`/`h4`/`h5` sizes, so this is mostly visible on page titles.
- Base `line-height` is 1.5 vs Bootstrap 3's 1.428. `#content` and `.content` already pin their own, so this affects header and footer only.
- Form controls get Bootstrap 5's larger padding and rounder corners.
- Nav pill padding and hover treatment differ modestly.
- Font loading flashes differently on a cold cache. Google's v1 CSS API omits `font-display`, giving the browser default of block-then-swap (invisible text up to 3s); self-hosting with `font-display: swap` shows fallback text immediately, then reflows. Faster to readable, more visible reflow. Self-hosting is also a shorter fetch — no `googleapis.com` stylesheet round trip before the `gstatic.com` font request.

Anything that reads as *broken* — overlapping elements, unstyled controls, lost layout, illegible contrast — gets fixed. A few pixels of heading drift does not.

## Verification

Capture screenshots before the change and again after, then compare side by side:

**Pages:** home (`/`), one blog post, archives (`/pages/archives.html`), reading list (`/pages/reading.html`), contact (`/pages/contact.html`).

**Widths:** desktop (1280px) and mobile (390px). Mobile matters most for the `col-md` → `col-lg` change.

Method: `bundle exec jekyll serve`, drive Chrome automation against `localhost:4000`, save baseline screenshots to the scratchpad before touching any file.

Also confirm by inspection after the upgrade:

- Contact form submits (the `netlify` attribute and field `name`s are unchanged)
- All five social icons render and link correctly
- No 404s for deleted CSS or font files in the browser network log
- No requests to `fonts.googleapis.com`, `fonts.gstatic.com`, or any CDN in the network log — every asset except the Plausible analytics script is same-origin
- Italic text (`<time>` elements, emphasized body copy) renders in Source Sans Pro italic, not a synthesized oblique — confirms the italic faces loaded

## Out of Scope

- Dark mode / Bootstrap 5.3 color modes
- Typography or layout refresh
- Switching to a different typeface, or to the variable-font successor Source Sans 3
- Adding Bootstrap JavaScript
- Migrating `site.css` to Sass
- Fixing the placeholder values in `_config.yml` (`title: Your awesome title`, etc.)
