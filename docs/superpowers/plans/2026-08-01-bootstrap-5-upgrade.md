# Bootstrap 5 Upgrade Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Replace Bootstrap 3.0.2 with Bootstrap 5.3.8 on aaronsumner.com with minimal visual change, and make every stylesheet, font, and icon same-origin.

**Architecture:** Jekyll static site, no build pipeline. All CSS is hand-committed dist files in `assets/css/`, linked from `_layouts/default.html`. The upgrade swaps one vendored stylesheet, rewrites a handful of Bootstrap class names in five files, self-hosts the webfont, and inlines five SVG icons. No Node, no Sass, no JavaScript is introduced.

**Tech Stack:** Jekyll 4.4, Ruby 3.4.7, Bootstrap 5.3.8 (CSS only), Bootstrap Icons 1.13.1 (SVG paths copied inline, not installed), Netlify.

**Spec:** `docs/superpowers/specs/2026-08-01-bootstrap-5-upgrade-design.md`

---

## A Note on Testing

This repo has no test framework and none is being added — it is a static site whose output is HTML and CSS. "Red/green" here means a **grep or build assertion** that fails before the change and passes after, plus **screenshot comparison** for the visual outcome.

Every task follows the same shape: write the check, run it and watch it fail, make the change, run it and watch it pass, commit. Do not skip the "watch it fail" step — it is what proves the check is actually testing something.

Run every command from the repo root: `/Users/asumner/code/aaronsumner.com`.

---

## File Structure

**Created:**
- `assets/css/bootstrap.min.css` — Bootstrap 5.3.8 dist, unmodified. Never hand-edit; replaced wholesale on future upgrades.
- `assets/fonts/source-sans-pro-*.woff2` — 8 files. Self-hosted webfont binaries.

**Modified:**
- `_layouts/default.html` — stylesheet links, dead ERB, footer nav classes, one grid class.
- `assets/css/site.css` — all site-specific styling. Gains `@font-face` blocks, absorbs two rules from `bootstrap-narrow.css`, and switches `.btn-primary` to Bootstrap 5 custom properties.
- `index.markdown` — grid classes only.
- `pages/contact.html.markdown` — form classes, nav classes, icon markup.

**Deleted:**
- `assets/css/bootstrap.css`, `bootstrap-theme.css`, `bootstrap-narrow.css`, `all.css`, `font-awesome.css`, `font-awesome.min.css`
- All 10 existing files in `assets/fonts/`

**Responsibility split stays as-is:** Bootstrap owns reset + grid + components; `site.css` owns everything specific to this site. That boundary is why `site.css` is not being split — it is 144 lines with one clear job.

---

## Task Order Rationale

Tasks 2, 3, and 4 are independent of the Bootstrap swap and each leaves the site fully working. Do them first so the risky task is as small as possible.

Task 5 must be a **single commit** — deleting Bootstrap 3 and adding Bootstrap 5 cannot be split without leaving an unstyled site in history.

---

## Task 1: Capture Baseline Screenshots

No commit. These artifacts are the "before" side of the visual diff and must be captured before any file changes.

**Files:** none modified.

- [ ] **Step 1: Confirm the working tree is clean**

Run:
```bash
git status --porcelain
```
Expected: no output. If there is output, stop and ask before proceeding.

- [ ] **Step 2: Create the screenshot directory**

Run:
```bash
mkdir -p /private/tmp/claude-501/-Users-asumner-code-aaronsumner-com/7477baac-2f48-4cc8-9005-090160101206/scratchpad/shots/before
```

- [ ] **Step 3: Start the Jekyll server in the background**

Run:
```bash
bundle exec jekyll serve --port 4001
```
Use the Bash tool's `run_in_background: true`. Expected output includes `Server address: http://127.0.0.1:4001/`.

- [ ] **Step 4: Verify the server responds**

Run:
```bash
curl -s -o /dev/null -w '%{http_code}' http://localhost:4001/
```
Expected: `200`

- [ ] **Step 5: Screenshot 5 pages at 2 widths**

Load the Chrome tools in one call:

ToolSearch with query `select:mcp__claude-in-chrome__tabs_context_mcp,mcp__claude-in-chrome__tabs_create_mcp,mcp__claude-in-chrome__navigate,mcp__claude-in-chrome__computer,mcp__claude-in-chrome__resize_window,mcp__claude-in-chrome__read_network_requests`

Call `tabs_context_mcp` first, then `tabs_create_mcp` for a fresh tab. Do not reuse an existing tab.

For each width in `1280x900`, then `390x844`:
  Resize the window, then for each URL, navigate and screenshot:

