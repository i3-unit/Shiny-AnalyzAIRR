#------------------------------------------------------------------------------#
#  check and load libraries
#------------------------------------------------------------------------------#
#source("installPackages.R", local = TRUE)
library(shiny)
library(shinydashboard)
library(AnalyzAIRR)
library(ggplot2)
library(shinysky)
library(DT)
library(grid)
library(dplyr)
library(rstatix)
library(ggrepel)
library(shinyjs)
library(shinythemes)
library(shinyWidgets)
library(InteractiveComplexHeatmap)
library(rmarkdown)
library(rsconnect)
graphics.off()
#------------------------------------------------------------------------------#
# options
#------------------------------------------------------------------------------#
options(shiny.maxRequestSize = 200 * 1024 ^ 2, repos = BiocManager::repositories()) # limite la taille des fichiers input, a modifier

#------------------------------------------------------------------------------#
# additional functions
#------------------------------------------------------------------------------#
#' get data from selected area of a plot 
#' 
#' function allows to get data from selected area of a plot 
#' @param x an object of class RepSeqExperiment
#' @param level choose between V, J, VJ, VpJ, CDR3aa
#' @param sample_ids a vector of sample names of length 2.
#' @param plot name of the previous plot
#' @return a data.table
#' @export
# @example
brush2v2count <- function(x, level = c("V", "J", "VJ", "clone", "clonotype", "CDR3nt", "CDR3aa"), sample_ids = NULL, plot = NULL){
    if (missing(x)) stop("x is missing.")
    if (!is.RepSeqExperiment(x)) stop("an object of class RepSeqExperiment is expected.")
    levelChoice <- match.arg(level)
    cts <- data.table::copy(assay(x))
    counts <- cts[sample_id ==sample_ids[1] | sample_id == sample_ids[2]]
    selected <- data.table::dcast(counts, paste(levelChoice, "~sample_id"), value.var="count", fun.aggregate = sum)
    bp <- shiny::brushedPoints(selected, plot)
    out <- counts[eval(parse(text = levelChoice)) %in% bp[[levelChoice]]]
    return(out)
}

modify_stop_propagation <- function(x) {
  x$children[[1]]$attribs$onclick = "event.stopPropagation()"
  x
}

# Input alpha for Renyi profiles
#
# @param level 
# @return
alphaInput <- function(level) {
  textInput(paste0("alpha", level),
            label = "values of alpha separated by commas",
            "0, 0.25, 0.5, 1, 2, 4, 8, 16, 32, 64, Inf")
}


# return
#
sampleError <- function(ID) {
  validate(need(!(is.null(ID) || ID == ""), "select a sample"))
  
}

#Renvoie un selectizeInput
selectSample <- function(ID, sampleNames) {
  #x RepSeqExperiment object
  #id string
  selectizeInput(ID,
                 label = "Select a sample",
                 choices = sampleNames,
                 options = list(onInitialize = I('function() { this.setValue(""); }')))
}

# function generate selectizeInput for selecting biological groups
selectGroup <- function(ID, x) {  
    sdata <- mData(x)[,unlist(lapply(mData(x), function(y) { is.character(y) | is.factor(y)} )), drop = FALSE]
    choices <- colnames(sdata)
    selectizeInput(
        ID,
        "Select a group",
        choices = choices,
        options = list(onInitialize = I('function() { this.setValue(""); }'))
    )
}

selectList <- function(ID, x) {  
  choices <- names(AnalyzAIRR::oData(x))
  selectizeInput(
    ID,
    "Select a table",
    choices = choices,
    options = list(onInitialize = I('function() { this.setValue(""); }'))
  )
}


# same as above but exclude factor having the number of levels equal to its length 
selectGroupDE <- function(ID, x){
  sdata <- mData(x)[,unlist(lapply(mData(x), function(y) { is.character(y) | is.factor(y)} )), drop = FALSE]
  idx <- sapply(sdata, function(i) nlevels(i)/length(i))
  choices <- colnames(sdata)[which(idx < 1)]
  selectizeInput(
    ID,
    "Select a group",
    choices = choices,
    options = list(onInitialize = I('function() { this.setValue(""); }'))
  )
}

selectGroupStat <- function(ID, x){
  sdata <- mData(x)[,unlist(lapply(mData(x), function(y) { is.integer(y) } )), drop = FALSE]
  choices <- colnames(sdata)
  selectizeInput(
    ID,
    "Select a statistic",
    choices = choices,
    options = list(onInitialize = I('function() { this.setValue(""); }'))
  )
}

createHelp <- function(fn){
    temp = tools::Rd2HTML(gbRd::Rd_fun(fn),out = tempfile("docs"))
    content = readr::read_file(temp)
    file.remove(temp)
    content
}

# For plotRenyiProfile, prend str en transforme en liste de valeurs de alpha
getAlpha <- function(str) {
  as.numeric(unlist(strsplit(str, ",")))
}

# convert menu item
# https://stackoverflow.com/questions/31794702/r-shiny-dashboard-tabitems-not-apparing
convertMenuItem <- function(mi, tabName) {
  mi$children[[1]]$attribs['data-toggle']="tab"
  mi$children[[1]]$attribs['data-value'] = tabName
  mi
}

