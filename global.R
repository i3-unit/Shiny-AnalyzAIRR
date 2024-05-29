#------------------------------------------------------------------------------#
#  check and load libraries
#------------------------------------------------------------------------------#
source("installPackages.R", local = TRUE)
library(shiny)
library(shinydashboard)
library(AnalyzAIRR)
library(shinysky)
library(DT)
library(reactable)
library(shinyjs)
library(shinythemes)
library(shinyWidgets)
library(InteractiveComplexHeatmap)
library(rmarkdown)
library(BiocStyle)
library(markdown)
graphics.off()
#------------------------------------------------------------------------------#
# options
#------------------------------------------------------------------------------#
options(shiny.maxRequestSize = 900*1024 ^ 3, repos = BiocManager::repositories()) # limite la taille des fichiers input, a modifier
#------------------------------------------------------------------------------#
# additional functions
#------------------------------------------------------------------------------#
#' get data from selected area of a plot 
#' 
#' function allows to get data from selected area of a plot 
#' @param x an object of class RepSeqExperiment
#' @param level choose between V, J, VJ, aaClone, ntClone, ntCDR3, aaCDR3
#' @param sample_ids a vector of sample names of length 2.
#' @param plot name of the previous plot
#' @return a data.table
#' @export
# @example
brush2v2count <- function(x, level = c("V", "J", "VJ", "aaClone", "ntClone", "ntCDR3", "aaCDR3"), sample_ids = NULL, plot = NULL){
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

#Renvoie un selectizeInput
selectColorGroup <- function(ID, y) {
  #x RepSeqExperiment object
  #id string
  colorgroup<- colnames(mData(y) %>% dplyr::select(-nSequences,-ntCDR3,-aaCDR3, -V,-J,-VJ,-aaClone,-ntClone))
  selectizeInput(ID,
                 label = "Select a group for colors",
                 choices = colorgroup,
                 options = list(onInitialize = I('function() { this.setValue(""); }')))
}


selectColorGroupmulti <- function(ID, y) {
  #x RepSeqExperiment object
  #id string
  colorgroup<- colnames(mData(y) %>% dplyr::select(-sample_id,-nSequences,-ntCDR3,-aaCDR3, -V,-J,-VJ,-aaClone,-ntClone))
  selectizeInput(ID,
                 label = "Select a group for colors",
                 choices = colorgroup,
                 options = list(onInitialize = I('function() { this.setValue(""); }')))
}


selectShapeGroup <- function(ID, z) {
  #x RepSeqExperiment object
  #id string
  shapegroup<- colnames(mData(z) %>% dplyr::select(-sample_id,-nSequences,-ntCDR3,-aaCDR3, -V,-J,-VJ,-aaClone,-ntClone))
  selectizeInput(ID,
                 label = "Select a group for shapes",
                 choices = shapegroup, 
                 options = list(onInitialize = I('function() { this.setValue(""); }')))
  
}

selectFacetGroup <- function(ID, t) {
  #t RepSeqExperiment object
  #id string
  facetgroup<- colnames(mData(t) %>% dplyr::select(-sample_id,-nSequences,-ntCDR3,-aaCDR3, -V,-J,-VJ,-aaClone,-ntClone))
  selectizeInput(ID,
                 label = HTML("Select a group for facets <i>(2 maximum, optional)</i>"),
                 choices = facetgroup,
                 multiple = TRUE,
                 options = list(maxItems=2,onInitialize = I('function() { this.setValue(""); }')))
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
  choices <- names(AnalyzAIRR::oData(x))[-3]
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

selectMultGroupDE <- function(ID, x){
  sdata <- mData(x)[,unlist(lapply(mData(x), function(y) { is.character(y) | is.factor(y)} )), drop = FALSE]
  idx <- sapply(sdata, function(i) nlevels(i)/length(i))
  choices <- colnames(sdata)[which(idx < 1)]
  selectizeInput(
    ID,
    "Select one or multiple groups",
    choices = choices,
    multiple = TRUE,
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
  p<-ggplot2::ggplot(data.frame(sums=dat), ggplot2::aes(x=sums))+
    ggplot2::geom_histogram(position = "identity", fill="white", colour="black")+
    ggplot2::xlab(xlab)+
    ggplot2::ylab(ylab)+
    ggplot2::scale_x_log10(labels=scales::comma)+
    AnalyzAIRR::theme_RepSeq()+
    ggplot2::theme( axis.title.x = ggplot2::element_text(size=15),
           axis.title.y = ggplot2::element_text(size=15),
           axis.text.x = ggplot2::element_text(size=15),
           axis.text.y = ggplot2::element_text(size=15))
  return(p)
}

selectGrp <- function( ID,x) {
  #x RepSeqExperiment object
  metadata<- AnalyzAIRR::mData(x)
  cols<- c("nSequences","V","J","VJ","ntCDR3","aaCDR3","ntClone", "aaClone")
  p<- as.list(colnames(metadata)[!as.factor(colnames(metadata)) %in% cols])
  
  selectizeInput(ID,
                 label = "Select a biological group",
                 choices = p,
                 width = "50%",
                # options = list(onInitialize = I('function() { this.setValue(""); }'))
                )
}

selectID <- function( ID,x) {
  #x RepSeqExperiment object
  metadata<- AnalyzAIRR::mData(x)
 ids<- as.list(as.character(metadata$sample_id))
  
  selectizeInput(ID,
                 label = "Select a sample ID",
                 choices = ids,
                 width = "50%",
                 #options = list(onInitialize = I('function() { this.setValue(""); }'))
                 )
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
                                   items)
                       )
              )
  )
}


summary_hist <- function(x, level=c("V", "J", "VJ", "aaClone", "ntClone", "ntCDR3", "aaCDR3")){
  
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

summary_hist2 <- function(x, level=c("V", "J", "VJ", "aaClone", "ntClone", "ntCDR3", "aaCDR3")){
  
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