| URL | Save as (prefix `before/`) |
|---|---|
| `http://localhost:4001/` | `home-{width}.png` |
| `http://localhost:4001/posts/2026/07/july-2026-update` | `post-{width}.png` |
| `http://localhost:4001/pages/archives.html` | `archives-{width}.png` |
| `http://localhost:4001/pages/reading.html` | `reading-{width}.png` |
| `http://localhost:4001/pages/contact.html` | `contact-{width}.png` |

If the post URL 404s, run `ls _posts | tail -1` and derive the URL from the filename using the permalink pattern `/posts/:year/:month/:title`.

10 screenshots total. Keep the Jekyll server running — later tasks reuse it.

- [ ] **Step 6: Confirm all 10 exist**

Run:
```bash
ls /private/tmp/claude-501/-Users-asumner-code-aaronsumner-com/7477baac-2f48-4cc8-9005-090160101206/scratchpad/shots/before | wc -l
```
Expected: `10`

---

## Task 2: Self-Host Source Sans Pro

Removes the `fonts.googleapis.com` dependency. Independent of Bootstrap — the site works identically before and after.

**Files:**
- Create: `assets/fonts/source-sans-pro-*.woff2` (8 files)
- Modify: `assets/css/site.css` (prepend `@font-face` blocks)
- Modify: `_layouts/default.html:14` (remove Google Fonts link)

- [ ] **Step 1: Write the failing check**

Run:
```bash
grep -c 'fonts.googleapis.com' _layouts/default.html
```
Expected now: `1` — this is the thing being removed.

- [ ] **Step 2: Download the 8 woff2 files**

The old `assets/fonts/` contents are deleted in Task 4; leave them alone for now.

Run:
```bash
cd /Users/asumner/code/aaronsumner.com
UA='Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0 Safari/537.36'
B=https://fonts.gstatic.com/s/sourcesanspro/v23

curl -sA "$UA" "$B/6xK3dSBYKcSV-LCoeQqfX1RYOo3qOK7lujVj9w.woff2"           -o assets/fonts/source-sans-pro-400-latin.woff2
curl -sA "$UA" "$B/6xK3dSBYKcSV-LCoeQqfX1RYOo3qNq7lujVj9_mf.woff2"         -o assets/fonts/source-sans-pro-400-latin-ext.woff2
curl -sA "$UA" "$B/6xK1dSBYKcSV-LCoeQqfX1RYOo3qPZ7nsDJB9cme.woff2"         -o assets/fonts/source-sans-pro-400-italic-latin.woff2
curl -sA "$UA" "$B/6xK1dSBYKcSV-LCoeQqfX1RYOo3qPZ7psDJB9cme_xc.woff2"      -o assets/fonts/source-sans-pro-400-italic-latin-ext.woff2
curl -sA "$UA" "$B/6xKydSBYKcSV-LCoeQqfX1RYOo3i54rwlxdu3cOWxw.woff2"       -o assets/fonts/source-sans-pro-600-latin.woff2
curl -sA "$UA" "$B/6xKydSBYKcSV-LCoeQqfX1RYOo3i54rwmRdu3cOWxy40.woff2"     -o assets/fonts/source-sans-pro-600-latin-ext.woff2
curl -sA "$UA" "$B/6xKwdSBYKcSV-LCoeQqfX1RYOo3qPZY4lCds18S0xR41.woff2"     -o assets/fonts/source-sans-pro-600-italic-latin.woff2
curl -sA "$UA" "$B/6xKwdSBYKcSV-LCoeQqfX1RYOo3qPZY4lCdi18S0xR41YDw.woff2"  -o assets/fonts/source-sans-pro-600-italic-latin-ext.woff2
```

- [ ] **Step 3: Verify the downloads are real woff2 files, not error pages**

Run:
```bash
file assets/fonts/source-sans-pro-*.woff2 | grep -c 'Web Open Font Format'
```
Expected: `8`

If any file is under 1KB or reports as HTML/ASCII, the download failed — re-run that `curl`. Do not proceed with a broken font file.

- [ ] **Step 4: Prepend the @font-face blocks to site.css**

Insert at the very top of `assets/css/site.css`, above the existing `/* line 1, ... */` comment:

