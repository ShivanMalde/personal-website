# AGENTS.md

## Project purpose

This is a personal website for Shivan Malde, a DevOps Manager and Platform Engineer based in London.

It serves two purposes:
1. Online CV - work history, skills, education, and technical proficiencies
2. Consulting advertisement - services offered, how engagements work, and a contact/intake form for prospective clients

The live site is at `shivanmalde.com`.

---

## Tech stack

- Static site generator: [Hugo](https://gohugo.io/)
- Theme: [Blowfish](https://blowfish.page/) (located in `themes/blowfish/`)
- Deployment: Azure Static Web Apps (infrastructure defined in `../deploy/`)
- Contact form: Nextcloud Forms (embedded via iframe shortcode)

---

## Content pages

| File | Purpose |
|---|---|
| `content/_index.md` | Homepage - hero text, "How I Work" columns, CTA button |
| `content/about.md` | Full CV - bio, experience timeline, education, skills, tech proficiencies |
| `content/services.md` | Services offered, deliverables, how engagements work, FAQ |
| `content/intake.md` | Intake/contact form (embedded Nextcloud form) |

---

## Custom shortcodes

These are defined in `layouts/shortcodes/` and used in content markdown files. Do not use raw HTML in content files - use shortcodes instead.

### `{{< service-card >}}`
A styled card for displaying a consulting service offering.

```
{{< service-card
  title="Service Title"
  subtitle="Tagline or hook"
  badge="Optional badge text"
>}}
Card body content (markdown supported).
{{< /service-card >}}
```

Must be nested inside `{{< services-grid >}}`.

### `{{< services-grid >}}`
A responsive CSS grid wrapper for service cards.

```
{{< services-grid cols="3" >}}
  {{< service-card ... >}}...{{< /service-card >}}
{{< /services-grid >}}
```

### `{{< columns >}}` / `{{< column >}}`
A CSS grid layout for multi-column content sections.

```
{{< columns cols="3" gap="1rem" >}}
{{< column >}}
Column 1 content
{{< /column >}}
{{< column >}}
Column 2 content
{{< /column >}}
{{< /columns >}}
```

### `{{< nextcloud-form >}}`
Embeds a Nextcloud Forms survey via iframe with auto-resize support.

```
{{< nextcloud-form src="https://..." >}}
```

The `src` parameter is required. The shortcode handles postMessage-based height resizing from the Nextcloud origin.

### Blowfish built-in shortcodes (commonly used)

The Blowfish theme provides many shortcodes - the most commonly used on this site are:

| Shortcode | Purpose |
|---|---|
| `{{< lead >}}` | Large introductory paragraph |
| `{{< button >}}` | Styled CTA button with optional icon |
| `{{< alert >}}` | Highlighted alert/callout box |
| `{{< timeline >}}` / `{{< timelineItem >}}` | Vertical timeline for experience/education |
| `{{< tabs >}}` / `{{< tab >}}` | Tabbed content panels |
| `{{< accordion >}}` / `{{< accordionItem >}}` | Collapsible FAQ sections |
| `{{< keywordList >}}` / `{{< keyword >}}` | Tag-style skill/keyword badges |
| `{{< icon >}}` | Inline SVG icon |

Full Blowfish shortcode docs: https://blowfish.page/docs/shortcodes/

---

## Configuration

### `config/_default/params.toml`
Controls theme appearance (colour scheme, header layout, footer options, homepage layout). Edit this to change global site behaviour.

### `config/_default/languages.en.toml`
Contains the author name, bio, profile image path, and social links that appear in the sidebar/profile. Keep the `bio` field consistent with the tone and wording of `content/about.md`.

### `config/_default/menus.en.toml`
Defines the top navigation bar items and their order (`weight`).

### `layouts/partials/extend-head-uncached.html`
Injects JSON-LD structured data into every page's `<head>` without modifying the Blowfish theme. It is called uncached so it has access to the full per-page context (`.RelPermalink`, `.Permalink`, etc.).

Contains three conditional blocks:
- **All pages** — `Person` schema (name, job title, London address, LinkedIn/GitHub sameAs links).
- **Homepage only** — `ProfessionalService` schema with the full service catalogue as an `OfferCatalog`.
- **`/services/` only** — `FAQPage` schema (mirrors the accordion FAQ section) and a `Service` schema for each of the six offerings.
- **`/about/` only** — `ProfilePage` schema linked back to the `Person` entity.

When adding or renaming a service, or changing FAQ content, update both the content file and the corresponding block in this partial to keep them in sync.

### `static/site.webmanifest`
PWA manifest file — controls the site name shown when a user adds the site to their home screen. Keep `name` and `short_name` set to `"Shivan Malde"`.

---

## Code style

- No raw HTML in content markdown files. Use Hugo shortcodes for any layout or component needs.
- Follow Hugo best practices - content in `content/`, templates in `layouts/`, styles in `assets/css/`.
- Do not modify `themes/blowfish/` directly. Override theme templates by creating a file at the same relative path under `layouts/` or `assets/`.
- Responsive design is required. All layouts and custom CSS must work correctly on both large desktop monitors and small mobile screens. Test at mobile breakpoints.
- Custom CSS goes in `assets/css/custom.css`. Keep overrides minimal and scoped.
- Custom icons go in `assets/icons/` as SVG files. These are used via `{{< icon "name" >}}` where `name` matches the filename without extension.

---

## Wording and tone

- Content should be professional and direct - results-oriented, specific, and consistent with the CV at `https://github.com/ShivanMalde/cv/blob/6934230c5c3f60744e189665503576a404703105/src/cv.tex`.
- The CV is the source of truth for dates, job titles, and bullet point wording in the experience section of `content/about.md`.
- The services and homepage content is forward-looking consulting copy - it does not need to match the CV verbatim, but should be consistent in tone and claimed specialisations.
- All content should use British English language.

---

## Local development

Run the site locally with:

```bash
hugo serve
```

The site will be available at `http://localhost:1313`. Hugo will live-reload on content changes.

Build for production:

```bash
hugo --minify
```

Output goes to `public/` (excluded from version control).
