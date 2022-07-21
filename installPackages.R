#------------------------------------------------------------------------------#
# Check that the currently-installed version of R
#------------------------------------------------------------------------------#
R_required <- "4.0.0"
R_installed <- paste0(R.Version()$major, ".", R.Version()$minor)
if(compareVersion(R_installed, R_required) < 0){
  stop("The installed version of R is", R_installed,".\n", 
       "This shiny app requires the version ", R_required,".\n",
       "Please go to http://cran.r-project.org/ and update your version of R.")
}

# installed packages 
instPkgs <- .packages(all.available = TRUE)

# install or update BiocManager. Updates sometimes needed as they change in-step with BioC vers
if (is.na(match("BiocManager", instPkgs))) {
    install.packages("BiocManager", repos="https://cloud.r-project.org/")
}

# required packages
requiredPkgs <- c("devtools", "shiny", "shinydashboard", "ggplot2", "shinysky", "DT", "gridExtra",
    "data.table", "pbapply", "pheatmap", "DESeq2", "Rcpp", "vegan", "ggplot2", "naturalsort", 
    "ade4", "scales", "magick", "directlabels")
githubPkgs <- "RepSeq"

if (is.na(match("RepSeq", instPkgs))) {
    devtools::install_github("https://github.com/ph-pham/RepSeq")
}

# missing packages
missing_packages <- requiredPkgs[is.na(match(requiredPkgs, instPkgs))]

# install missing packages
if (length(missing_packages) > 0) sapply(missing_packages, BiocManager::install, update = FALSE)