```css
/* Source Sans Pro, self-hosted. Subset URLs and unicode-ranges taken from
   Google Fonts' own CSS output; font-display: swap added. */

@font-face {
  font-family: 'Source Sans Pro';
  font-style: normal;
  font-weight: 400;
  font-display: swap;
  src: url('/assets/fonts/source-sans-pro-400-latin.woff2') format('woff2');
  unicode-range: U+0000-00FF, U+0131, U+0152-0153, U+02BB-02BC, U+02C6, U+02DA, U+02DC, U+0304, U+0308, U+0329, U+2000-206F, U+20AC, U+2122, U+2191, U+2193, U+2212, U+2215, U+FEFF, U+FFFD;
}

@font-face {
  font-family: 'Source Sans Pro';
  font-style: normal;
  font-weight: 400;
  font-display: swap;
  src: url('/assets/fonts/source-sans-pro-400-latin-ext.woff2') format('woff2');
  unicode-range: U+0100-02BA, U+02BD-02C5, U+02C7-02CC, U+02CE-02D7, U+02DD-02FF, U+0304, U+0308, U+0329, U+1D00-1DBF, U+1E00-1E9F, U+1EF2-1EFF, U+2020, U+20A0-20AB, U+20AD-20C0, U+2113, U+2C60-2C7F, U+A720-A7FF;
}

@font-face {
  font-family: 'Source Sans Pro';
  font-style: italic;
  font-weight: 400;
  font-display: swap;
  src: url('/assets/fonts/source-sans-pro-400-italic-latin.woff2') format('woff2');
  unicode-range: U+0000-00FF, U+0131, U+0152-0153, U+02BB-02BC, U+02C6, U+02DA, U+02DC, U+0304, U+0308, U+0329, U+2000-206F, U+20AC, U+2122, U+2191, U+2193, U+2212, U+2215, U+FEFF, U+FFFD;
}

@font-face {
  font-family: 'Source Sans Pro';
  font-style: italic;
  font-weight: 400;
  font-display: swap;
  src: url('/assets/fonts/source-sans-pro-400-italic-latin-ext.woff2') format('woff2');
  unicode-range: U+0100-02BA, U+02BD-02C5, U+02C7-02CC, U+02CE-02D7, U+02DD-02FF, U+0304, U+0308, U+0329, U+1D00-1DBF, U+1E00-1E9F, U+1EF2-1EFF, U+2020, U+20A0-20AB, U+20AD-20C0, U+2113, U+2C60-2C7F, U+A720-A7FF;
}

@font-face {
  font-family: 'Source Sans Pro';
  font-style: normal;
  font-weight: 600;
  font-display: swap;
  src: url('/assets/fonts/source-sans-pro-600-latin.woff2') format('woff2');
  unicode-range: U+0000-00FF, U+0131, U+0152-0153, U+02BB-02BC, U+02C6, U+02DA, U+02DC, U+0304, U+0308, U+0329, U+2000-206F, U+20AC, U+2122, U+2191, U+2193, U+2212, U+2215, U+FEFF, U+FFFD;
}

@font-face {
  font-family: 'Source Sans Pro';
  font-style: normal;
  font-weight: 600;
  font-display: swap;
  src: url('/assets/fonts/source-sans-pro-600-latin-ext.woff2') format('woff2');
  unicode-range: U+0100-02BA, U+02BD-02C5, U+02C7-02CC, U+02CE-02D7, U+02DD-02FF, U+0304, U+0308, U+0329, U+1D00-1DBF, U+1E00-1E9F, U+1EF2-1EFF, U+2020, U+20A0-20AB, U+20AD-20C0, U+2113, U+2C60-2C7F, U+A720-A7FF;
}

@font-face {
  font-family: 'Source Sans Pro';
  font-style: italic;
  font-weight: 600;
  font-display: swap;
  src: url('/assets/fonts/source-sans-pro-600-italic-latin.woff2') format('woff2');
  unicode-range: U+0000-00FF, U+0131, U+0152-0153, U+02BB-02BC, U+02C6, U+02DA, U+02DC, U+0304, U+0308, U+0329, U+2000-206F, U+20AC, U+2122, U+2191, U+2193, U+2212, U+2215, U+FEFF, U+FFFD;
}

@font-face {
  font-family: 'Source Sans Pro';
  font-style: italic;
  font-weight: 600;
  font-display: swap;
  src: url('/assets/fonts/source-sans-pro-600-italic-latin-ext.woff2') format('woff2');
  unicode-range: U+0100-02BA, U+02BD-02C5, U+02C7-02CC, U+02CE-02D7, U+02DD-02FF, U+0304, U+0308, U+0329, U+1D00-1DBF, U+1E00-1E9F, U+1EF2-1EFF, U+2020, U+20A0-20AB, U+20AD-20C0, U+2113, U+2C60-2C7F, U+A720-A7FF;
}
```

