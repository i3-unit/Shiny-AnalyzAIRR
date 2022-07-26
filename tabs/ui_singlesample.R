singleSampleTab <- tabItem(tabName = "singleSampleTab",
    actionButton("showsampleInfo", "show sample Info"),
      fluidRow(
        tabBox(width = 12,
          tabPanel("Clonal distribution per count intervals",
                   fluidRow(column(width = 3,
                                   selectizeInput("indLevel",
                                                "Select level",
                                                choices = list("clone", "clonotype", "CDR3nt", "CDR3aa"),
                                                selected = "clone")
                   )),
                    plotOutput("IndCountIntervals"),
                    busyIndicator(wait = 500)
            ),
          tabPanel("V/J gene usages",
                   h4("V and J usages"),
                   fluidRow(column(width = 3,
                                   selectizeInput("geneUsageLevel",
                                                "Select level",
                                                choices = list("V", "J"),
                                                selected = "V")
                                   )
                   ),
                   plotOutput("geneUsage"),
                   busyIndicator(wait = 500),
                   h4("V-J Combination usages"),
                   fluidRow(column(width = 3,
                                   selectizeInput("VJLevel",
                                                "Select level",
                                                choices = list("clone", "clonotype"),
                                                selected = "clone")
                   ),column(width = 3,
                            sliderInput("VJProp",
                                         "Select proportion",
                                         value = 0.01,
                                         min = 0, max = 1)
                   )
                   ),
                   plotOutput("VJUsage"),
                   busyIndicator(wait = 500)
          ),
          navbarMenu("CDR3 Spectratyping",
            tabPanel(title = "Stacked",
                     fluidRow(column(width = 3,
                                     sliderInput("singleProp",
                                                  "Select proportion",
                                                  value = 0.01,
                                                  min = 0, max = 1)
                     )),
                      uiOutput("downSpectra"),
                      plotOutput("spectraPlot"),
                      busyIndicator(wait = 500),
                      value = "stackedspectraTypetab"
                    ),
            tabPanel(title = "Individual",  
                     fluidRow(column(width = 3,
                                     sliderInput("spectraProp",
                                                  "Select proportion",
                                                  value = 0.01,
                                                  min = 0, max = 1)
                     )),
                      uiOutput("downSpectrabis"),
                      plotOutput("spectraPlotbis", height = "auto", width = "90%"),
                      busyIndicator(wait = 500),
                      value = "individualspectraTypetab"
                  )
          )
        ) # end tabBox 
      ) # end fluidRow
    ) # end tabItem
