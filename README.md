# ENMeval 2.0 Tutorial (Japanese edition)

A Japanese translation of the [ENMeval](https://jamiemkass.github.io/ENMeval/) 2.0.6 vignette, written as a Quarto document.
It adds explanations for readers who are new to R, and it is rewritten so that it runs from top to bottom on a fresh machine.
Using the brown-throated sloth (*Bradypus variegatus*) as an example, it walks through tuning, evaluating and selecting
Maxent (`maxnet`) ecological niche models.

**Published page: <https://joelnitta.github.io/enmeval-tutorial/>**

## Source and credits

- Original: Kass, J. M., Muscarella, R., Pinilla-Buitrago, G. E., & Galante, P. J. *ENMeval 2.0.6 Vignette*
  (<https://jamiemkass.github.io/ENMeval/articles/ENMeval-2.0-vignette.html>)
- Citation: Kass, J. M. et al. (2021) ENMeval 2.0: Redesigned for customizable and reproducible modeling of species' niches and distributions. *Methods in Ecology and Evolution* 12: 1602–1608. <https://doi.org/10.1111/2041-210X.13628>
- The original vignette is part of the ENMeval package, which is licensed under GPL-3.

## Repository layout

| File | Contents |
|---|---|
| `enmeval-tutorial-ja.qmd` | The tutorial |
| `styles-ja.css` | Font settings for Japanese text |
| `_quarto.yml` | Quarto project settings (explicit render list, `freeze: true`) |
| `_freeze/` | Saved results of the R code (**committed to git**) |
| `.github/workflows/publish.yml` | GitHub Action that updates the published page on every push to `main` |
| `data/` | Downloaded data (occurrence records, WorldClim, ...). Not tracked by git |

## Running it locally

1. Install [R](https://cloud.r-project.org/) and [Quarto](https://quarto.org/). If you use RStudio, create an RStudio Project for this folder.
2. Clone this repository and make its folder your working directory.
3. Render the document. The R packages it needs are installed automatically by the document itself.

   ```sh
   quarto render enmeval-tutorial-ja.qmd
   ```

The first run downloads the GBIF occurrence records and the WorldClim climate data (several hundred MB) into `data/`,
so it needs an internet connection and takes about 5 minutes.
Later runs reuse the saved files.

## Editing and publishing (for maintainers)

The published page is built by GitHub Actions.
The Actions environment has neither the R analysis packages nor the downloaded data,
so **the R code is never run there**.
Instead, the results from a local run are saved in `_freeze/` and committed,
and Actions builds the HTML from those saved results (`freeze: true` in `_quarto.yml`).

After editing `enmeval-tutorial-ja.qmd`, follow these steps:

1. Edit `enmeval-tutorial-ja.qmd`.
2. **Render the file locally, by name, to refresh `_freeze/`:**

   ```sh
   quarto render enmeval-tutorial-ja.qmd
   ```

   This takes about 5 minutes. Running `quarto preview` alone does not refresh `_freeze/`.
3. Commit the `.qmd` and `_freeze/` **together**, and push to `main`.
4. The `Quarto Publish` GitHub Action runs and updates the `gh-pages` branch. Progress is visible in the repository's **Actions** tab.

> **Warning:** if you commit only the `.qmd` and skip step 2, the published page will **not show your edits**.
> The old contents of `_freeze/` are used as they are, including the text.

Notes:

- Bare `quarto render` and `quarto preview` (no file name) work in this folder because of `_quarto.yml`.
  With `freeze: true`, they do not re-run the R code.
- GitHub Pages is served from the `gh-pages` branch (Settings → Pages). You never need to edit that branch by hand.
- The workflow installs Quarto and a minimal R (only `knitr` and `rmarkdown`, which Quarto needs to find in order to render a `.qmd` with R chunks).
  It runs `quarto render` and then publishes the result, because the render step inside `quarto publish` does not honor frozen results.
- A manual `quarto publish gh-pages` also works, but is normally unnecessary.
