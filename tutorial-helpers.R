# enmeval-targets-ja.qmd の「裏方」用のヘルパー。
# ページ上には表示されない(読者がコピーするコードではない)。
#
# このページでは、読者が自分の PC で打つコードを「表示するだけのチャンク(eval: false)」で見せ、
# 実際の実行は、一時フォルダの中で、隠したチャンク(echo: false)が行う。

# 一時フォルダの中に、プロジェクト用のフォルダを作って返す。
# data/ はこのリポジトリの data/(スクリプト版チュートリアルと共有)へのシンボリックリンクにして、
# GBIF や WorldClim を再ダウンロードしないようにする。
make_tutorial_project <- function(repo_dir) {
  proj <- file.path(tempfile("enm-targets-"), "my-enm")
  dir.create(file.path(proj, "R"), recursive = TRUE)
  dir.create(file.path(repo_dir, "data"), showWarnings = FALSE)
  file.symlink(file.path(repo_dir, "data"), file.path(proj, "data"))
  normalizePath(proj)
}

# 表示用のチャンク(ラベルで指定)のコードを、ファイルに書き出す。
# これで「ページに表示されたコード = 実際に実行されたコード」になる。
write_chunks <- function(labels, path, append = FALSE) {
  code <- unlist(lapply(labels, function(l) c(knitr::knit_code$get(l), "")))
  cat(code, file = path, sep = "\n", append = append)
  invisible(path)
}
