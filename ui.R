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
                        tags$head(
                           tags$style(HTML('.selectize-input{background-color:white; border-color: #022F5A;}
                                            .input-group .form-control, .input-group-addon, .input-group-btn{background-color:white; border-color: #022F5A; border-radius: 0px;}
                                            .btn-file{background-color:white; border-color: #022F5A; border-radius: 0px;}
                                            .progress-bar{border-color: #022F5A; border-radius: 0px;}
                                            .irs--shiny .irs-min, .irs--shiny .irs-max{background-color: aliceblue;}
                                            .shiny-input-checkboxgroup label~.shiny-options-group, .shiny-input-radiogroup label~.shiny-options-group{mix-blend-mode: hard-light;}
                                            .onoffswitch {margin-top: 3px; position: relative; width: 69px;-webkit-user-select:none; -moz-user-select:none; -ms-user-select: none;}
                                            .onoffswitch-checkbox {position: absolute; opacity: 0;pointer-events: none;}
                                            .onoffswitch-label {display: block; overflow: hidden; cursor: pointer;border: 1.5px solid #022F5A; border-radius: 12px;}
                                            .onoffswitch-inner {display: block; width: 200%; margin-left: -100%;transition: margin 0.3s ease-in 0s;}
                                            .onoffswitch-inner:before, .onoffswitch-inner:after {display: block; float: left; width: 50%; height: 23px; padding: 0; line-height: 23px;font-size: 13px; color: white; font-family: Trebuchet, Arial, sans-serif; font-weight: bold;box-sizing: border-box;}
                                            .onoffswitch-inner:before {content: "Yes";padding-left: 10px;background-color: #FFFFFF; color: #428BCA;}
                                            .onoffswitch-inner:after {content: "No";padding-right: 10px;background-color: #FFFFFF; color: #999999;text-align: right;}
                                            .onoffswitch-switch {display: block; width: 10px; height: 10px; margin: 8px; background: #A1A1A1;position: absolute; top: 0; bottom: 0;right: 42px;border: 2px solid #022F5A; border-radius: 12px;transition: all 0.3s ease-in 0s; }
                                            .onoffswitch-checkbox:checked + .onoffswitch-label .onoffswitch-inner {margin-left: 0;}
                                            .onoffswitch-checkbox:checked + .onoffswitch-label .onoffswitch-switch {right: 0px; background-color: #428BCA;}'))
                        ),
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
                             circleButton(inputId = "dataextractionHelp", icon = icon("question", verify_fa = FALSE), size="sm", style="background-color:white; border-color: #022F5A;")),
                         tags$head(tags$style(".modal-dialog{ width:1200px}")),
                    tabBox(width = 12,
                                tabPanel("Assay",
                                         downloadButton("downloadAssay", "Export table", style="background-color:white; border-color: #022F5A;"),
                                         dataTableOutput("assayTable"),
                                         busyIndicator(wait = 500)),
                                tabPanel("Metadata",
                                         downloadButton("downloadMetadata", "Export table", style="background-color:white; border-color: #022F5A;"),
                                         dataTableOutput("infoTable"),
                                         busyIndicator(wait = 500)),
                                tabPanel("Other data",
                                         fluidRow(column(width = 3,
                                                         uiOutput("otherDataList")
                                         )),
                                         downloadButton("downloadOtherdata", "Export table", style="background-color:white; border-color: #022F5A;"),
                                         dataTableOutput("metadataTable"),
                                         busyIndicator(wait = 500)),
                                tabPanel("History",
                                         downloadButton("downloadHistory", "Export table", style="background-color:white; border-color: #022F5A;"),
                                         dataTableOutput("historyTable"),
                                         busyIndicator(wait = 500))))
        ),
        tabItem(tabName = "showFiltTab",
                fluidRow(tabBox(width = 12,
                                tabPanel("Filter out a repertoire level count",
                                         fluidRow(
                                                column(width = 2,
                                                       selectizeInput("filterCountLevel",
                                                                      "Select a level",
                                                                      choices = list("CDR3nt", "CDR3aa", "clone", "clonotype"),
                                                                      options = list(onInitialize = I('function() { this.setValue(""); }')))
                                                 ),
                                                 column(width = 3,
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
                                                        tags$head(
                                                            tags$style(HTML('#doFilterCount{background-color:white; border-color: #022F5A;}'))
                                                        ),
                                                        actionButton("doFilterCount", "run")
                                                 ),
                                                 column(width = 3,
                                                       div(style="display:block;margin-left: 89.5%;padding-bottom: 10px;",
                                                           circleButton(inputId = "filtercountHelp", icon = icon("question", verify_fa = FALSE), size="sm", style="background-color:white; border-color: #022F5A;")),
                                                       tags$head(tags$style(".modal-dialog{ width:1200px}"))
                                                 )
                                         ),
                                         h4("Filtered table"),
                                         downloadButton("downloaddataFilterCount", "Download RDS", style="background-color:white; border-color: #022F5A;"),
                                         dataTableOutput("filtercounts"),
                                         busyIndicator(wait = 500)
                                ),
                                tabPanel("Filter out unproductive sequences",
                                         fluidRow(
                                             column(width = 2, 
                                                    style = "margin-top: 25px;",
                                                    tags$head(
                                                        tags$style(HTML('#doProductive{background-color:white; border-color: #022F5A;}'))
                                                    ),
                                                    actionButton("doProductive", "run")),
                                             column(width = 10,
                                                  div(style="display:block;margin-left: 97%;padding-bottom: 10px;",
                                                        circleButton(inputId = "prodHelp", icon = icon("question", verify_fa = FALSE), size="sm", style="background-color:white; border-color: #022F5A;")),
                                                  tags$head(tags$style(".modal-dialog{ width:1200px}"))
                                             )
                                         ),
                                         h4("Filtered table"),
                                         downloadButton("downloaddataProductiveOrUnproductive", "Download RDS", style="background-color:white; border-color: #022F5A;"),
                                         dataTableOutput("productivedata"),
                                         busyIndicator(wait = 500)
                                ),
                                tabPanel("Drop a sample",
                                         fluidRow(column(width = 2,
                                                         uiOutput("dropSampleNames")
                                         ),
                                         column(width = 10,
                                                div(style="display:block;margin-left: 97%;padding-bottom: 10px;",
                                                    circleButton(inputId = "dropHelp", icon = icon("question", verify_fa = FALSE), size="sm", style="background-color:white; border-color: #022F5A;")),
                                                tags$head(tags$style(".modal-dialog{ width:1200px}"))
                                         )
                                         ),
                                         h4("Filtered table"),
                                         downloadButton("downloaddataDropedSamples", "Download RDS", style="background-color:white; border-color: #022F5A;"),
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
                                                 column(width = 3,
                                                        uiOutput("publicGroup")
                                                 ),
                                                 column(width = 2, 
                                                        style = "margin-top: 25px;",
                                                        tags$head(
                                                            tags$style(HTML('#doPublic{background-color:white; border-color: #022F5A;}'))
                                                        ),
                                                        actionButton("doPublic", "run")
                                                 ),
                                                 column(width = 5,
                                                        div(style="display:block;margin-left: 93.85%;padding-bottom: 10px;",
                                                            circleButton(inputId = "publicHelp", icon = icon("question", verify_fa = FALSE), size="sm", style="background-color:white; border-color: #022F5A;")),
                                                        tags$head(tags$style(".modal-dialog{ width:1200px}"))
                                                 )
                                         ),
                                         h4("Filtered table"),
                                         downloadButton("downloaddataPublic", "Download RDS", style="background-color:white; border-color: #022F5A;"),
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
                                                 # column(width = 2,
                                                 #        selectizeInput("privateSingletons",
                                                 #                       "Private singletons",
                                                 #                       choices = list(TRUE, FALSE),
                                                 #                       options = list(onInitialize = I('function() { this.setValue(""); }')))
                                                 # ),
                                                 column(width = 2,
                                                        switchButton(inputId = "privateSingletons",
                                                                     label = "Private singletons",
                                                                     value = FALSE)
                                                 ),
                                                 column(width = 2, 
                                                        style = "margin-top: 25px;",
                                                        tags$head(
                                                            tags$style(HTML('#doPrivate{background-color:white; border-color: #022F5A;}'))
                                                        ),
                                                        actionButton("doPrivate", "run")
                                                 ),
                                                 column(width = 6,
                                                        div(style="display:block;margin-left: 95%;padding-bottom: 10px;",
                                                            circleButton(inputId = "privateHelp", icon = icon("question", verify_fa = FALSE), size="sm", style="background-color:white; border-color: #022F5A;")),
                                                        tags$head(tags$style(".modal-dialog{ width:1200px}"))
                                                 )
                                         ),
                                         h4("Filtered table"),
                                         downloadButton("downloaddataPrivate", "Download RDS", style="background-color:white; border-color: #022F5A;"),
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
                                                 column(width = 3,
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
                                                        tags$head(
                                                            tags$style(HTML('#doTopSeq{background-color:white; border-color: #022F5A;}'))
                                                        ),
                                                        actionButton("doTopSeq", "run")
                                                 ),
                                                 column(width = 3,
                                                        div(style="display:block;margin-left: 89.5%;padding-bottom: 10px;",
                                                            circleButton(inputId = "topseqHelp", icon = icon("question", verify_fa = FALSE), size="sm", style="background-color:white; border-color: #022F5A;")),
                                                        tags$head(tags$style(".modal-dialog{ width:1200px}"))
                                                 )
                                         ),
                                         h4("Filtered table"),
                                         downloadButton("downloaddataTopSeq", "Download RDS", style="background-color:white; border-color: #022F5A;"),
                                         dataTableOutput("topseqdata"),
                                         busyIndicator(wait = 500)
                                )
                                ))
        ),
        tabItem(tabName = "showNormTab",
                fluidRow(tabBox(width = 12,
                                tabPanel("Down-sampling",
                                         fluidRow(
                                                 # column(width = 3,
                                                 #         selectizeInput("doDown",
                                                 #                        "Perform a down-sampling normalization",
                                                 #                        choices = list("Yes", "No"),
                                                 #                        options = list(onInitialize = I('function() { this.setValue(""); }')))
                                                 #  ),
                                                  column(width=3,
                                                         switchButton(inputId = "doDown",
                                                                      label = "Perform a down-sampling normalization",
                                                                      value = FALSE)
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
                                                 # column(width = 2,
                                                 #          selectizeInput("downReplace",
                                                 #                         "With replacement",
                                                 #                         choices = list(TRUE, FALSE),
                                                 #                         options = list(onInitialize = I('function() { this.setValue(""); }')))
                                                 # ),
                                                 column(width=2,
                                                        switchButton(inputId = "downReplace",
                                                                     label = "With replacement",
                                                                     value = TRUE)
                                                 ),
                                                 column(width = 3,
                                                        div(style="display:block;margin-left: 89.5%;padding-bottom: 10px;",
                                                            circleButton(inputId = "downHelp", icon = icon("question", verify_fa = FALSE), size="sm", style="background-color:white; border-color: #022F5A;")),
                                                        tags$head(tags$style(".modal-dialog{ width:1200px}"))
                                                 )
                                         ),
                                         h4("Normalized table"),
                                         downloadButton("downloaddownSampling", "Download RDS", style="background-color:white; border-color: #022F5A;"),
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
                                             # column(width = 2,
                                             #             selectizeInput("doNorm",
                                             #                            "Perform a shannon normalization",
                                             #                            choices = list("Yes", "No"),
                                             #                            options = list(onInitialize = I('function() { this.setValue(""); }')))
                                             # ),
                                             column(width=2,
                                                    switchButton(inputId = "doNorm",
                                                                 label = "Perform a shannon normalization",
                                                                 value = FALSE)
                                             ),
                                             column(width = 10,
                                                    div(style="display:block;margin-left: 97%;padding-bottom: 10px;",
                                                        circleButton(inputId = "shannonHelp", icon = icon("question", verify_fa = FALSE), size="sm", style="background-color:white; border-color: #022F5A;")),
                                                    tags$head(tags$style(".modal-dialog{ width:1200px}"))
                                             )
                                         ),
                                         h4("Normalized table"),
                                         downloadButton("downloadshannonNormed", "Download RDS", style="background-color:white; border-color: #022F5A;"),
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
                     div(style="position: absolute; bottom: 0;", hr(), tags$i(class="fa fa-user"), "V. Mhanna, H. P. Pham, G. Pires,", "N. Tchitchek, D. Klatzmann, A. Six, E. Mariotti-Ferrandiz")),
    dashboardBody(tags$script(HTML("$('body').addClass('fixed');")), 
        busyIndicator(wait = 500), 
        bodyTabs
    )
)