# Collapse x and y
renameFiles <- function (x, y) {
  paste0(x, "/", y)
}

# render R print output
printHtml <- function(obj){
  HTML(paste("<p style='font-size:15px;'>", paste0(capture.output(print(obj)), collapse="<br/>"), "</p>"))
}

# Plot histograms
histSums<- function(dat=NULL, xlab="",ylab=""){
  p<-ggplot2::ggplot(data.frame(sums=dat), aes(x=sums))+
    ggplot2::geom_histogram(position = "identity", fill="white", colour="black")+
    ggplot2::xlab(xlab)+
    ggplot2::ylab(ylab)+
    ggplot2::scale_x_log10(labels=scales::comma)+
    AnalyzAIRR::theme_RepSeq()+
    theme( axis.title.x = ggplot2::element_text(size=15),
           axis.title.y = ggplot2::element_text(size=15),
           axis.text.x = ggplot2::element_text(size=15),
           axis.text.y = ggplot2::element_text(size=15))
  return(p)
}

# Generate dashboard header
mydashboardHeader <- function(..., title = NULL, titleWidth = NULL, disable = FALSE,title.navbar=NULL, .list = NULL) {
  items <- c(list(...), .list)
  titleWidth <- validateCssUnit(titleWidth)
  custom_css <- NULL
  if (!is.null(titleWidth)) {
    custom_css <- tags$head(tags$style(HTML(gsub("_WIDTH_", titleWidth, fixed = TRUE, "\n      @media (min-width: 768px) {\n        .main-header > .navbar {\n          margin-left: _WIDTH_;\n        }\n        .main-header .logo {\n          width: _WIDTH_;\n        }\n      }\n    "))))
  }
  tags$header(class = "main-header", custom_css,
              style = if (disable) "display: none;",
              span(class = "logo", title),
              tags$nav(class = "navbar navbar-static-top", role = "navigation",
                       # Embed hidden icon so that we get the font-awesome dependency
                       span(shiny::icon("bars", verify_fa = FALSE), style = "display:none;"),
                       title.navbar,
                       div(class = "navbar-custom-menu",
                           tags$ul(class = "nav navbar-nav",
                                   items
                           )
                       )
              )
  )
}


summary_hist <- function(x, level=c("V", "J", "VJ", "clone", "clonotype", "CDR3nt", "CDR3aa")){
  
  metadata <- AnalyzAIRR::mData(x)
  freq <- data.frame(table(metadata[[level]]))
  
  p1 <- ggplot2::ggplot(freq, aes(x=Var1, y=Freq)) +
    ggplot2::geom_col(col="black",   ##added by VMH
                         fill="gray", alpha=.8) + 
    ggplot2::xlab(paste0("Number of ",level)) + 
    ggplot2::ylab("Number of samples") +
    AnalyzAIRR::theme_RepSeq()
  
  return(p1)
}

summary_hist2 <- function(x, level=c("V", "J", "VJ", "clone", "clonotype", "CDR3nt", "CDR3aa")){
  
  cts <- AnalyzAIRR::assay(x)
  levelChoice <- match.arg(level)
  out <- copy(cts)[, .(count = sum(count)), by = c("sample_id", levelChoice)]
  
  freq <- data.frame(table(out[["count"]]))
  
  p2 <- ggplot2::ggplot(freq, aes(x=as.numeric(Var1), y=Freq)) +
    ggplot2::geom_col(col="black",  
                      fill="gray", alpha=.8, width = 1) + 
    ggplot2::ylab(paste0("Number of ", levelChoice)) + 
    ggplot2::xlab("Count")+
    AnalyzAIRR::theme_RepSeq()
  
  return(p2)
}

#https://github.com/statnmap/RshinyApps/tree/master/On-Off_SwitchButton
switchButton <- function(inputId, label, value=FALSE) {
  if(value){
    tagList(
      tags$div(class = "form-group shiny-input-container",
               tags$div(class = "",
                        tags$label(label, class = "control-label"),
                        tags$div(class = "onoffswitch",
                                 tags$input(type = "checkbox", name = "onoffswitch", class = "onoffswitch-checkbox",
                                            id = inputId, checked = ""
                                 ),
                                 tags$label(class = "onoffswitch-label", `for` = inputId,
                                            tags$span(class = "onoffswitch-inner"),
                                            tags$span(class = "onoffswitch-switch")
                                 )
                        )
               )
      )
    )
  } else {
    tagList(
      tags$div(class = "form-group shiny-input-container",
               tags$div(class = "",
                        tags$label(label, class = "control-label"),
                        tags$div(class = "onoffswitch",
                                 tags$input(type = "checkbox", name = "onoffswitch", class = "onoffswitch-checkbox",
                                            id = inputId
                                 ),
                                 tags$label(class = "onoffswitch-label", `for` = inputId,
                                            tags$span(class = "onoffswitch-inner"),
                                            tags$span(class = "onoffswitch-switch")
                                 )
                        )
               )
      )
    ) 
  }
}








