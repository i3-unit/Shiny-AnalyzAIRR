sessionReportTab <- tabItem(tabName = "sessionReportTab", 
                fluidRow(tags$h2("Report"),
                         shinydashboard::box(width = 12,
                            radioButtons('format', 'Report format', c('HTML', 'Word', "PPT"),
                                         inline = TRUE),
                            downloadButton("report", "Download report", style="background-color:white; border-color: #022F5A;"),
                            htmlOutput("renderedReport")))
             )


