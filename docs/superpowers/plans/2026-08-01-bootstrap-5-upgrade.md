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
bundle exec jekyll serve --port 4000
```
Use the Bash tool's `run_in_background: true`. Expected output includes `Server address: http://127.0.0.1:4000/`.

- [ ] **Step 4: Verify the server responds**

Run:
```bash
curl -s -o /dev/null -w '%{http_code}' http://localhost:4000/
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
| `http://localhost:4000/` | `home-{width}.png` |
| `http://localhost:4000/posts/2026/07/july-2026-update` | `post-{width}.png` |
| `http://localhost:4000/pages/archives.html` | `archives-{width}.png` |
| `http://localhost:4000/pages/reading.html` | `reading-{width}.png` |
| `http://localhost:4000/pages/contact.html` | `contact-{width}.png` |

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
bundle exec jekyll build && curl -s http://localhost:4000/ | grep -c 'googleapis'
```
Expected: build succeeds (`done in N seconds`), then `0`.

Note: `grep -c` exits non-zero on zero matches, so this command reports failure while printing `0`. The printed `0` is the pass condition.

- [ ] **Step 8: Visually confirm the font still loads**

Reload `http://localhost:4000/` in the Chrome tab and screenshot it. Body text must still be Source Sans Pro (humanist sans with a distinctive single-story `g`), not a system fallback. If it looks like Helvetica or Arial, the `@font-face` paths are wrong — check the browser network log for 404s under `/assets/fonts/`.

- [ ] **Step 9: Commit**

```bash
git add assets/fonts/source-sans-pro-*.woff2 assets/css/site.css _layouts/default.html
git commit -m "Self-host Source Sans Pro instead of loading from Google Fonts"
```

---

## Task 3: Replace Font Awesome Icons With Inline SVG

Independent of Bootstrap. All five icons live in one block on the contact page.

**Files:**
- Modify: `pages/contact.html.markdown` (the `#social` block)
- Modify: `_layouts/default.html` (remove the Font Awesome stylesheet link)
- Delete: `assets/css/font-awesome.css`, `assets/css/font-awesome.min.css`

- [ ] **Step 1: Write the failing check**

Run:
```bash
grep -c 'class="fa ' pages/contact.html.markdown
```
Expected now: `5`

- [ ] **Step 2: Replace the `#social` block**

In `pages/contact.html.markdown`, replace the entire block from `<div id="social">` through its closing `</div>` with:

```html
<div id="social">
  <ul class="nav nav-pills">
    <li class="nav-item">
      <a class="nav-link" href="https://github.com/ruralocity" aria-label="GitHub">
        <svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" fill="currentColor" viewBox="0 0 16 16" aria-hidden="true" focusable="false"><path d="M8 0C3.58 0 0 3.58 0 8c0 3.54 2.29 6.53 5.47 7.59.4.07.55-.17.55-.38 0-.19-.01-.82-.01-1.49-2.01.37-2.53-.49-2.69-.94-.09-.23-.48-.94-.82-1.13-.28-.15-.68-.52-.01-.53.63-.01 1.08.58 1.23.82.72 1.21 1.87.87 2.33.66.07-.52.28-.87.51-1.07-1.78-.2-3.64-.89-3.64-3.95 0-.87.31-1.59.82-2.15-.08-.2-.36-1.02.08-2.12 0 0 .67-.21 2.2.82.64-.18 1.32-.27 2-.27s1.36.09 2 .27c1.53-1.04 2.2-.82 2.2-.82.44 1.1.16 1.92.08 2.12.51.56.82 1.27.82 2.15 0 3.07-1.87 3.75-3.65 3.95.29.25.54.73.54 1.48 0 1.07-.01 1.93-.01 2.2 0 .21.15.46.55.38A8.01 8.01 0 0 0 16 8c0-4.42-3.58-8-8-8"/></svg>
      </a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="https://instagram.com/ruralocity" aria-label="Instagram">
        <svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" fill="currentColor" viewBox="0 0 16 16" aria-hidden="true" focusable="false"><path d="M8 0C5.829 0 5.556.01 4.703.048 3.85.088 3.269.222 2.76.42a3.9 3.9 0 0 0-1.417.923A3.9 3.9 0 0 0 .42 2.76C.222 3.268.087 3.85.048 4.7.01 5.555 0 5.827 0 8.001c0 2.172.01 2.444.048 3.297.04.852.174 1.433.372 1.942.205.526.478.972.923 1.417.444.445.89.719 1.416.923.51.198 1.09.333 1.942.372C5.555 15.99 5.827 16 8 16s2.444-.01 3.298-.048c.851-.04 1.434-.174 1.943-.372a3.9 3.9 0 0 0 1.416-.923c.445-.445.718-.891.923-1.417.197-.509.332-1.09.372-1.942C15.99 10.445 16 10.173 16 8s-.01-2.445-.048-3.299c-.04-.851-.175-1.433-.372-1.941a3.9 3.9 0 0 0-.923-1.417A3.9 3.9 0 0 0 13.24.42c-.51-.198-1.092-.333-1.943-.372C10.443.01 10.172 0 7.998 0zm-.717 1.442h.718c2.136 0 2.389.007 3.232.046.78.035 1.204.166 1.486.275.373.145.64.319.92.599s.453.546.598.92c.11.281.24.705.275 1.485.039.843.047 1.096.047 3.231s-.008 2.389-.047 3.232c-.035.78-.166 1.203-.275 1.485a2.5 2.5 0 0 1-.599.919c-.28.28-.546.453-.92.598-.28.11-.704.24-1.485.276-.843.038-1.096.047-3.232.047s-2.39-.009-3.233-.047c-.78-.036-1.203-.166-1.485-.276a2.5 2.5 0 0 1-.92-.598 2.5 2.5 0 0 1-.6-.92c-.109-.281-.24-.705-.275-1.485-.038-.843-.046-1.096-.046-3.233s.008-2.388.046-3.231c.036-.78.166-1.204.276-1.486.145-.373.319-.64.599-.92s.546-.453.92-.598c.282-.11.705-.24 1.485-.276.738-.034 1.024-.044 2.515-.045zm4.988 1.328a.96.96 0 1 0 0 1.92.96.96 0 0 0 0-1.92m-4.27 1.122a4.109 4.109 0 1 0 0 8.217 4.109 4.109 0 0 0 0-8.217m0 1.441a2.667 2.667 0 1 1 0 5.334 2.667 2.667 0 0 1 0-5.334"/></svg>
      </a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="https://flickr.com/photos/rockchalk" aria-label="Flickr">
        <svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" fill="currentColor" viewBox="0 0 16 16" aria-hidden="true" focusable="false"><circle cx="4.6" cy="8" r="3.2"/><circle cx="11.4" cy="8" r="3.2"/></svg>
      </a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="https://linkedin.com/in/asumner" aria-label="LinkedIn">
        <svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" fill="currentColor" viewBox="0 0 16 16" aria-hidden="true" focusable="false"><path d="M0 1.146C0 .513.526 0 1.175 0h13.65C15.474 0 16 .513 16 1.146v13.708c0 .633-.526 1.146-1.175 1.146H1.175C.526 16 0 15.487 0 14.854zm4.943 12.248V6.169H2.542v7.225zm-1.2-8.212c.837 0 1.358-.554 1.358-1.248-.015-.709-.52-1.248-1.342-1.248S2.4 3.226 2.4 3.934c0 .694.521 1.248 1.327 1.248zm4.908 8.212V9.359c0-.216.016-.432.08-.586.173-.431.568-.878 1.232-.878.869 0 1.216.662 1.216 1.634v3.865h2.401V9.25c0-2.22-1.184-3.252-2.764-3.252-1.274 0-1.845.7-2.165 1.193v.025h-.016l.016-.025V6.169h-2.4c.03.678 0 7.225 0 7.225z"/></svg>
      </a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="/atom.xml" aria-label="RSS">
        <svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" fill="currentColor" viewBox="0 0 16 16" aria-hidden="true" focusable="false"><path d="M2 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2zm1.5 2.5c5.523 0 10 4.477 10 10a1 1 0 1 1-2 0 8 8 0 0 0-8-8 1 1 0 0 1 0-2m0 4a6 6 0 0 1 6 6 1 1 0 1 1-2 0 4 4 0 0 0-4-4 1 1 0 0 1 0-2m.5 7a1.5 1.5 0 1 1 0-3 1.5 1.5 0 0 1 0 3"/></svg>
      </a>
    </li>
  </ul>
</div>
```

