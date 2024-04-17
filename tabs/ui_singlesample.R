singleSampleTab <- tabItem(tabName = "singleSampleTab",
    actionButton("showsampleInfo", "show sample Info", style="background-color:white; border-color: #022F5A;"),
      fluidRow(
        tabBox(width = 12,
          tabPanel("Occurrence intervals",
                     fluidRow(div(style="display:block;margin-left: 97%;padding-bottom: 0px;",
                                  circleButton(inputId = "indcountintHelp", icon = icon("question", verify_fa = FALSE), #size="sm", 
                                               style="background-color: #337ab7; border-color: #337ab7; margin-top: -10px;
                                                                      border-radius: 25px;  font-size: 15px; height: 25px; color:white;
                                                                      line-height: 50%; padding: 2px 0; text-align: center; width: 25px;")),
                              tags$head(tags$style(".modal-dialog{ width:1200px}")),
              column(width = 2,  style="margin-top: -22px;",
                          selectizeInput("indLevel",
                                                "Select a level",
                                                choices = list("ntCDR3", "aaCDR3", "aaClone", "ntClone"),
                                                options = list(onInitialize = I('function() { this.setValue(""); }')))
                            ),
                            column(width = 2,  style="margin-top: -22px;",
                                   selectizeInput("indMeth", 
                                                  "Select a statistics scale",
                                                  choices = list("count" , "frequency"),
                                                  options = list(onInitialize = I('function() { this.setValue(""); }')))
                            )
                   ),
                    uiOutput("downPlotIndCountIntervals"),
                    plotOutput("IndCountIntervals"),
                    busyIndicator(wait = 500)
            ),
            navbarMenu("Gene usage",
                tabPanel("V/J usage",
                         fluidRow(div(style="display:block;margin-left: 97%;padding-bottom: 0px;",
                                      circleButton(inputId = "indgeneusageHelp", icon = icon("question", verify_fa = FALSE), #size="sm", 
                                                   style="background-color: #337ab7; border-color: #337ab7; margin-top: -10px;
                                                                      border-radius: 25px;  font-size: 15px; height: 25px; color:white;
                                                                      line-height: 50%; padding: 2px 0; text-align: center; width: 25px;")),
                                  tags$head(tags$style(".modal-dialog{ width:1200px}")),
                     
                     column(width = 2, style="margin-top: -22px;",
                                   selectizeInput("indgeneUsageLevel",
                                                "Select a level",
                                                choices = list("V", "J"),
                                                options = list(onInitialize = I('function() { this.setValue(""); }')))
                             )
                   ),
                   uiOutput("downPlotIndgeneUsage"),
                   plotly::plotlyOutput("indgeneUsage"),
                   busyIndicator(wait = 500)
                 ),
                tabPanel("V-J combination usage",  
                         fluidRow(div(style="display:block;margin-left: 97%;padding-bottom: 0px;",
                                      circleButton(inputId = "vjusageHelp", icon = icon("question", verify_fa = FALSE), #size="sm", 
                                                   style="background-color: #337ab7; border-color: #337ab7; margin-top: -10px;
                                                                      border-radius: 25px;  font-size: 15px; height: 25px; color:white;
                                                                      line-height: 50%; padding: 2px 0; text-align: center; width: 25px;")),
                                  tags$head(tags$style(".modal-dialog{ width:1200px}")),
                     column(width = 2,  style="margin-top: -22px;",
                                   selectizeInput("VJLevel",
                                                "Select a level",
                                                choices = list("aaClone", "ntClone"),
                                                options = list(onInitialize = I('function() { this.setValue(""); }')))
                            ),
                            column(width = 2,  style="margin-top: -22px;",
                                    sliderInput("VJProp",
                                                 "Select proportion",
                                                 value = 0.1,
                                                 min = 0, max = 1)
                            ),
                            column(width = 2,  style="margin-top: -22px;",
                                   selectizeInput("VJViz",
                                                  "Select a visualization",
                                                  choices = list("Heatmap", "Circos"),
                                                  options = list(onInitialize = I('function() { this.setValue(""); }')))
                            )
                   ),
                   uiOutput("downPlotVJUsage"),
                   plotOutput("VJUsage", height = "700px"),
                   busyIndicator(wait = 500)
            )
          ),
          navbarMenu("CDR3 Spectratyping",
            tabPanel(title = "Stacked",
                    fluidRow(div(style="display:block;margin-left: 97%;padding-bottom: 0px;",
                                             circleButton(inputId = "spectHelp", icon = icon("question", verify_fa = FALSE), #size="sm", 
                                                          style="background-color: #337ab7; border-color: #337ab7; margin-top: -10px;
                                                                      border-radius: 25px;  font-size: 15px; height: 25px; color:white;
                                                                      line-height: 50%; padding: 2px 0; text-align: center; width: 25px;")),
                                         tags$head(tags$style(".modal-dialog{ width:1200px}")),
                       column(width = 2,  style="margin-top: -22px;",
                                     sliderInput("singleProp",
                                                  "Select a proportion",
                                                  value = 0.1,
                                                  min = 0, max = 1)
                              )
                     ),
                      uiOutput("downSpectra"),
                      plotly::plotlyOutput("spectraPlot"),
                      busyIndicator(wait = 500),
                      value = "stackedspectraTypetab"
                    ),
            tabPanel(title = "Individual",  
                     fluidRow(div(style="display:block;margin-left: 97%;padding-bottom: 0px;",
                                  circleButton(inputId = "spectbisHelp", icon = icon("question", verify_fa = FALSE), #size="sm", 
                                               style="background-color: #337ab7; border-color: #337ab7; margin-top: -10px;
                                                                      border-radius: 25px;  font-size: 15px; height: 25px; color:white;
                                                                      line-height: 50%; padding: 2px 0; text-align: center; width: 25px;")),
                              tags$head(tags$style(".modal-dialog{ width:1200px}")),
                       column(width = 2,  style="margin-top: -22px;",
                                     sliderInput("spectraProp",
                                                  "Select a proportion",
                                                  value = 0.1,
                                                  min = 0, max = 1)
                              )
                      ),
                      uiOutput("downSpectrabis"),
                      plotOutput("spectraPlotbis", height = "20%", width = "100%"),
                      busyIndicator(wait = 500),
                      value = "individualspectraTypetab"
                  )
          )
        ) # end tabBox 
      ) # end fluidRow
    ) # end tabItem
