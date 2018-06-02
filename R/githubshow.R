# Hello, world!
#
# This is an example function named 'hello'
# which prints 'Hello, world!'.
#
# You can learn more about package authoring with RStudio at:
#
#   http://r-pkgs.had.co.nz/
#
# Some useful keyboard shortcuts for package authoring:
#
#   Build and Reload Package:  'Cmd + Shift + B'
#   Check Package:             'Cmd + Shift + E'
#   Test Package:              'Cmd + Shift + T'

gh <- function() {
  tmp <- rstudioapi::getSourceEditorContext()
  markdown <- stringr::str_detect(tmp$path, "Rmd")
  gh_path <- if(markdown) "blame" else "blob"
  first_line <- tmp$selection[[1]]$range[[1]][[1]]
  second_line <- tmp$selection[[1]]$range[[2]][[1]]
  # cat(first_line, " ", second_line)
  project_name <- list.files(here::here(), pattern = "*.Rproj") %>%
    stringr::str_replace("\\.Rproj", "")
  tmp$path %>%
    stringr::str_replace(
      stringr::str_glue("~/Dropbox/{project_name}"),
      stringr::str_glue("https://github.com/lboller/{project_name}/{gh_path}/master")
    ) %>%
    paste0(stringr::str_glue("#L{first_line}-L{second_line}")) %>%
    browseURL()
}