- [ ] **Step 5: Remove the Google Fonts link**

In `_layouts/default.html`, delete this line entirely:

```html
    <link href="//fonts.googleapis.com/css?family=Source+Sans+Pro:400,600,400italic,600italic" rel="stylesheet" />
```

- [ ] **Step 6: Run the check — it should now pass**

Run:
```bash
grep -c 'fonts.googleapis.com' _layouts/default.html; grep -c '@font-face' assets/css/site.css
```
Expected: `0` then `8`

- [ ] **Step 7: Verify the build and the served page**

Run:
```bash
bundle exec jekyll build && curl -s http://localhost:4001/ | grep -c 'googleapis'
```
Expected: build succeeds (`done in N seconds`), then `0`.

Note: `grep -c` exits non-zero on zero matches, so this command reports failure while printing `0`. The printed `0` is the pass condition.

- [ ] **Step 8: Visually confirm the font still loads**

Reload `http://localhost:4001/` in the Chrome tab and screenshot it. Body text must still be Source Sans Pro (humanist sans with a distinctive single-story `g`), not a system fallback. If it looks like Helvetica or Arial, the `@font-face` paths are wrong — check the browser network log for 404s under `/assets/fonts/`.

- [ ] **Step 9: Commit**

```bash
git add assets/fonts/source-sans-pro-*.woff2 assets/css/site.css _layouts/default.html
git commit -m "Self-host Source Sans Pro instead of loading from Google Fonts"
```

---

## Task 3: Replace Font Awesome Icons With Bootstrap Icons

Independent of Bootstrap core. All five icons live in one block on the contact page.
Bootstrap Icons is a webfont with the same `<i class="...">` usage shape as Font
Awesome, so this is a mechanical class swap plus a vendored stylesheet and font file.

**Files:**
- Add: `assets/css/bootstrap-icons.min.css`, `assets/css/fonts/bootstrap-icons.woff2`
- Modify: `pages/contact.html.markdown` (the `#social` block)
- Modify: `_layouts/default.html` (swap the Font Awesome link for the Bootstrap Icons link)
- Modify: `assets/css/site.css` (size the icons)
- Delete: `assets/css/font-awesome.css`, `assets/css/font-awesome.min.css`

- [ ] **Step 1: Write the failing check**

Run:
```bash
grep -c 'class="fa ' pages/contact.html.markdown
```
Expected now: `5`

- [ ] **Step 2: Vendor the Bootstrap Icons dist**

```bash
cd /tmp
curl -sLO https://github.com/twbs/icons/releases/download/v1.13.1/bootstrap-icons-1.13.1.zip
unzip -qo bootstrap-icons-1.13.1.zip -d bi
cd -
mkdir -p assets/css/fonts
cp /tmp/bi/bootstrap-icons-1.13.1/bootstrap-icons.min.css assets/css/bootstrap-icons.min.css
cp /tmp/bi/bootstrap-icons-1.13.1/fonts/bootstrap-icons.woff2 assets/css/fonts/bootstrap-icons.woff2
```

The stylesheet is vendored unmodified. It references the font as a relative
`fonts/bootstrap-icons.woff2` URL, which is why the font goes under `assets/css/`
rather than `assets/fonts/` — keeping the vendor layout means no edits to the
vendored file. The `.woff` fallback is deliberately not copied; every browser that
supports this site supports woff2, and the fallback URL is never requested when the
woff2 loads.

Expected sizes: `bootstrap-icons.min.css` 87008 bytes, `bootstrap-icons.woff2` 134044 bytes.

- [ ] **Step 3: Replace the `#social` block**

In `pages/contact.html.markdown`, replace the entire block from `<div id="social">` through its closing `</div>` with:

```html
<div id="social">
  <ul class="nav nav-pills">
    <li class="nav-item">
      <a class="nav-link" href="https://github.com/ruralocity" aria-label="GitHub">
        <i class="bi bi-github" aria-hidden="true"></i>
      </a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="https://instagram.com/ruralocity" aria-label="Instagram">
        <i class="bi bi-instagram" aria-hidden="true"></i>
      </a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="https://flickr.com/photos/rockchalk" aria-label="Flickr">
        <i class="bi bi-camera" aria-hidden="true"></i>
      </a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="https://linkedin.com/in/asumner" aria-label="LinkedIn">
        <i class="bi bi-linkedin" aria-hidden="true"></i>
      </a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="/atom.xml" aria-label="RSS">
        <i class="bi bi-rss" aria-hidden="true"></i>
      </a>
    </li>
  </ul>
</div>
```

