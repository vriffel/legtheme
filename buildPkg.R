##======================================================================
## Script to check and build the `legtheme` package
##======================================================================

##----------------------------------------------------------------------
## Set working directory
if (!basename(getwd()) == "legtheme") {
    stop("The working directory isn't /leg-theme")
}

##----------------------------------------------------------------------
## Packages
library(devtools)
library(knitr)
library(rmarkdown)

##----------------------------------------------------------------------
## Run checks

## Load the package (to make functions available)
load_all()

## Create/update NAMESPACE, *.Rd files.
document()

## Check documentation.
check_man()

## Check functions, datasets, run examples, etc. Using cleanup = FALSE
## and check_dir = "../" will create a directory named legtheme.Rcheck
## with all the logs, manuals, figures from examples, etc.
check(manual = TRUE, vignettes = FALSE, check_dir = "../")

## Examples
# Run examples from all functions of the package
# run_examples()
# Run examples from a specific function
# dev_example("yscale.components.right")

## Show all exported objects.
ls("package:legtheme")
packageVersion("legtheme")

## Build the package (it will be one directory up)
build(manual = TRUE, vignettes = FALSE)
# build the binary version for windows (not used)
# build_win() # not used here. see below

##----------------------------------------------------------------------
## Test installation.

## Test install with install.packages()
pkg <- paste0("../legtheme_", packageVersion("legtheme"), ".tar.gz")
install.packages(pkg, repos = NULL)

##----------------------------------------------------------------------
## Generate README.md
knit(input = "README.Rmd")

##----------------------------------------------------------------------
## Sending package tarballs and manual to remote server to be
## downloadable

## Create Windows version
pkg.win <- paste0("../legtheme_", packageVersion("legtheme"), ".zip")
cmd.win <- paste("cd ../legtheme.Rcheck && zip -r", pkg.win, "legtheme")
system(cmd.win)

## Link to manual
man <- "../legtheme.Rcheck/legtheme-manual.pdf"

## Send to downloads/ folder
dest <- "downloads/"
file.copy(c(pkg, pkg.win, man), dest, overwrite = TRUE)
##----------------------------------------------------------------------
