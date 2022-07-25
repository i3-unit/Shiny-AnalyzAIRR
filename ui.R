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
              plotOutput("histlibsizes"),
             busyIndicator(wait = 50),
        ),
        tabItem(tabName = "uploadTXTtab",
            h4("Data overview"),
            htmlOutput("summaryTXT"),
            busyIndicator(wait = 50),
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
            plotOutput("histtxtlibsizes"),
            busyIndicator(wait = 50),
        ),
        tabItem(tabName = "showInfoTab",
                fluidRow(tabBox(width = 12,
                                tabPanel("Show assay table",
                                         downloadButton("downloadAssay"),
                                         dataTableOutput("assayTable")),
                                tabPanel("Show metadata table",
                                         dataTableOutput("infoTable")),
                                tabPanel("Show other data table",
                                         dataTableOutput("metadataTable")),
                                tabPanel("Show history table",
                                         dataTableOutput("historyTable"))))
            
            
        ),
        tabItem(tabName = "showFiltTab",
                fluidRow(tabBox(width = 12,
                                tabPanel("Filter sequences based on their count in each sample",
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
                                         busyIndicator(wait = 500)
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
                                         busyIndicator(wait = 500)
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
                                         busyIndicator(wait = 500)
                                ),
                                tabPanel("Filter productive or unproductive sequences",
                                         fluidRow(column(width = 3,
                                                    selectizeInput("productive",
                                                                   "Select if productive",
                                                                    choices = list(TRUE, FALSE),
                                                                    options = list(onInitialize = I('function() { this.setValue(""); }')))
                                         )),
                                         h4("Filtered table"),
                                         dataTableOutput("productivedata"),
                                         busyIndicator(wait = 500)
                                ),
                                tabPanel("Drop a sample",
                                         fluidRow(column(width = 3,
                                                         uiOutput("dropSampleNames")
                                         )),
                                         h4("Filtered table"),
                                         dataTableOutput("dropeddata"),
                                         busyIndicator(wait = 500)
                                )
                                ))
        ),
        tabItem(tabName = "showNormTab",
                fluidRow(tabBox(width = 12,
                                tabPanel("Down-sampling",
                                         fluidRow(column(width = 3,
                                                         selectizeInput("doDown",
                                                                        "Do down-sampling normalization ?",
                                                                        choices = list(TRUE, FALSE),
                                                                        options = list(onInitialize = I('function() { this.setValue(""); }')))
                                         ),
                                             column(width = 3,
                                                numericInput(inputId = "downSampleSize",
                                                             label = "Set a sample size",
                                                             value = 10000,
                                                             min = 0,
                                                             max = 100000000)
                                         )),
                                         h4("Normalized table"),
                                         dataTableOutput("downsampleddata"),
                                         busyIndicator(wait = 500)
                                ),
                                tabPanel("Shannon-based normalization",
                                         fluidRow(column(width = 3,
                                                         selectizeInput("doNorm",
                                                                        "Do shannon normalization ?",
                                                                        choices = list(TRUE, FALSE),
                                                                        options = list(onInitialize = I('function() { this.setValue(""); }')))
                                         )),
                                         h4("Normalized table"),
                                         dataTableOutput("shannonsampleddata"),
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
    mydashboardHeader(title = "Shiny-pAIRRis", titleWidth = "20%", tags$li(class = "dropdown", actionLink("resetApp", "New analysis", icon = icon("sync", verify_fa = FALSE)))),
    dashboardSidebar(width = "20%", sideMenu),
    dashboardBody(tags$script(HTML("$('body').addClass('fixed');")), 
        busyIndicator(wait = 500), 
        bodyTabs
    )
)
