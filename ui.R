#-------------------------------------------------------------------------------------------------------------------------------------------#
#  Generate side menu section
#-------------------------------------------------------------------------------------------------------------------------------------------#
source("tabs/ui_sidemenu.R")
#-------------------------------------------------------------------------------------------------------------------------------------------#
#  single sample section
#-------------------------------------------------------------------------------------------------------------------------------------------#      
source("tabs/ui_singlesample.R")
#-------------------------------------------------------------------------------------------------------------------------------------------#
#  multiple comparison section
#-------------------------------------------------------------------------------------------------------------------------------------------#    
source("tabs/ui_multiplesamples.R")
#-------------------------------------------------------------------------------------------------------------------------------------------#
#  statististical analysis section
#-------------------------------------------------------------------------------------------------------------------------------------------#
source("tabs/ui_exploratorystats.R")
#-------------------------------------------------------------------------------------------------------------------------------------------#
#  perturbation section
#-------------------------------------------------------------------------------------------------------------------------------------------#    
#source("tabs/ui_peaktab.R")
#-------------------------------------------------------------------------------#
# Dashboard header
#-------------------------------------------------------------------------------# 
header <- dashboardHeader(titleWidth = "20%", tags$li(class = "dropdown", actionLink("resetApp", "New analysis", icon = icon("redo", verify_fa = FALSE))))
#-------------------------------------------------------------------------------#
# Dashboard body
#-------------------------------------------------------------------------------# 
bodyTabs <- 
    tabItems(
        tabItem(tabName = "aboutTab",
            fluidRow(
                box(width = 12, htmlOutput("about")),
            )
        ),
        tabItem(tabName = "uploadRDStab",
                h2("Data overview"),
                htmlOutput("summaryRDS"),
                busyIndicator(wait = 50),
                uiOutput("downPlothistlibsizesp1"),
                plotOutput("histlibsizesp1"),
                h4(""),
                fluidRow(
                    column(width = 3,
                        selectizeInput("summaryLevel",
                                          "Select a level",
                                       choices = list("CDR3nt", "CDR3aa", "clone", "clonotype"),
                                       options = list(onInitialize = I('function() { this.setValue(""); }'))
                          )
                 )
             ),
             uiOutput("downPlothistlibsizesp2"),
             plotOutput("histlibsizesp2"),
             busyIndicator(wait = 50),
        ),
        tabItem(tabName = "uploadTXTtab",
            h2("Data overview"),
            htmlOutput("summaryTXT"),
            busyIndicator(wait = 50),
            uiOutput("downPlothisttxtlibsizesp1"),
            plotOutput("histtxtlibsizesp1"),
            h4(""),
            fluidRow(
                column(width = 3,
                       selectizeInput("summaryTXTLevel",
                                      "Select a level",
                                      choices = list("CDR3nt", "CDR3aa", "clone", "clonotype"),
                                      options = list(onInitialize = I('function() { this.setValue(""); }'))
                       )
                )
            ),
            uiOutput("downPlothisttxtlibsizesp2"),
            plotOutput("histtxtlibsizesp2"),
            busyIndicator(wait = 50),
        ),
        tabItem(tabName = "showInfoTab",
                fluidRow(div(style="display:block;margin-left: 95%;padding-bottom: 10px;",
                             circleButton(inputId = "dataextractionHelp", icon = icon("question", verify_fa = FALSE), size="sm")),
                         tags$head(tags$style(".modal-dialog{ width:1200px}")),
                    tabBox(width = 12,
                                tabPanel("Assay",
                                         downloadButton("downloadAssay", "Export table"),
                                         dataTableOutput("assayTable")),
                                tabPanel("Metadata",
                                         downloadButton("downloadMetadata", "Export table"),
                                         dataTableOutput("infoTable")),
                                tabPanel("Other data",
                                         fluidRow(column(width = 3,
                                                         uiOutput("otherDataList")
                                         )),
                                         downloadButton("downloadOtherdata", "Export table"),
                                         dataTableOutput("metadataTable")),
                                tabPanel("History",
                                         downloadButton("downloadHistory", "Export table"),
                                         dataTableOutput("historyTable"))))
        ),
        tabItem(tabName = "showFiltTab",
                fluidRow(tabBox(width = 12,
                                tabPanel("Filter out a repertoire level count",
                                         fluidRow(column(width = 2,
                                                selectizeInput("filterCountLevel",
                                                               "Select a level",
                                                               choices = list("CDR3nt", "CDR3aa", "clone", "clonotype"),
                                                               options = list(onInitialize = I('function() { this.setValue(""); }')))
                                                 ),
                                                 column(width = 2,
                                                       uiOutput("filterCountGroup")
                                                 ), 
                                                 column(width = 2,
                                                        sliderInput(inputId = "filterCountN",
                                                                     label = "Set a count threshold",
                                                                     value = 1,
                                                                     min = 1,
                                                                     max = 1000)
                                                 ),
                                                 column(width = 2, 
                                                        style = "margin-top: 25px;",
                                                        actionButton("doFilterCount", "run")
                                                 ),
                                                 column(width = 4,
                                                       div(style="display:block;margin-left: 92%;padding-bottom: 10px;",
                                                           circleButton(inputId = "filtercountHelp", icon = icon("question", verify_fa = FALSE), size="sm")),
                                                       tags$head(tags$style(".modal-dialog{ width:1200px}"))
                                                 )
                                         ),
                                         h4("Filtered table"),
                                         downloadButton("downloaddataFilterCount", "Download RDS"),
                                         dataTableOutput("filtercounts"),
                                         busyIndicator(wait = 500)
                                ),
                                tabPanel("Filter out productive or unproductive sequences",
                                         fluidRow(column(width = 2,
                                                         selectizeInput("productive",
                                                                        "Filter out sequences",
                                                                        choices = list("Productive", "Unproductive"),
                                                                        options = list(onInitialize = I('function() { this.setValue(""); }')))
                                         ),
                                         column(width = 10,
                                                div(style="display:block;margin-left: 97%;padding-bottom: 10px;",
                                                    circleButton(inputId = "prodHelp", icon = icon("question", verify_fa = FALSE), size="sm")),
                                                tags$head(tags$style(".modal-dialog{ width:1200px}"))
                                         )
                                         ),
                                         h4("Filtered table"),
                                         downloadButton("downloaddataProductiveOrUnproductive", "Download RDS"),
                                         dataTableOutput("productivedata"),
                                         busyIndicator(wait = 500)
                                ),
                                tabPanel("Drop a sample",
                                         fluidRow(column(width = 2,
                                                         uiOutput("dropSampleNames")
                                         ),
                                         column(width = 10,
                                                div(style="display:block;margin-left: 97%;padding-bottom: 10px;",
                                                    circleButton(inputId = "dropHelp", icon = icon("question", verify_fa = FALSE), size="sm")),
                                                tags$head(tags$style(".modal-dialog{ width:1200px}"))
                                         )
                                         ),
                                         h4("Filtered table"),
                                         downloadButton("downloaddataDropedSamples", "Download RDS"),
                                         dataTableOutput("dropeddata"),
                                         busyIndicator(wait = 500)
                                ),
                                tabPanel("Extract shared sequences",
                                         fluidRow(column(width = 2,
                                                         selectizeInput("publicLevel",
                                                                        "Select a level",
                                                                        choices = list("CDR3nt", "CDR3aa", "clone", "clonotype"),
                                                                        options = list(onInitialize = I('function() { this.setValue(""); }')))
                                                 ), 
                                                 column(width = 2,
                                                        uiOutput("publicGroup")
                                                 ),
                                                 column(width = 2, 
                                                        style = "margin-top: 25px;",
                                                        actionButton("doPublic", "run")
                                                 ),
                                                 column(width = 6,
                                                        div(style="display:block;margin-left: 95%;padding-bottom: 10px;",
                                                            circleButton(inputId = "publicHelp", icon = icon("question", verify_fa = FALSE), size="sm")),
                                                        tags$head(tags$style(".modal-dialog{ width:1200px}"))
                                                 )
                                         ),
                                         h4("Filtered table"),
                                         downloadButton("downloaddataPublic", "Download RDS"),
                                         dataTableOutput("publicdata"),
                                         busyIndicator(wait = 500)
                                ),
                                tabPanel("Extract private sequences",
                                         fluidRow(column(width = 2,
                                                         selectizeInput("privateLevel",
                                                                        "Select a level",
                                                                        choices = list("CDR3nt", "CDR3aa", "clone", "clonotype"),
                                                                        options = list(onInitialize = I('function() { this.setValue(""); }')))
                                                 ), 
                                                 column(width = 2,
                                                        selectizeInput("privateSingletons",
                                                                       "Private singletons",
                                                                       choices = list(TRUE, FALSE),
                                                                       options = list(onInitialize = I('function() { this.setValue(""); }')))
                                                 ),
                                                 column(width = 8,
                                                        div(style="display:block;margin-left: 96.25%;padding-bottom: 10px;",
                                                            circleButton(inputId = "privateHelp", icon = icon("question", verify_fa = FALSE), size="sm")),
                                                        tags$head(tags$style(".modal-dialog{ width:1200px}"))
                                                 )
                                         ),
                                         h4("Filtered table"),
                                         downloadButton("downloaddataPrivate", "Download RDS"),
                                         dataTableOutput("privatedata"),
                                         busyIndicator(wait = 500)
                                ),
                                tabPanel("Extract top sequences",
                                         fluidRow(column(width = 2,
                                                         selectizeInput("topSeqLevel",
                                                                        "Select a level",
                                                                        choices = list("CDR3nt", "CDR3aa", "clone", "clonotype"),
                                                                        options = list(onInitialize = I('function() { this.setValue(""); }')))
                                                 ), 
                                                 column(width = 2,
                                                        uiOutput("topSeqGroup")
                                                 ), 
                                                 column(width = 2,
                                                        sliderInput(inputId = "topSeqProp",
                                                                    label = "Set a proportion",
                                                                    value = 0.1,
                                                                    min = 0,
                                                                    max = 1)
                                                 ),
                                                 column(width = 2, 
                                                        style = "margin-top: 25px;",
                                                        actionButton("doTopSeq", "run")
                                                 ),
                                                 column(width = 4,
                                                        div(style="display:block;margin-left: 92%;padding-bottom: 10px;",
                                                            circleButton(inputId = "topseqHelp", icon = icon("question", verify_fa = FALSE), size="sm")),
                                                        tags$head(tags$style(".modal-dialog{ width:1200px}"))
                                                 )
                                         ),
                                         h4("Filtered table"),
                                         downloadButton("downloaddataTopSeq", "Download RDS"),
                                         dataTableOutput("topseqdata"),
                                         busyIndicator(wait = 500)
                                )
                                ))
        ),
        tabItem(tabName = "showNormTab",
                fluidRow(tabBox(width = 12,
                                tabPanel("Down-sampling",
                                         fluidRow(column(width = 2,
                                                         selectizeInput("doDown",
                                                                        "Perform a down-sampling normalization",
                                                                        choices = list("Yes", "No"),
                                                                        options = list(onInitialize = I('function() { this.setValue(""); }')))
                                                  ),
                                                  column(width = 2,
                                                         sliderInput(inputId = "downSampleSize",
                                                                     label = "Set a sample size",
                                                                     value = 10000,
                                                                     min = 0,
                                                                     max = 1000000)
                                                 ),
                                                 column(width = 2,
                                                        sliderInput(inputId = "downseed",
                                                                     label = "Set a seed",
                                                                     value = 1234,
                                                                     min = 1,
                                                                     max = 9999,
                                                                     width = NULL)
                                                 ),
                                                 column(width = 6,
                                                        div(style="display:block;margin-left: 95%;padding-bottom: 10px;",
                                                            circleButton(inputId = "downHelp", icon = icon("question", verify_fa = FALSE), size="sm")),
                                                        tags$head(tags$style(".modal-dialog{ width:1200px}"))
                                                 )
                                         ),
                                         h4("Normalized table"),
                                         downloadButton("downloaddownSampling", "Download RDS"),
                                         dataTableOutput("downsampleddata"),
                                         busyIndicator(wait = 500),
                                         hr(),
                                         h4("Results"),
                                         fluidRow(column(width = 3,
                                                         selectizeInput(
                                                             "DownLevel",
                                                             "Select a level",
                                                             choices = list("V", "J", "VJ", "CDR3nt", "CDR3aa", "clone", "clonotype"),
                                                             options = list(onInitialize = I('function() { this.setValue(""); }'))
                                                         )
                                         )),
                                         uiOutput("downhistdownlibsizes"),
                                         plotOutput("histdownlibsizes"),
                                         busyIndicator(wait = 500)
                                ),
                                tabPanel("Shannon-based normalization",
                                         fluidRow(
                                             column(width = 2,
                                                         selectizeInput("doNorm",
                                                                        "Perform a shannon normalization",
                                                                        choices = list("Yes", "No"),
                                                                        options = list(onInitialize = I('function() { this.setValue(""); }')))
                                             ),
                                             column(width = 10,
                                                    div(style="display:block;margin-left: 97%;padding-bottom: 10px;",
                                                        circleButton(inputId = "shannonHelp", icon = icon("question", verify_fa = FALSE), size="sm")),
                                                    tags$head(tags$style(".modal-dialog{ width:1200px}"))
                                             )
                                         ),
                                         h4("Normalized table"),
                                         downloadButton("downloadshannonNormed", "Download RDS"),
                                         dataTableOutput("shannonsampleddata"),
                                         busyIndicator(wait = 500),
                                         hr(),
                                         h4("Results"),
                                         fluidRow(column(width = 3,
                                                         selectizeInput(
                                                             "NormLevel",
                                                             "Select a level",
                                                             choices = list("V", "J", "VJ", "CDR3nt", "CDR3aa", "clone", "clonotype"),
                                                             options = list(onInitialize = I('function() { this.setValue(""); }'))
                                                         )
                                         )),
                                         uiOutput("downhistshannonlibsizes"),
                                         plotOutput("histshannonlibsizes"),
                                         busyIndicator(wait = 500)
                                         
                                )
                ))
            
        ),
    singleSampleTab,
    CompBasicTab,
    SimTab,
    DiffTab,
    PertTab,
    basicstats,
    divstats,
    clonalstats,
    tabItem(tabName = "sessionTab",
            fluidRow(
                tags$h2("Session info"), 
                box(width = 12, verbatimTextOutput("session"))
            )
    )
)

#-------------------------------------------------------------------------------#
# Generate dashboard
#-------------------------------------------------------------------------------# 
dashboardPage(skin = "blue",
    mydashboardHeader(title = "Shiny AnalyzAIRR", titleWidth = "19%", tags$li(class = "dropdown", actionLink("resetApp", "New analysis", icon = icon("sync", verify_fa = FALSE)))),
    dashboardSidebar(width = "19%", sideMenu,
                     div(style="position: absolute; bottom: 0;", hr(), tags$i(class="fa fa-user"), "V. Mhanna, G. Pires,", "N. Tchitchek, D. Klatzmann, A. Six, E. Mariotti", br(), "Sorbonne Université, INSERM, Immunology-Immunopathology-Immunotherapy (i3), Paris, France", br(), tags$i(class="fa fa-user"), "H. P. Pham", br(), "Paren Biotechnologies")),
    dashboardBody(tags$script(HTML("$('body').addClass('fixed');")), 
        busyIndicator(wait = 500), 
        bodyTabs
    )
)