Note this markup already carries the `nav-item` / `nav-link` classes Bootstrap 5 needs. Under Bootstrap 3 those classes are inert, so the page renders the same today. Task 5 does not need to revisit this block.

- [ ] **Step 3: Remove the Font Awesome stylesheet link**

In `_layouts/default.html`, delete this line entirely:

```html
    <link href="/assets/css/font-awesome.css" rel="stylesheet" />
```

- [ ] **Step 4: Delete the Font Awesome CSS**

```bash
git rm assets/css/font-awesome.css assets/css/font-awesome.min.css
```

- [ ] **Step 5: Run the check — it should now pass**

Run:
```bash
grep -c 'class="fa ' pages/contact.html.markdown; grep -c 'font-awesome' _layouts/default.html; ls assets/css/
```
Expected: `0`, then `0`, then a listing with no `font-awesome` entries.

- [ ] **Step 6: Verify visually**

Run `bundle exec jekyll build`, then reload `http://localhost:4000/pages/contact.html` and screenshot it. All five icons must render in maroon at roughly their previous size. Check the browser network log shows no request for `fontawesome-webfont.*`.

- [ ] **Step 7: Commit**

```bash
git add pages/contact.html.markdown _layouts/default.html
git commit -m "Replace Font Awesome icons with inline SVG"
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
bundle exec jekyll build && curl -s -o /dev/null -w '%{http_code}\n' http://localhost:4000/
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
  printf '%s ' "$p"; curl -s -o /dev/null -w '%{http_code}\n' "http://localhost:4000$p"
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

With `http://localhost:4000/pages/contact.html` loaded, read the browser network log.

Expected: every request is to `localhost:4000` except `plausible.io` (analytics, intentionally third-party). Specifically **zero** requests to `fonts.googleapis.com`, `fonts.gstatic.com`, or `cdn.jsdelivr.net`.

- [ ] **Step 2: Confirm no 404s**

Same network log. Every request returns `200`. A 404 under `/assets/` means a deleted file is still referenced.

- [ ] **Step 3: Confirm the italic faces load**

On `http://localhost:4000/`, the `<time>` elements next to recent post titles must render in a true Source Sans Pro italic — genuinely cursive letterforms, not an algorithmically slanted upright. If it looks mechanically sheared, the italic `@font-face` blocks are not matching.

- [ ] **Step 4: Confirm the contact form is intact**

Run:
```bash
grep -o 'name="[a-z]*"\|netlify\|action="[^"]*"' _site/pages/contact.html
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