Bootstrap Icons ships no Flickr glyph (verified: `grep -c '\.bi-flickr::before'` on the
vendored stylesheet returns `0`), so Flickr uses the generic `bi-camera`.

Note this markup already carries the `nav-item` / `nav-link` classes Bootstrap 5 needs. Under Bootstrap 3 those classes are inert, so the page renders the same today. Task 5 does not need to revisit this block.

- [ ] **Step 4: Swap the stylesheet link**

In `_layouts/default.html`, delete this line:

```html
    <link href="/assets/css/font-awesome.css" rel="stylesheet" />
```

and add this one directly above the `site.css` link, so `site.css` still wins on cascade ties:

```html
    <link href="/assets/css/bootstrap-icons.min.css" rel="stylesheet" />
```

- [ ] **Step 5: Size the icons in `site.css`**

Font Awesome's `fa-2x` badges rendered as 32px squares. Bootstrap Icons has no size
class, and its glyphs fill only about 0.62em (measured: 19px tall at `2rem`, 40px at
`4rem`), so `2.5rem` is what lands near the old footprint. Add this inside the existing
`#social` group in `assets/css/site.css`, right after the `#social a:hover` rule:

```css
  /* Bootstrap Icons glyphs fill about 0.62em, so 2.5rem lands near the 32px
     footprint the old Font Awesome fa-2x badges had. */
  #social .bi {
    font-size: 2.5rem; }
```

Under Bootstrap 3 the glyphs inherit their maroon color from the existing `a { color: #631111 }` rule, exactly as the Font Awesome ones did. Bootstrap 5 breaks that inheritance — see Task 5, which sets `--bs-nav-link-color` to restore it.

- [ ] **Step 6: Delete the Font Awesome CSS**

```bash
git rm assets/css/font-awesome.css assets/css/font-awesome.min.css
```

- [ ] **Step 7: Run the check — it should now pass**

Run:
```bash
grep -c 'class="fa ' pages/contact.html.markdown; grep -c 'font-awesome' _layouts/default.html; ls assets/css/
```
Expected: `0`, then `0`, then a listing with `bootstrap-icons.min.css` and no `font-awesome` entries.

- [ ] **Step 8: Verify visually**

```bash
bundle exec jekyll build
curl -s -o /dev/null -w '%{http_code}\n' http://localhost:4001/assets/css/bootstrap-icons.min.css
curl -s -o /dev/null -w '%{http_code}\n' http://localhost:4001/assets/css/fonts/bootstrap-icons.woff2
grep -o 'bi bi-[a-z]*' _site/pages/contact.html.html
```
Expected: `200`, `200`, then the five classes `bi-github`, `bi-instagram`, `bi-camera`, `bi-linkedin`, `bi-rss`.

Then screenshot `http://localhost:4001/pages/contact.html`. All five icons must render
in maroon at roughly their previous size. They will look different from the baseline —
bare marks instead of solid maroon squares, and a camera for Flickr. That is expected
and accepted; see the spec's drift section.

- [ ] **Step 9: Commit**

```bash
git add pages/contact.html.markdown _layouts/default.html assets/css/site.css \
        assets/css/bootstrap-icons.min.css assets/css/fonts/bootstrap-icons.woff2
git commit -m "Replace Font Awesome with Bootstrap Icons"
```

---

## Task 4: Delete Dead Assets

Files linked from nowhere. Verified in the spec: no markup or CSS references `all.css`, `bootstrap-theme`, `cc-icons`, or any `glyphicon` class.

**Files:**
- Delete: `assets/css/all.css`, `assets/css/bootstrap-theme.css`, all remaining files in `assets/fonts/`

- [ ] **Step 1: Re-verify nothing references them**

Run:
```bash
grep -rn 'all\.css\|bootstrap-theme\|cc-icons\|glyphicon\|fontawesome-webfont\|glyphicons-halflings' \
  _layouts pages index.markdown 404.html.markdown _posts _reading assets/css/site.css; echo "exit=$?"
```
Expected: no matches, `exit=1`. If anything matches, stop — the file is in use.

- [ ] **Step 2: Delete them**

```bash
git rm assets/css/all.css assets/css/bootstrap-theme.css
git rm assets/fonts/fontawesome-webfont.* assets/fonts/FontAwesome.otf \
       assets/fonts/glyphicons-halflings-regular.* assets/fonts/cc-icons.ttf
```

- [ ] **Step 3: Verify only the new fonts remain**

Run:
```bash
ls assets/fonts/
```
Expected: exactly the 8 `source-sans-pro-*.woff2` files, nothing else.

