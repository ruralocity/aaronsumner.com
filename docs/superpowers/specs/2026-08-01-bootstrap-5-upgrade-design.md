# Bootstrap 3.0.2 → 5.3.8 Upgrade

**Date:** 2026-08-01
**Goal:** Move to current Bootstrap with as little visual change as possible, so future work can use modern Bootstrap utilities.

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
| Fidelity | "Close enough" | Accept small heading/spacing drift from Bootstrap 5 defaults. Do not add compatibility CSS that fights the framework. Fix anything that reads as broken. |
| Verification | Automated before/after screenshots | Catches regressions on pages easy to forget. |
| JavaScript | None | No JS components in use. Ship CSS only. |

## Changes

### 1. Stylesheet files

**Delete:**

- `assets/css/bootstrap.css` (3.0.2)
- `assets/css/bootstrap-theme.css` — linked nowhere
- `assets/css/bootstrap-narrow.css` — three live rules move to `site.css` (see §3)
- `assets/css/all.css` — Middleman scaffold leftover, linked nowhere
- `assets/css/font-awesome.css`, `assets/css/font-awesome.min.css`
- `assets/fonts/` (entire directory: glyphicons, Font Awesome webfonts, `cc-icons`)

Verified: no markup or CSS in `_layouts`, `pages`, `index.markdown`, `404.html.markdown`, `_posts`, `_reading`, or `site.css` references `all.css`, `bootstrap-theme`, `cc-icons`, or any `glyphicon` class.

**Add:**

- `assets/css/bootstrap.min.css` — Bootstrap 5.3.8 dist, unmodified

**Result** — `_layouts/default.html` `<head>` carries three stylesheet links:

```html
<link href="/assets/css/bootstrap.min.css" rel="stylesheet" />
<link href="//fonts.googleapis.com/css?family=Source+Sans+Pro:400,600,400italic,600italic" rel="stylesheet" />
<link href="/assets/css/site.css" rel="stylesheet" />
```

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

Three additions. No compatibility layer, no pinning of Bootstrap 5 defaults back to Bootstrap 3 values.

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

### 4. Accepted visual drift

Consequences of Bootstrap 5 defaults that will not be corrected:

- Headings grow slightly (`h1` is 2.5rem in Bootstrap 5 vs 36px in Bootstrap 3). `.content` already pins `h2`/`h3`/`h4`/`h5` sizes, so this is mostly visible on page titles.
- Base `line-height` is 1.5 vs Bootstrap 3's 1.428. `#content` and `.content` already pin their own, so this affects header and footer only.
- Form controls get Bootstrap 5's larger padding and rounder corners.
- Nav pill padding and hover treatment differ modestly.

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

## Out of Scope

- Dark mode / Bootstrap 5.3 color modes
- Typography or layout refresh
- Replacing the Google Fonts link with self-hosted fonts
- Adding Bootstrap JavaScript
- Migrating `site.css` to Sass
- Fixing the placeholder values in `_config.yml` (`title: Your awesome title`, etc.)
