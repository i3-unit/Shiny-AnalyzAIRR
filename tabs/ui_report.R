sessionReportTab <- tabItem(tabName = "sessionReportTab", 
                fluidRow(tags$h2("Report"),
                        box(width = 12, 
                            downloadButton("report", "Download report", style="background-color:white; border-color: #022F5A;"),
                            htmlOutput("renderedReport")))
             )