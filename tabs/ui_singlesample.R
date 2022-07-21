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
              uiOutput("stackedspectraSample"),
              plotOutput("spectraPlot"),
              busyIndicator(wait = 500),
              value = "stackedspectraTypetab"
            ),
            tabPanel(title = "Individual",  
            #   radioButtons("spectraCDR3", "Include bound CDR3 ?", #commented by VMH
            #     inline = T,
            #     choiceNames = c("Yes", "No"),
            #     choiceValues = c(T, F),
            #     selected = F
            #   ),
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