- [ ] **Step 4: Verify the build still works**

Run:
```bash
bundle exec jekyll build && curl -s -o /dev/null -w '%{http_code}\n' http://localhost:4001/
```
Expected: build succeeds, then `200`.

- [ ] **Step 5: Commit**

```bash
git commit -m "Delete unreferenced CSS and webfont files"
```

---

## Task 5: Swap Bootstrap 3 for Bootstrap 5

**Single atomic commit.** Splitting this leaves an unstyled site in the history.

**Files:**
- Create: `assets/css/bootstrap.min.css`
- Delete: `assets/css/bootstrap.css`, `assets/css/bootstrap-narrow.css`
- Modify: `_layouts/default.html`, `index.markdown`, `pages/contact.html.markdown`, `assets/css/site.css`

- [ ] **Step 1: Write the failing check**

Run:
```bash
head -2 assets/css/bootstrap.css | grep -o 'v[0-9.]*'
```
Expected now: `v3.0.2`

- [ ] **Step 2: Download Bootstrap 5.3.8**

```bash
curl -sL https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css \
  -o assets/css/bootstrap.min.css
```

Verify it is real CSS, not an error page:
```bash
head -c 120 assets/css/bootstrap.min.css
```
Expected: a comment beginning `/*! Bootstrap v5.3.8`.

- [ ] **Step 3: Delete the Bootstrap 3 files**

```bash
git rm assets/css/bootstrap.css assets/css/bootstrap-narrow.css
```

- [ ] **Step 4: Update the stylesheet links**

In `_layouts/default.html`, replace these two lines:

```html
    <link href="/assets/css/bootstrap.css" rel="stylesheet" />
    <link href="/assets/css/bootstrap-narrow.css" rel="stylesheet" />
```

with this one:

```html
    <link href="/assets/css/bootstrap.min.css" rel="stylesheet" />
```

`site.css` must remain the **last** stylesheet link — its overrides depend on load order.

- [ ] **Step 5: Remove the dead Middleman ERB**

In `_layouts/default.html`, replace:

```html
  <body class="<%= page_classes %>">
```

with:

```html
  <body>
```

- [ ] **Step 6: Update the footer nav**

In `_layouts/default.html`, replace the footer `<ul>` with:

```html
      <ul class="nav nav-pills">
        <li class="nav-item"><a class="nav-link" href="/">Home</a></li>
        <li class="nav-item"><a class="nav-link" href="/pages/archives.html">Archives</a></li>
        <li class="nav-item"><a class="nav-link" href="/pages/books.html">Books</a></li>
        <li class="nav-item"><a class="nav-link" href="/pages/reading.html">Reading</a></li>
        <li class="nav-item"><a class="nav-link" href="/pages/colophon.html">Colophon</a></li>
        <li class="nav-item"><a class="nav-link" href="/pages/license.html">License</a></li>
        <li class="nav-item"><a class="nav-link" href="/atom.xml">Feed</a></li>
        <li class="nav-item"><a class="nav-link" href="/pages/contact.html">Contact</a></li>
      </ul>
```

- [ ] **Step 7: Rename grid classes**

Bootstrap 3's `md` breakpoint is 992px; Bootstrap 5's is 768px. `col-lg-*` in Bootstrap 5 is 992px, preserving current behavior.

```bash
sed -i '' 's/col-md-/col-lg-/g' index.markdown _layouts/default.html
```

Verify:
```bash
grep -c 'col-md-' index.markdown _layouts/default.html; grep -c 'col-lg-' index.markdown _layouts/default.html
```
Expected: both files `0` for `col-md-`; `index.markdown:7` and `_layouts/default.html:1` for `col-lg-`.

- [ ] **Step 8: Update the contact form classes**

In `pages/contact.html.markdown`, replace the entire `<form>` element with:

```html
<form name="contact" method="POST" netlify action="/pages/thanks.html">
  <div class="mb-3">
    <label for="name" class="form-label">Your name:</label>
    <input type="text" name="name" class="form-control" />
  </div>
  <div class="mb-3">
    <label for="email" class="form-label form-email">Your email address:</label>
    <input type="email" name="email" class="form-control" />
    <small id="emailHelp" class="form-text text-muted">Never shared, just so I can respond to you.</small>
  </div>
  <div class="mb-3">
    <label for="message" class="form-label">Message:</label>
    <textarea name="message" class="form-control" rows="6"></textarea>
    <small id="messageHelp" class="form-text text-muted">Be polite.</small>
  </div>

  <button type="submit" class="btn btn-primary">Send message</button>
</form>
```

