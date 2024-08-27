singleSampleTab <- tabItem(tabName = "singleSampleTab",
    actionButton("showsampleInfo", "show sample Info", style="background-color:white; border-color: #022F5A;"),
      fluidRow(
        tabBox(width = 12,
           navbarMenu("Basic and diversity statistics",
             tabPanel("Metadata statistics",
                      fluidRow(div(style="display:block;margin-left: 97%;padding-bottom: 0px;",
                                   circleButton(inputId = "indstatisticsHelp", icon = icon("question", verify_fa = FALSE), #size="sm", 
                                                style="background-color: #337ab7; border-color: #337ab7; margin-top: -10px;
                                                                          border-radius: 25px;  font-size: 15px; height: 25px; color:white;
                                                                          line-height: 50%; padding: 2px 0; text-align: center; width: 25px;")),
                               tags$head(tags$style(".modal-dialog{ width:1200px}")),
                               column(width = 1,   
                                      style = "margin-top: -25px;margin-bottom: 12px;",
                                      tags$head(
                                      tags$style(HTML('#doIndStatistics{background-color:white; border-color: #022F5A;  border-radius: 50px;}'))
                                      ),
                                      actionButton("doIndStatistics", "Run")
                               )
                      ),
                      uiOutput("downPlotIndStatistics"),
                      plotOutput("IndStatistics"),
                      busyIndicator(wait = 500)
             ),
             tabPanel("Diversity indices",
                      fluidRow(div(style="display:block;margin-left: 97%;padding-bottom: 0px;",
                                   circleButton(inputId = "inddiversityHelp", icon = icon("question", verify_fa = FALSE), #size="sm", 
                                                style="background-color: #337ab7; border-color: #337ab7; margin-top: -10px;
                                                                          border-radius: 25px;  font-size: 15px; height: 25px; color:white;
                                                                          line-height: 50%; padding: 2px 0; text-align: center; width: 25px;")),
                               tags$head(tags$style(".modal-dialog{ width:1200px}")),
                               column(width = 2,  style="margin-top: -22px; font-size:14px",
                                      selectizeInput("indLevel",
                                                     "Select a level",
                                                     choices = list("ntCDR3", "aaCDR3", "aaClone", "ntClone"),
                                                     options = list(onInitialize = I('function() { this.setValue(""); }')))
                               )
                      ),
                      uiOutput("downPlotIndDiversity"),
                      plotOutput("IndDiversity"),
                      busyIndicator(wait = 500)
             )
           ),
           navbarMenu("Clonal distribution",
           tabPanel("TreeMap visualization",
                    fluidRow(div(style="display:block;margin-left: 97%;padding-bottom: 0px;",
                                 circleButton(inputId = "indtreemapHelp", icon = icon("question", verify_fa = FALSE), #size="sm", 
                                              style="background-color: #337ab7; border-color: #337ab7; margin-top: -10px;
                                                                  border-radius: 25px;  font-size: 15px; height: 25px; color:white;
                                                                  line-height: 50%; padding: 2px 0; text-align: center; width: 25px;")),
                             tags$head(tags$style(".modal-dialog{ width:1200px}")),
                             column(width = 2,  style="margin-top: -22px; font-size:14px",
                             selectizeInput("indTreeLevel",
                                            "Select a level",
                                            choices = list("aaClone", "ntClone", "V", "J", "VJ", "ntCDR3", "aaCDR3"),
                                            options = list(onInitialize = I('function() { this.setValue(""); }')))
                               ),
                             column(width = 2, style="margin-top: -22px; font-size:14px",
                                    sliderInput("indProp",
                                                "Select a proportion",
                                                value = 0.1,
                                                min = 0, max = 1)
                             )
                             
                    ),
                    uiOutput("downPlotIndMap"),
                    plotOutput("TreeMap"),
                    busyIndicator(wait = 500)
           ),
          tabPanel("Occurrence intervals",
                     fluidRow(div(style="display:block;margin-left: 97%;padding-bottom: 0px;",
                                  circleButton(inputId = "indcountintHelp", icon = icon("question", verify_fa = FALSE), #size="sm", 
                                               style="background-color: #337ab7; border-color: #337ab7; margin-top: -10px;
                                                                      border-radius: 25px;  font-size: 15px; height: 25px; color:white;
                                                                      line-height: 50%; padding: 2px 0; text-align: center; width: 25px;")),
                              tags$head(tags$style(".modal-dialog{ width:1200px}")),
                           column(width = 2,  style="margin-top: -22px; font-size:14px",
                          selectizeInput("indIntLevel",
                                                "Select a level",
                                                choices = list("ntCDR3", "aaCDR3", "aaClone", "ntClone"),
                                                options = list(onInitialize = I('function() { this.setValue(""); }')))
                            ),
                            column(width = 2,  style="margin-top: -22px; font-size:14px",
                                   selectizeInput("indMeth", 
                                                  "Select a statistics scale",
                                                  choices = list("count" , "frequency"),
                                                  options = list(onInitialize = I('function() { this.setValue(""); }')))
                            )
                   ),
                    uiOutput("downPlotIndCountIntervals"),
                    plotOutput("IndCountIntervals"),
                    busyIndicator(wait = 500)
            )
          ),
          tabPanel("V/J gene usage",
                   fluidRow(div(style="display:block;margin-left: 97%;padding-bottom: 0px;",
                                circleButton(inputId = "indgeneusageHelp", icon = icon("question", verify_fa = FALSE), #size="sm", 
                                             style="background-color: #337ab7; border-color: #337ab7; margin-top: -10px;
                                                                border-radius: 25px;  font-size: 15px; height: 25px; color:white;
                                                                line-height: 50%; padding: 2px 0; text-align: center; width: 25px;")),
                            tags$head(tags$style(".modal-dialog{ width:1200px}")),

               column(width = 2, style="margin-top: -22px; font-size:14px",
                             selectizeInput("indgeneUsageLevel",
                                          "Select a level",
                                          choices = list("aaClone", "ntClone"),
                                          options = list(onInitialize = I('function() { this.setValue(""); }')))
                       )
             ),
             uiOutput("downPlotIndGeneUsage"),
             # plotOutput("IndGeneUsage"),
             InteractiveComplexHeatmapOutput("ht2", 
                                             width1=1100,
                                             height1= 400,
                                             width2=600,
                                             height2= 400,
                                             output_ui_float = T, 
                                             layout = "1|(2-3)"),
             busyIndicator(wait = 500)
          ),
         tabPanel("CDR3 Spectratyping",
                fluidRow(div(style="display:block;margin-left: 97%;padding-bottom: 0px;",
                                         circleButton(inputId = "spectHelp", icon = icon("question", verify_fa = FALSE), #size="sm", 
                                                      style="background-color: #337ab7; border-color: #337ab7; margin-top: -10px;
                                                                  border-radius: 25px;  font-size: 15px; height: 25px; color:white;
                                                                  line-height: 50%; padding: 2px 0; text-align: center; width: 25px;")),
                                     tags$head(tags$style(".modal-dialog{ width:1200px}")),
                   column(width = 2, style="margin-top: -22px; font-size:14px",
                          selectizeInput("singleScale",
                                      "Select a statistics scale",
                                      choices = list("count" , "frequency"),
                                      options = list(onInitialize = I('function() { this.setValue(""); }')))
                   ),
                   column(width = 2, style="margin-top: -22px; font-size:14px",
                          sliderInput("spectraProp",
                                      "Select a proportion",
                                      value = 0.1,
                                      min = 0, max = 1)
                   )
                 ),
                  uiOutput("downSpectra"),
                  plotly::plotlyOutput("spectraPlot"),
                  busyIndicator(wait = 500)
                )

        ) # end tabBox 
      ) # end fluidRow
    ) # end tabItem
