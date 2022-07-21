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
source("tabs/ui_statistics.R")
#-------------------------------------------------------------------------------------------------------------------------------------------#
#  perturbation section
#-------------------------------------------------------------------------------------------------------------------------------------------#    
#source("tabs/ui_peaktab.R")
#-------------------------------------------------------------------------------#
# Dashboard header
#-------------------------------------------------------------------------------# 
header <- dashboardHeader(titleWidth = "20%", tags$li(class = "dropdown", actionLink("resetApp", "New analysis", icon = icon("redo"))))
#-------------------------------------------------------------------------------#
# Dashboard body
#-------------------------------------------------------------------------------# 
bodyTabs <- 
    tabItems(
        tabItem(tabName = "aboutTab",
            fluidRow(
                box(width = 12, htmlOutput("about")),
                tags$h2("Session info"), 
                box(width = 12, verbatimTextOutput("session"))
            )
        ),
        tabItem(tabName = "uploadRDStab",
            h4("Histograms"),
            plotOutput("histlibsizes"),
            busyIndicator(wait = 50),
            h4("Data summary"),
            htmlOutput("summaryRDS"),
            busyIndicator(wait = 50)
        ),
        tabItem(tabName = "uploadTXTtab",
            h4("Data summary"),
            htmlOutput("summaryTXT"),
            busyIndicator(wait = 50)
        ),
        tabItem(tabName = "showAssayTab",
            downloadButton("downloadAssay"),
            dataTableOutput("assayTable")
        ),
        tabItem(tabName = "showInfoTab",
            dataTableOutput("infoTable")
        ),
        tabItem(tabName = "showMetaTab",
            #dataTableOutput("metadataTable")),
            dataTableOutput("metadataTable")
        ),
        tabItem(tabName = "showHistoryTab",
            dataTableOutput("historyTable")
        ),
        tabItem(
            tabName = "computeDiversity",
                fluidRow(
                    column(width = 4,
                        selectizeInput(
                            "diversityLevel",
                            "Select level",
                            choices = list("V", "J", "VJ", "clone", "clonotype", "CDR3nt", "CDR3aa"),
                            options = list(onInitialize = I('function() { this.setValue(""); }'))
                        )
                    ),
                    column(width = 4,
                        actionButton("diversityToSampleData", "Add diversity to sample data")
                    )
                ),
                dataTableOutput("diversityTable"),
                htmlOutput("diversityMD")
        ),
    singleSampleTab,
    compareSampleTab,
    stats
)

#-------------------------------------------------------------------------------#
# Generate dashboard
#-------------------------------------------------------------------------------# 
dashboardPage(skin = "blue",
    mydashboardHeader(title = "DiversiTR", titleWidth = "20%", tags$li(class = "dropdown", actionLink("resetApp", "New analysis", icon = icon("refresh")))),
    dashboardSidebar(width = "20%", sideMenu),
    dashboardBody(tags$script(HTML("$('body').addClass('fixed');")), 
        busyIndicator(wait = 500), 
        bodyTabs
    )
)