The `netlify` attribute, the `name` attributes, and the `action` are unchanged — changing any of them would break form submissions.

- [ ] **Step 9: Fix link underlines in site.css**

Bootstrap 5's reboot hardcodes `a { text-decoration: underline }`. Bootstrap 3 did not underline links.

In `assets/css/site.css`, replace:

```css
a {
  color: #631111;
  transition: background-color 0.2s ease; }
```

with:

```css
a {
  color: #631111;
  text-decoration: none;
  transition: background-color 0.2s ease; }
```

The existing `#content a { text-decoration: underline; }` rule keeps body-copy links underlined. Do not attempt to use `--bs-link-decoration` — that variable is declared in 5.3.8 but referenced nowhere, so setting it does nothing.

- [ ] **Step 10: Absorb the narrow-container rules into site.css**

`bootstrap-narrow.css` is deleted; these are its only two live rules. Its other rules target `.jumbotron`, `.marketing`, `.header`, `.footer`, and `.container-narrow`, none of which appear in any markup.

Add to `assets/css/site.css`, immediately after the `@font-face` blocks and before the existing `body { font-family: ... }` rule:

```css
/* Absorbed from bootstrap-narrow.css */
body {
  padding-top: 20px;
  padding-bottom: 20px; }

@media (min-width: 768px) {
  .container {
    max-width: 730px; } }
```

- [ ] **Step 11: Convert .btn-primary to Bootstrap 5 custom properties**

Bootstrap 5 drives every button state from `--bs-btn-*` variables, including the focus ring — which stays Bootstrap blue if only `background-color` is overridden.

In `assets/css/site.css`, replace both `.btn-primary` blocks. Note that `site.css` carries interleaved `/* line NN, ... */` comments left over from its Middleman-era Sass compilation — there is one between these two blocks. Delete it along with them.

```css
.btn-primary {
  background-color: #631111;
  color: #fff;
  text-decoration: none;
  border: 0; }
  .btn-primary:hover {
    background-color: #993333;
    color: #fff;
    text-decoration: none;
    border: 0; }
```

with a single variable block:

```css
.btn-primary {
  --bs-btn-color: #fff;
  --bs-btn-bg: #631111;
  --bs-btn-border-color: #631111;
  --bs-btn-hover-color: #fff;
  --bs-btn-hover-bg: #993333;
  --bs-btn-hover-border-color: #993333;
  --bs-btn-active-color: #fff;
  --bs-btn-active-bg: #993333;
  --bs-btn-active-border-color: #993333;
  --bs-btn-focus-shadow-rgb: 99, 17, 17;
  text-decoration: none; }
```

- [ ] **Step 11b: Restore maroon nav links**

`.nav-link` does not inherit its color. Bootstrap 5 sets `color: var(--bs-nav-link-color)`,
which defaults to `var(--bs-link-color)` (`#0d6efd`), and `.nav-link` outranks a bare `a`
selector on specificity — so the `a { color: #631111 }` rule does not reach the footer nav
or the social icon row. Both render Bootstrap blue without this.

Verified in the dist:
```
.nav{--bs-nav-link-color:var(--bs-link-color);--bs-nav-link-hover-color:var(--bs-link-hover-color);...}
.nav-link{...color:var(--bs-nav-link-color);...}
```

Bootstrap declares these on `.nav`, so set them there — equal specificity, and `site.css`
loads second. Add to `assets/css/site.css`, immediately before the `.btn-primary` block:

```css
/* Bootstrap 5 colors .nav-link from its own variables rather than inheriting,
   and .nav-link outranks the plain `a` rule above on specificity. Set the
   variables where Bootstrap declares them, on .nav. */
.nav {
  --bs-nav-link-color: #631111;
  --bs-nav-link-hover-color: #993333; }
```

- [ ] **Step 12: Build and check for regressions**

Run:
```bash
bundle exec jekyll build
grep -o 'v5\.3\.8' assets/css/bootstrap.min.css | head -1
grep -c 'page_classes\|form-group\|nav-justify\|col-md-' _layouts/default.html index.markdown pages/contact.html.markdown
```
Expected: build succeeds; `v5.3.8`; `0` for all three files.

- [ ] **Step 13: Confirm the site serves**

Run:
```bash
for p in / /pages/archives.html /pages/reading.html /pages/contact.html /pages/books.html; do
  printf '%s ' "$p"; curl -s -o /dev/null -w '%{http_code}\n' "http://localhost:4001$p"
done
```
Expected: `200` for all five.

