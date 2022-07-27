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
                # tags$h2("Session info"), 
                # box(width = 12, verbatimTextOutput("session"))
            )
        ),
        tabItem(tabName = "uploadRDStab",
                h2("Data overview"),
                htmlOutput("summaryRDS"),
                busyIndicator(wait = 50),
                plotOutput("histlibsizesp1"),
                h4(""),
                fluidRow(
                    column(width = 3,
                        selectizeInput("summaryLevel",
                                          "Select level",
                                       choices = list("clone", "clonotype", "CDR3nt", "CDR3aa"),
                                       options = list(onInitialize = I('function() { this.setValue(""); }'))
                          )
                 )
             ),
             plotOutput("histlibsizesp2"),
             busyIndicator(wait = 50),
        ),
        tabItem(tabName = "uploadTXTtab",
            h4("Data overview"),
            htmlOutput("summaryTXT"),
            busyIndicator(wait = 50),
            plotOutput("histtxtlibsizesp1"),
            h4(""),
            fluidRow(
                column(width = 3,
                       selectizeInput("summaryTXTLevel",
                                      "Select level",
                                      choices = list("clone", "clonotype", "CDR3nt", "CDR3aa"),
                                      options = list(onInitialize = I('function() { this.setValue(""); }'))
                       )
                )
            ),
            plotOutput("histtxtlibsizesp2"),
            busyIndicator(wait = 50),
        ),
        tabItem(tabName = "showInfoTab",
                fluidRow(tabBox(width = 12,
                                tabPanel("Assay",
                                         downloadButton("downloadAssay", "Export table"),
                                         dataTableOutput("assayTable")),
                                tabPanel("Metadata",
                                         downloadButton("downloadMetadata", "Export table"),
                                         dataTableOutput("infoTable")),
                                tabPanel("Other data",
                                         downloadButton("downloadOtherdata", "Export table"),
                                         dataTableOutput("metadataTable")),
                                tabPanel("History",
                                         downloadButton("downloadHistory", "Export table"),
                                         dataTableOutput("historyTable"))))
            
            
        ),
        tabItem(tabName = "showFiltTab",
                fluidRow(tabBox(width = 12,
                                tabPanel("Filter out a repertoire level count",
                                         fluidRow(column(width = 3,
                                                selectizeInput("filterCountLevel",
                                                               "Select level",
                                                               choices = list("clone", "clonotype", "CDR3aa", "CDR3nt"),
                                                               options = list(onInitialize = I('function() { this.setValue(""); }')))
                                         ), 
                                         column(width = 3,
                                                numericInput(inputId = "filterCountN",
                                                             label = "Set a count threshold",
                                                             value = 1,
                                                             min = 1,
                                                             max = 1000)
                                         ),
                                         column(width = 3,
                                                uiOutput("filterCountGroup")
                                         )),
                                         h4("Filtered table"),
                                         dataTableOutput("filtercounts"),
                                         busyIndicator(wait = 500),
                                         hr(),
                                         downloadButton("downloaddataFilterCount", "Download RDS")
                                         ),
                                tabPanel("Extract shared sequences",
                                         fluidRow(column(width = 3,
                                                         selectizeInput("publicLevel",
                                                                        "Select level",
                                                                        choices = list("clone", "clonotype", "CDR3aa", "CDR3nt"),
                                                                        options = list(onInitialize = I('function() { this.setValue(""); }')))
                                         ), 
                                         column(width = 3,
                                                numericInput(inputId = "publicProp",
                                                             label = "Set a proportion",
                                                             value = 0,
                                                             min = 0,
                                                             max = 1)
                                         ),
                                         column(width = 3,
                                                uiOutput("publicGroup")
                                         )),
                                         h4("Filtered table"),
                                         dataTableOutput("publicdata"),
                                         busyIndicator(wait = 500),
                                         hr(),
                                         downloadButton("downloaddataPublic", "Download RDS")
                                ),
                                tabPanel("Extract private sequences",
                                         fluidRow(column(width = 3,
                                                         selectizeInput("privateLevel",
                                                                        "Select level",
                                                                        choices = list("clone", "clonotype", "CDR3aa", "CDR3nt"),
                                                                        options = list(onInitialize = I('function() { this.setValue(""); }')))
                                         ), 
                                         column(width = 3,
                                                selectizeInput("privateSingletons",
                                                               "Select if singletons",
                                                               choices = list(TRUE, FALSE),
                                                               options = list(onInitialize = I('function() { this.setValue(""); }')))
                                         )),
                                         h4("Filtered table"),
                                         dataTableOutput("privatedata"),
                                         busyIndicator(wait = 500),
                                         hr(),
                                         downloadButton("downloaddataPrivate", "Download RDS")
                                ),
                                tabPanel("Filter out productive or unproductive sequences",
                                         fluidRow(column(width = 3,
                                                    selectizeInput("productive",
                                                                   "Select if productive",
                                                                    choices = list(TRUE, FALSE),
                                                                    options = list(onInitialize = I('function() { this.setValue(""); }')))
                                         )),
                                         h4("Filtered table"),
                                         dataTableOutput("productivedata"),
                                         busyIndicator(wait = 500),
                                         hr(),
                                         downloadButton("downloaddataProductiveOrUnproductive", "Download RDS")
                                ),
                                tabPanel("Drop a sample",
                                         fluidRow(column(width = 3,
                                                         uiOutput("dropSampleNames")
                                         )),
                                         h4("Filtered table"),
                                         dataTableOutput("dropeddata"),
                                         busyIndicator(wait = 500),
                                         hr(),
                                         downloadButton("downloaddataDropedSamples", "Download RDS")
                                )
                                ))
        ),
        tabItem(tabName = "showNormTab",
                fluidRow(tabBox(width = 12,
                                tabPanel("Down-sampling",
                                         fluidRow(column(width = 3,
                                                         selectizeInput("doDown",
                                                                        "Perform a down-sampling normalization",
                                                                        choices = list(TRUE, FALSE),
                                                                        options = list(onInitialize = I('function() { this.setValue(""); }')))
                                         ),
                                                  column(width = 3,
                                                         sliderInput(inputId = "downSampleSize",
                                                                     label = "Set a sample size",
                                                                     value = 10000,
                                                                     min = 0,
                                                                     max = 1000000)
                                         ),
                                         column(width = 3,
                                                sliderInput(inputId = "downseed",
                                                             label = "Set seed",
                                                             value = 1234,
                                                             min = 1,
                                                             max = 9999,
                                                             width = NULL)
                                         )),
                                         h4("Normalized table"),
                                         dataTableOutput("downsampleddata"),
                                         busyIndicator(wait = 500),
                                         hr(),
                                         downloadButton("downloaddownSampling", "Download RDS"),
                                         h4("Results"),
                                         plotOutput("histdownlibsizes"),
                                         busyIndicator(wait = 500)
                                ),
                                tabPanel("Shannon-based normalization",
                                         fluidRow(
                                             column(width = 3,
                                                         selectizeInput("doNorm",
                                                                        "Perform a shannon normalization",
                                                                        choices = list(TRUE, FALSE),
                                                                        options = list(onInitialize = I('function() { this.setValue(""); }')))
                                         )
                                         ),
                                         h4("Normalized table"),
                                         dataTableOutput("shannonsampleddata"),
                                         busyIndicator(wait = 500),
                                         hr(),
                                         downloadButton("downloadshannonNormed", "Download RDS")
                                         
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
    mydashboardHeader(title = "Shiny-pAIRRis", titleWidth = "20%", tags$li(class = "dropdown", actionLink("resetApp", "New analysis", icon = icon("sync", verify_fa = FALSE)))),
    dashboardSidebar(width = "15%", sideMenu),
    dashboardBody(tags$script(HTML("$('body').addClass('fixed');")), 
        busyIndicator(wait = 500), 
        bodyTabs
    )
)
