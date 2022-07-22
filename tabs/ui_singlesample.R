singleSampleTab <- tabItem(tabName = "singleSampleTab",
    actionButton("showsampleInfo", "show sample Info"),
      fluidRow(
        tabBox(width = 12,
          id = 'single.topTabs',
          tabPanel("Clonotype frequency",
            plotOutput("freqVpJ"),
            busyIndicator(wait = 500),
            value = "freqVpJtab"
          ),
          tabPanel("Gene distribution",  #modified by VMH
            plotOutput("propV", height = "auto"),
            plotOutput("propJ", height = "auto"),
            busyIndicator(wait = 500),
            value = "PropVJtab"
          ),
          navbarMenu("Immunoscope profile",
            tabPanel(title = "Stacked",
                     fluidRow(column(width = 3,
                                     numericInput("singleProp",
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
                                     numericInput("spectraProp",
                                                  "Select proportion",
                                                  value = 0.01,
                                                  min = 0, max = 1)
                     )),
                      uiOutput("downSpectrabis"),
                      plotOutput("spectraPlotbis", height = "auto", width = "90%"),
                      busyIndicator(wait = 500),
                      value = "individualspectraTypetab"
                  )
          ),
          tabPanel("VJ Distribution",
            uiOutput("downVJheatmap"),
            plotOutput("plotCountHeatmap", height = "auto"),
            busyIndicator(wait = 500),
            value = "tabCountHeatmap"
          ) # end tabPanel
        ) # end tabBox 
      ) # end fluidRow
    ) # end tabItem