- [ ] **Step 14: Commit**

```bash
git add assets/css/bootstrap.min.css assets/css/site.css _layouts/default.html index.markdown pages/contact.html.markdown
git commit -m "Upgrade Bootstrap 3.0.2 to 5.3.8"
```

---

## Task 6: Compare Screenshots and Fix Real Breakage

**Files:**
- Modify: `assets/css/site.css` — the only file this task may change. If a fix seems to require touching markup or `bootstrap.min.css`, stop and raise it.

- [ ] **Step 1: Capture the "after" screenshots**

```bash
mkdir -p /private/tmp/claude-501/-Users-asumner-code-aaronsumner-com/7477baac-2f48-4cc8-9005-090160101206/scratchpad/shots/after
```

Repeat Task 1 Step 5 exactly — same 5 URLs, same 2 widths, same filenames — saving into `shots/after/` instead.

- [ ] **Step 2: Compare each pair**

Read the before and after images for each of the 10 pairs and compare them directly.

**Fix these** — they are breakage:
- Overlapping or clipped elements
- Unstyled form controls or nav items
- Columns stacking or unstacking at the wrong width
- Missing or wrongly-sized icons
- Text unreadable against its background
- The maroon link/button color lost anywhere

**Do not fix these** — accepted drift per the spec:
- Headings a few pixels larger
- Slightly different spacing in header and footer
- Rounder, roomier form controls
- Modest nav pill padding differences

- [ ] **Step 3: Fix anything in the "fix" list**

Add targeted rules to `assets/css/site.css` only. Do not add a Bootstrap 3 compatibility layer — the point of the upgrade is to stop carrying one. If a fix starts looking like a compatibility shim, stop and raise it instead.

If nothing needs fixing, skip to Step 5.

- [ ] **Step 4: Re-screenshot and re-compare the affected pages**

Rebuild, reload, screenshot the pages you changed, and confirm the fix landed without breaking the others.

- [ ] **Step 5: Commit any fixes**

```bash
git add assets/css/site.css
git commit -m "Fix layout regressions from Bootstrap 5 upgrade"
```

Skip this step if there was nothing to fix.

---

## Task 7: Final Verification

**Files:** none modified.

- [ ] **Step 1: Confirm every asset is same-origin**

With `http://localhost:4001/pages/contact.html` loaded, read the browser network log.

Expected: every request is to `localhost:4001` except `plausible.io` (analytics, intentionally third-party). Specifically **zero** requests to `fonts.googleapis.com`, `fonts.gstatic.com`, or `cdn.jsdelivr.net`.

- [ ] **Step 2: Confirm no 404s**

Same network log. Every request returns `200`. A 404 under `/assets/` means a deleted file is still referenced.

- [ ] **Step 3: Confirm the italic faces load**

On `http://localhost:4001/`, the `<time>` elements next to recent post titles must render in a true Source Sans Pro italic — genuinely cursive letterforms, not an algorithmically slanted upright. If it looks mechanically sheared, the italic `@font-face` blocks are not matching.

- [ ] **Step 4: Confirm the contact form is intact**

Run:
```bash
grep -o 'name="[a-z]*"\|netlify\|action="[^"]*"' _site/pages/contact.html.html
```
Expected output includes `name="contact"`, `netlify`, `action="/pages/thanks.html"`, `name="name"`, `name="email"`, `name="message"`.

Do not submit the form — that would post to the live Netlify endpoint.

- [ ] **Step 5: Confirm nothing stale is left**

Run:
```bash
ls assets/css/ assets/fonts/
```
Expected: `assets/css/` holds exactly `bootstrap.min.css` and `site.css`. `assets/fonts/` holds exactly the 8 `source-sans-pro-*.woff2` files.

- [ ] **Step 6: Clean build from scratch**

Run:
```bash
rm -rf _site .jekyll-cache && bundle exec jekyll build
```
Expected: build succeeds with no warnings about missing files.

- [ ] **Step 7: Stop the background Jekyll server**

Stop the background shell started in Task 1.

- [ ] **Step 8: Confirm the tree is clean**

Run:
```bash
git status --porcelain
```
Expected: no output. `_site` and `.jekyll-cache` are gitignored.

---

## Rollback

Every task is its own commit and the site deploys from `main` via Netlify. To undo the whole upgrade:

```bash
git revert --no-commit <task-5-sha>..HEAD && git commit -m "Revert Bootstrap 5 upgrade"
```

Netlify also keeps previous deploys — an instant rollback is available in its UI if a problem surfaces after deploying.
