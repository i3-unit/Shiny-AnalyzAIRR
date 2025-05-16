basicstats <- 
    tabItem(tabName = "showBasicTab", 
        fluidRow(
            tabBox(width = 12,
               navbarMenu("Metadata statistics",
                tabPanel("Single statistic", 
                         fluidRow(div(style="display:block;margin-left: 97%;padding-bottom: 0px;",
                                      circleButton(inputId = "basicstatsHelp", icon = icon("question", verify_fa = FALSE), #size="sm", 
                                                   style="background-color: #337ab7; border-color: #337ab7; margin-top: -10px;
                                                                      border-radius: 25px;  font-size: 15px; height: 25px; color:white;
                                                                      line-height: 50%; padding: 2px 0; text-align: center; width: 25px;")),
                                  tags$head(tags$style(".modal-dialog{ width:1200px}")),
                        column(width = 2, style="margin-top: -22px; font-size:14px",
                               uiOutput("plotStats")
                        ),
                       column(width = 2,style="margin-top: -22px; font-size:14px",
                               uiOutput("plotcolorgroup")
                        ),
                        column(width = 5, style="margin-top: -22px; font-size:14px",
                               uiOutput("plotfacetgroup")
                        )
                        # column(width = 2, style="margin-top: -22px;",
                        #        div(style="display:block;margin-left: 97%;padding-bottom: 20px;",
                        #            circleButton(inputId = "basicstatsHelp", icon = icon("question", verify_fa = FALSE), size="sm", style="background-color:white; border-color: #022F5A;")),
                        #        tags$head(tags$style(".modal-dialog{ width:1200px}"))
                        # )
                    ), 
                    uiOutput("downPlotStatsBasic"),
                    plotOutput("plotStatistic"), 
                    busyIndicator(wait = 500)
                 ),
                tabPanel("Pairwise statistics", 
                         fluidRow(div(style="display:block;margin-left: 97%;padding-bottom: 0px;",
                                      circleButton(inputId = "pairstatHelp", icon = icon("question", verify_fa = FALSE), #size="sm", 
                                                   style="background-color: #337ab7; border-color: #337ab7; margin-top: -10px;
                                                                      border-radius: 25px;  font-size: 15px; height: 25px; color:white;
                                                                      line-height: 50%; padding: 2px 0; text-align: center; width: 25px;")),
                                  tags$head(tags$style(".modal-dialog{ width:1200px}")),
                                  column(width = 4, style="margin-top: -22px; font-size:14px",
                                         uiOutput("plotStats1")
                                  ),
                                  column(width = 4, style="margin-top: -22px; font-size:14px",
                                         uiOutput("plotStats2")
                                  ),
                                  column(width = 2,style="margin-top: -22px; font-size:14px",
                                         uiOutput("plotcolorgrouppair")
                                  )
                                  # column(width = 2, style="margin-top: -22px;",
                                  #        div(style="display:block;margin-left: 97%;padding-bottom: 20px;",
                                  #            circleButton(inputId = "basicstatsHelp", icon = icon("question", verify_fa = FALSE), size="sm", style="background-color:white; border-color: #022F5A;")),
                                  #        tags$head(tags$style(".modal-dialog{ width:1200px}"))
                                  # )
                         ), 
                         uiOutput("downPlotPairStatistic"),
                         plotly::plotlyOutput("plotPairStatistic"), 
                         busyIndicator(wait = 500)
                ),
               ),
                tabPanel("Detailed repertoire level statistics",
                         fluidRow(div(style="display:block;margin-left: 97%;padding-bottom: 0px;",
                                      circleButton(inputId = "countfeaturesHelp", icon = icon("question", verify_fa = FALSE), #size="sm", 
                                                   style="background-color: #337ab7; border-color: #337ab7; margin-top: -10px;
                                                                      border-radius: 25px;  font-size: 15px; height: 25px; color:white;
                                                                      line-height: 50%; padding: 2px 0; text-align: center; width: 25px;")),
                                  tags$head(tags$style(".modal-dialog{ width:1200px}")),
                             column(width = 2, style="margin-top: -22px; font-size:14px",
                                    selectizeInput(
                                        "countLevel",
                                        "Select a level",
                                        choices = list("V", "J", "VJ", "ntCDR3", "aaCDR3", "aaClone", "ntClone"),
                                        options = list(onInitialize = I('function() { this.setValue(""); }')))
                             ),
                             column(width = 2, style="margin-top: -22px; font-size:14px",
                                    selectizeInput(
                                        "countScale",
                                        "Select a scale",
                                        choices = list("count", "frequency"),
                                        options = list(onInitialize = I('function() { this.setValue(""); }')))
                             )
                             # column(width = 8,
                             #        div(style="display:block;margin-left: 96.25%;padding-bottom: 10px;",
                             #            circleButton(inputId = "countfeaturesHelp", icon = icon("question", verify_fa = FALSE), size="sm", style="background-color:white; border-color: #022F5A;")),
                             #        tags$head(tags$style(".modal-dialog{ width:1200px}"))
                             # )
                         ),
                         downloadButton("downloadCountFeatures", "Export table", style="background-color:white; border-color: #022F5A;"),
                         reactableOutput("dataCountFeatures"),
                         busyIndicator(wait = 500)

                )
              )
           )
        )


divstats<- tabItem(tabName = "showDivTab",
                      fluidRow(
                          tabBox(width = 12,
                             navbarMenu("Richness estimation",
                          tabPanel("Rarefaction analysis",
                                   fluidRow(div(style="display:block;margin-left: 97%;padding-bottom: 0px;",
                                                circleButton(inputId = "raretabHelp", icon = icon("question", verify_fa = FALSE), #size="sm", 
                                                             style="background-color: #337ab7; border-color: #337ab7; margin-top: -10px;
                                                                      border-radius: 25px;  font-size: 15px; height: 25px; color:white;
                                                                      line-height: 50%; padding: 2px 0; text-align: center; width: 25px;")),
                                            tags$head(tags$style(".modal-dialog{ width:1200px}")),
                                     column(width = 2, style="margin-top: -22px; font-size:14px",
                                            uiOutput("plotRare")
                                     )
                                     # column(width = 10,
                                     #        div(style="display:block;margin-left: 97%;padding-bottom: 10px;",
                                     #            circleButton(inputId = "raretabHelp", icon = icon("question", verify_fa = FALSE), size="sm", style="background-color:white; border-color: #022F5A;")),
                                     #        tags$head(tags$style(".modal-dialog{ width:1200px}"))
                                     # )
                                ),
                                uiOutput("downPlotRare"),
                                plotly::plotlyOutput("plotrarefaction"), 
                                busyIndicator(wait = 50),
                                # hr(),
                                # h4("Value table"),
                                # div(style="display:block;margin-left: 97.25%;padding-bottom: 10px;",
                                #     circleButton(inputId = "raretabHelp", icon = icon("question", verify_fa = FALSE), size="sm")),
                                # tags$head(tags$style(".modal-dialog{ width:1200px}")),
                                # downloadButton("downloaddataRare", "Export table", style="background-color:white; border-color: #022F5A;"),
                                # reactableOutput("dataRare"),
                                # busyIndicator(wait = 500)
                                ),
                          tabPanel("Chao estimation",
                                   fluidRow(div(style="display:block;margin-left: 97%;padding-bottom: 0px;",
                                                circleButton(inputId = "Chaoesthelp", icon = icon("question", verify_fa = FALSE), #size="sm", 
                                                             style="background-color: #337ab7; border-color: #337ab7; margin-top: -10px;
                                                                      border-radius: 25px;  font-size: 15px; height: 25px; color:white;
                                                                      line-height: 50%; padding: 2px 0; text-align: center; width: 25px;")),
                                            tags$head(tags$style(".modal-dialog{ width:1200px}")),
                                            column(width = 2, style="margin-top: -22px; font-size:14px",
                                                   selectizeInput(
                                                     "chaoIndex",
                                                     "Select a Chao index",
                                                     choices = list("chao1", "iChao"),
                                                     options = list(onInitialize = I('function() { this.setValue(""); }')))
                                            ),
                                            column(width = 2,  style="margin-top: -22px; font-size:14px",
                                                   uiOutput("chaocolor")
                                            )
                                            ),
                                            uiOutput("downPlotChaoest"),
                                            plotly::plotlyOutput("plotChaoest"),
                                            busyIndicator(wait = 500)
                          ),
                             ),
                          navbarMenu("Diversity calculation",
                          tabPanel("Single diversity index",
                                   fluidRow(div(style="display:block;margin-left: 97%;padding-bottom: 0px;",
                                                circleButton(inputId = "divtabHelp", icon = icon("question", verify_fa = FALSE), #size="sm", 
                                                             style="background-color: #337ab7; border-color: #337ab7; margin-top: -10px;
                                                                      border-radius: 25px;  font-size: 15px; height: 25px; color:white;
                                                                      line-height: 50%; padding: 2px 0; text-align: center; width: 25px;")),
                                            tags$head(tags$style(".modal-dialog{ width:1200px;}")),
                                       column(width = 2, style="margin-top: -22px; font-size:14px",
                                              selectizeInput(
                                                  "divIndex",
                                                  "Select an index",
                                                  choices = list( "shannon", "simpson", "invsimpson", "bergerparker", "gini"),
                                                  options = list(onInitialize = I('function() { this.setValue(""); }')))
                                       ),
                                       column(width = 2, style="margin-top: -22px; font-size:14px",
                                              selectizeInput(
                                                  "divLevel",
                                                  "Select a level",
                                                  choices = list("V", "J", "VJ", "ntCDR3", "aaCDR3", "aaClone", "ntClone"),
                                                  options = list(onInitialize = I('function() { this.setValue(""); }')))
                                       ),
                                       column(width = 2,  style="margin-top: -22px; font-size:14px",
                                              uiOutput("divcolor")
                                       ),
                                       column(width = 5,  style="margin-top: -22px; font-size:14px",
                                              uiOutput("divfacet")
                                       )
                                       # column(width = 2,
                                       #        div(style="display:block;margin-left: 95%;padding-bottom: 10px;",
                                       #            circleButton(inputId = "divtabHelp", icon = icon("question", verify_fa = FALSE), size="sm", style="background-color:white; border-color: #022F5A;")),
                                       #        tags$head(tags$style(".modal-dialog{ width:1200px}"))
                                       # )
                                   ), 
                                   uiOutput("downPlotDiv"),
                                   plotOutput("plotDiv"), 
                                   busyIndicator(wait = 500),
                                   hr(),
                                   h4("Value table"),
                                   # div(style="display:block;margin-left: 97.25%;padding-bottom: 10px;",
                                   #  circleButton(inputId = "divtabHelp", icon = icon("question", verify_fa = FALSE), size="sm")),
                                   # tags$head(tags$style(".modal-dialog{ width:1200px}")),
                                   downloadButton("downloaddataDiv", "Export table",style="background-color:white; border-color: #022F5A;"),
                                   dataTableOutput("dataDiv"),
                                   busyIndicator(wait = 500)
                                   ),
                          tabPanel("Generalized diversity",
                                   fluidRow(div(style="display:block;margin-left: 97%;padding-bottom: 0px;",
                                                circleButton(inputId = "rentabHelp", icon = icon("question", verify_fa = FALSE), #size="sm", 
                                                             style="background-color: #337ab7; border-color: #337ab7; margin-top: -10px;
                                                                      border-radius: 25px;  font-size: 15px; height: 25px; color:white;
                                                                      line-height: 50%; padding: 2px 0; text-align: center; width: 25px;")),
                                            tags$head(tags$style(".modal-dialog{ width:1200px}")),
                                            
                                        column(width = 2, style="margin-top: -22px; font-size:14px",
                                               selectizeInput(
                                                 "doHill",
                                                 "Hill Diversity",
                                                 choices = list("TRUE", 'FALSE'),
                                                 selected = "FALSE",
                                                 options = list(onInitialize = I('function() { this.setValue(""); }')))
                                        ),
                                       column(width = 2, style="margin-top: -22px; font-size:14px",
                                              selectizeInput(
                                                  "renyiLevel",
                                                  "Select a level",
                                                  choices = list("V", "J", "VJ", "ntCDR3", "aaCDR3", "aaClone", "ntClone"),
                                                  options = list(onInitialize = I('function() { this.setValue(""); }')))
                                       ),
                                       column(width = 2, style="margin-top: -22px; font-size:14px",
                                              uiOutput("renyicolor")
                                       ),
                                       # column(width = 3, style="margin-top: -22px;",
                                       #        uiOutput("renyishape")
                                       #),
                                       column(width = 4, style="margin-top: -22px; font-size:14px",
                                              uiOutput("renyifacet")
                                       )
                                       # column(width = 2,
                                       #        div(style="display:block;margin-left: 95%;padding-bottom: 10px;",
                                       #            circleButton(inputId = "rentabHelp", icon = icon("question", verify_fa = FALSE), size="sm", style="background-color:white; border-color: #022F5A;")),
                                       #        tags$head(tags$style(".modal-dialog{ width:1200px}"))
                                       # ),
                                   ),
                                   uiOutput("downPlotRenyi2"),
                                   plotly::plotlyOutput("plotRenyi"),
                                   busyIndicator(wait = 500),
                                   hr(),                                
                                   h4("Value table"),
                                   # div(style="display:block;margin-left: 97.25%;padding-bottom: 10px;",
                                   #     circleButton(inputId = "rentabHelp", icon = icon("question", verify_fa = FALSE), size="sm")),
                                   # tags$head(tags$style(".modal-dialog{ width:1200px}")),
                                   downloadButton("downloaddataRenyi", "Export table", style="background-color:white; border-color: #022F5A"),
                                   dataTableOutput("dataRenyi"),
                                   busyIndicator(wait = 500)
                          )
                          )
                          )
                      )
                   )


clonalstats<- tabItem(tabName = "showClonalTab",
                      fluidRow(
                          tabBox(width = 12,
                          tabPanel("Occurrence intervals ",
                                   fluidRow(div(style="display:block;margin-left: 97%;padding-bottom: 0px;",
                                                circleButton(inputId = "basiccountintHelp", icon = icon("question", verify_fa = FALSE), #size="sm", 
                                                             style="background-color: #337ab7; border-color: #337ab7; margin-top: -10px;
                                                                      border-radius: 25px;  font-size: 15px; height: 25px; color:white;
                                                                      line-height: 50%; padding: 2px 0; text-align: center; width: 25px;")),
                                            tags$head(tags$style(".modal-dialog{ width:1200px}")),
                                       column(width = 2, style="margin-top: -22px; font-size:14px",
                                              selectizeInput(
                                                  "countIntLevel",
                                                  "Select a level",
                                                  choices = list("ntCDR3", "aaCDR3", "aaClone", "ntClone"),
                                                  options = list(onInitialize = I('function() { this.setValue(""); }')))
                                       ),
                                       column(width = 2, style="margin-top: -22px; font-size:14px",
                                              selectizeInput("countIntGroupMeth", 
                                                             "Select a statistics scale",
                                                             choices = list("frequency", "count", "log"),
                                                             options = list(onInitialize = I('function() { this.setValue(""); }')))
                                       ),
                                       column(width = 2,  style="margin-top: -22px; font-size:14px",
                                              selectizeInput("countIntCalType", 
                                                             "Select a calculation type",
                                                             choices = list("distribution", "cumulative frequency"),
                                                             options = list(onInitialize = I('function() { this.setValue(""); }')))
                                       ),
                                       column(width = 4, style="margin-top: -22px; font-size:14px",
                                              uiOutput("countIntfacet")
                                       )
                                       # column(width = 1,
                                       #        div(style="display:block;margin-left: 99%;padding-bottom: 10px;",
                                       #            circleButton(inputId = "basiccountintHelp", icon = icon("question", verify_fa = FALSE), size="sm", style="background-color:white; border-color: #022F5A;")),
                                       #        tags$head(tags$style(".modal-dialog{ width:1200px}"))
                                       # )
                                   ),
                                   uiOutput("downPlotCountIntervals2"),
                                   div(plotOutput("CountIntervals", width = "50%", height="600px"), align = "center"),
                                   busyIndicator(wait = 500)
                                   ),
                          tabPanel("Rank distribution", 
                                   fluidRow(div(style="display:block;margin-left: 97%;padding-bottom: 0px;",
                                                circleButton(inputId = "rankdistribHelp", icon = icon("question", verify_fa = FALSE), #size="sm", 
                                                             style="background-color: #337ab7; border-color: #337ab7; margin-top: -10px;
                                                                      border-radius: 25px;  font-size: 15px; height: 25px; color:white;
                                                                      line-height: 50%; padding: 2px 0; text-align: center; width: 25px;")),
                                            tags$head(tags$style(".modal-dialog{ width:1200px}")),
                                       column(width = 2, style="margin-top: -22px; font-size:14px",
                                              selectizeInput("rankDistribGroupMeth", 
                                                          "Select a scale",
                                                          choices = list("frequency", "count", "log"),
                                                          options = list(onInitialize = I('function() { this.setValue(""); }')))
                                       ),
                                       column(width = 2,  style="margin-top: -22px; font-size:14px",
                                              selectizeInput("rankDistribLevel", 
                                                          "Select a level",
                                                          choices = list("ntCDR3", "aaCDR3", "aaClone", "ntClone"),
                                                          options = list(onInitialize = I('function() { this.setValue(""); }')))
                                       ),
                                       column(width = 2, style="margin-top: -22px; font-size:14px",
                                              uiOutput("rankDistribcolor")
                                       ),
                                       column(width = 2, style="margin-top: -22px; font-size:14px",
                                              sliderInput(inputId = "rankDistribSize",
                                                          label = HTML("Select maximum rank <span style='font-weight: normal; font-size: 13px; font-style: italic;'>(optional)</span>"),
                                                          value = 1000,
                                                          min = 1,
                                                          max = 1000000)
                                       ),
                                       column(width = 4, style="margin-top: -22px; font-size:14px",
                                              uiOutput("rankDistribfacet")
                                       )
                                       # column(width = 2,
                                       #        div(style="display:block;margin-left: 98.25%;padding-bottom: 10px;",
                                       #            circleButton(inputId = "rankdistribHelp", icon = icon("question", verify_fa = FALSE), size="sm", style="background-color:white; border-color: #022F5A;")),
                                       #        tags$head(tags$style(".modal-dialog{ width:1200px}"))
                                       # )
                                   ),
                                   uiOutput("downPlotrankDistrib"),
                                   plotly::plotlyOutput("rankDistrib"),
                                   busyIndicator(wait = 500)
                          )
                          )
                          )
                      )

