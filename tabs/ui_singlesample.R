singleSampleTab <- tabItem(tabName = "singleSampleTab",
    actionButton("showsampleInfo", "show sample Info"),
      fluidRow(
        tabBox(width = 12,
          tabPanel("Clonal distribution per count intervals",
                   fluidRow(column(width = 2,
                                   selectizeInput("indLevel",
                                                "Select a level",
                                                choices = list("clone", "clonotype", "CDR3nt", "CDR3aa"),
                                                options = list(onInitialize = I('function() { this.setValue(""); }')))
                            ),
                            column(width = 10,
                                   div(style="display:block;margin-left: 97%;padding-bottom: 10px;",
                                       circleButton(inputId = "indcountintHelp", icon = icon("question", verify_fa = FALSE), size="sm")),
                                   tags$head(tags$style(".modal-dialog{ width:1200px}"))
                            )
                   ),
                    uiOutput("downPlotIndCountIntervals"),
                    plotOutput("IndCountIntervals"),
                    busyIndicator(wait = 500)
            ),
          tabPanel("V/J gene usages",
                   h4("V and J usage"),
                   fluidRow(column(width = 2,
                                   selectizeInput("geneUsageLevel",
                                                "Select a level",
                                                choices = list("V", "J"),
                                                options = list(onInitialize = I('function() { this.setValue(""); }')))
                             ),
                            column(width = 10,
                                   div(style="display:block;margin-left: 97%;padding-bottom: 10px;",
                                       circleButton(inputId = "geneusageHelp", icon = icon("question", verify_fa = FALSE), size="sm")),
                                   tags$head(tags$style(".modal-dialog{ width:1200px}"))
                            )
                   ),
                   uiOutput("downPlotgeneUsage"),
                   plotly::plotlyOutput("geneUsage"),
                   busyIndicator(wait = 500),
                   h4("V-J Combination usage"),
                   fluidRow(column(width = 2,
                                   selectizeInput("VJLevel",
                                                "Select a level",
                                                choices = list("clone", "clonotype"),
                                                options = list(onInitialize = I('function() { this.setValue(""); }')))
                            ),
                            column(width = 2,
                                    sliderInput("VJProp",
                                                 "Select proportion",
                                                 value = 0.01,
                                                 min = 0, max = 1)
                            ),
                            column(width = 8,
                                   div(style="display:block;margin-left: 96.25%;padding-bottom: 10px;",
                                       circleButton(inputId = "vjusageHelp", icon = icon("question", verify_fa = FALSE), size="sm")),
                                   tags$head(tags$style(".modal-dialog{ width:1200px}"))
                            )
                   ),
                   uiOutput("downPlotVJUsage"),
                   plotOutput("VJUsage"),
                   busyIndicator(wait = 500)
          ),
          navbarMenu("CDR3 Spectratyping",
            tabPanel(title = "Stacked",
                     fluidRow(column(width = 2,
                                     sliderInput("singleProp",
                                                  "Select a proportion",
                                                  value = 0.01,
                                                  min = 0, max = 1)
                              ),
                              column(width = 10,
                                     div(style="display:block;margin-left: 97%;padding-bottom: 10px;",
                                         circleButton(inputId = "spectHelp", icon = icon("question", verify_fa = FALSE), size="sm")),
                                     tags$head(tags$style(".modal-dialog{ width:1200px}"))
                              )
                     ),
                      uiOutput("downSpectra"),
                      plotly::plotlyOutput("spectraPlot"),
                      busyIndicator(wait = 500),
                      value = "stackedspectraTypetab"
                    ),
            tabPanel(title = "Individual",  
                     fluidRow(column(width = 2,
                                     sliderInput("spectraProp",
                                                  "Select a proportion",
                                                  value = 0.01,
                                                  min = 0, max = 1)
                              ),
                              column(width = 10,
                                     div(style="display:block;margin-left: 97%;padding-bottom: 10px;",
                                         circleButton(inputId = "spectbisHelp", icon = icon("question", verify_fa = FALSE), size="sm")),
                                     tags$head(tags$style(".modal-dialog{ width:1200px}"))
                              )
                      ),
                      uiOutput("downSpectrabis"),
                      plotOutput("spectraPlotbis", height = "auto", width = "90%"),
                      busyIndicator(wait = 500),
                      value = "individualspectraTypetab"
                  )
          )
        ) # end tabBox 
      ) # end fluidRow
    ) # end tabItem
