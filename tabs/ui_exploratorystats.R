basicstats <- 
    tabItem(tabName = "showBasicTab", 
        fluidRow(
            tabBox(width = 12,
                tabPanel("Metadata statistics",
                         fluidRow(div(style="display:block;margin-left: 97%;padding-bottom: 0px;",
                                      circleButton(inputId = "basicstatsHelp", icon = icon("question", verify_fa = FALSE), #size="sm", 
                                                   style="background-color: #337ab7; border-color: #337ab7; margin-top: -10px;
                                                                      border-radius: 25px;  font-size: 15px; height: 25px; color:white;
                                                                      line-height: 50%; padding: 2px 0; text-align: center; width: 25px;")),
                                  tags$head(tags$style(".modal-dialog{ width:1200px}")),
                        column(width = 2, style="margin-top: -22px;",
                               uiOutput("plotStats")
                        ),
                       column(width = 2, style="margin-top: -22px;",
                               uiOutput("plotcolorgroup")
                        ),
                        column(width = 5, style="margin-top: -22px;",
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
                tabPanel("Detailed repertoire level statistics",
                         fluidRow(div(style="display:block;margin-left: 97%;padding-bottom: 0px;",
                                      circleButton(inputId = "countfeaturesHelp", icon = icon("question", verify_fa = FALSE), #size="sm", 
                                                   style="background-color: #337ab7; border-color: #337ab7; margin-top: -10px;
                                                                      border-radius: 25px;  font-size: 15px; height: 25px; color:white;
                                                                      line-height: 50%; padding: 2px 0; text-align: center; width: 25px;")),
                                  tags$head(tags$style(".modal-dialog{ width:1200px}")),
                             column(width = 2, style="margin-top: -22px;",
                                    selectizeInput(
                                        "countLevel",
                                        "Select a level",
                                        choices = list("V", "J", "VJ", "ntCDR3", "aaCDR3", "aaClone", "ntClone"),
                                        options = list(onInitialize = I('function() { this.setValue(""); }')))
                             ),
                             column(width = 2, style="margin-top: -22px;",
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
                         dataTableOutput("dataCountFeatures"),
                         busyIndicator(wait = 500)

                )
              )
           )
        )


divstats<- tabItem(tabName = "showDivTab",
                      fluidRow(
                          tabBox(width = 12,
                          tabPanel("Rarefaction analysis",
                                   fluidRow(div(style="display:block;margin-left: 97%;padding-bottom: 0px;",
                                                circleButton(inputId = "raretabHelp", icon = icon("question", verify_fa = FALSE), #size="sm", 
                                                             style="background-color: #337ab7; border-color: #337ab7; margin-top: -10px;
                                                                      border-radius: 25px;  font-size: 15px; height: 25px; color:white;
                                                                      line-height: 50%; padding: 2px 0; text-align: center; width: 25px;")),
                                            tags$head(tags$style(".modal-dialog{ width:1200px}")),
                                     column(width = 2, style="margin-top: -22px;",
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
                                hr(),
                                h4("Table of values"),
                                # div(style="display:block;margin-left: 97.25%;padding-bottom: 10px;",
                                #     circleButton(inputId = "raretabHelp", icon = icon("question", verify_fa = FALSE), size="sm")),
                                # tags$head(tags$style(".modal-dialog{ width:1200px}")),
                                downloadButton("downloaddataRare", "Export table", style="background-color:white; border-color: #022F5A;"),
                                dataTableOutput("dataRare"),
                                busyIndicator(wait = 500)
                                ),
                          tabPanel("Diversity indices",
                                   fluidRow(div(style="display:block;margin-left: 97%;padding-bottom: 0px;",
                                                circleButton(inputId = "divtabHelp", icon = icon("question", verify_fa = FALSE), #size="sm", 
                                                             style="background-color: #337ab7; border-color: #337ab7; margin-top: -10px;
                                                                      border-radius: 25px;  font-size: 15px; height: 25px; color:white;
                                                                      line-height: 50%; padding: 2px 0; text-align: center; width: 25px;")),
                                            tags$head(tags$style(".modal-dialog{ width:1200px}")),
                                       column(width = 2, style="margin-top: -22px;",
                                              selectizeInput(
                                                  "divIndex",
                                                  "Select an index",
                                                  choices = list("chao1", "shannon", "simpson", "invsimpson", "bergerparker", "gini", "iChao"),
                                                  options = list(onInitialize = I('function() { this.setValue(""); }')))
                                       ),
                                       column(width = 2, style="margin-top: -22px;",
                                              selectizeInput(
                                                  "divLevel",
                                                  "Select a level",
                                                  choices = list("V", "J", "VJ", "ntCDR3", "aaCDR3", "aaClone", "ntClone"),
                                                  options = list(onInitialize = I('function() { this.setValue(""); }')))
                                       ),
                                       column(width = 2, style="margin-top: -22px;",
                                              uiOutput("divcolor")
                                       ),
                                       column(width = 4, style="margin-top: -22px;",
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
                                   h4("Table of values"),
                                   # div(style="display:block;margin-left: 97.25%;padding-bottom: 10px;",
                                   #  circleButton(inputId = "divtabHelp", icon = icon("question", verify_fa = FALSE), size="sm")),
                                   # tags$head(tags$style(".modal-dialog{ width:1200px}")),
                                   downloadButton("downloaddataDiv", "Export table",style="background-color:white; border-color: #022F5A;"),
                                   dataTableOutput("dataDiv"),
                                   busyIndicator(wait = 500)
                                   ),
                          tabPanel("Renyi index",
                                   fluidRow(div(style="display:block;margin-left: 97%;padding-bottom: 0px;",
                                                circleButton(inputId = "rentabHelp", icon = icon("question", verify_fa = FALSE), #size="sm", 
                                                             style="background-color: #337ab7; border-color: #337ab7; margin-top: -10px;
                                                                      border-radius: 25px;  font-size: 15px; height: 25px; color:white;
                                                                      line-height: 50%; padding: 2px 0; text-align: center; width: 25px;")),
                                            tags$head(tags$style(".modal-dialog{ width:1200px}")),
                                       column(width = 2, style="margin-top: -22px;",
                                              selectizeInput(
                                                  "renyiLevel",
                                                  "Select a level",
                                                  choices = list("V", "J", "VJ", "ntCDR3", "aaCDR3", "aaClone", "ntClone"),
                                                  options = list(onInitialize = I('function() { this.setValue(""); }')))
                                       ),
                                       column(width = 2, style="margin-top: -22px;",
                                              uiOutput("renyicolor")
                                       ),
                                       column(width = 3, style="margin-top: -22px;",
                                              uiOutput("renyishape")
                                       ),
                                       column(width = 4, style="margin-top: -22px;",
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
                                   h4("Table of values"),
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
                                       column(width = 2, style="margin-top: -22px;",
                                              selectizeInput(
                                                  "countIntLevel",
                                                  "Select a level",
                                                  choices = list("ntCDR3", "aaCDR3", "aaClone", "ntClone"),
                                                  options = list(onInitialize = I('function() { this.setValue(""); }')))
                                       ),
                                       column(width = 2,  style="margin-top: -22px;",
                                              selectizeInput("countIntGroupMeth", 
                                                             "Select a statistics scale",
                                                             choices = list("count" , "frequency"),
                                                             options = list(onInitialize = I('function() { this.setValue(""); }')))
                                       ),
                                       column(width = 4, style="margin-top: -22px;",
                                              uiOutput("countIntfacet")
                                       )
                                       # column(width = 1,
                                       #        div(style="display:block;margin-left: 99%;padding-bottom: 10px;",
                                       #            circleButton(inputId = "basiccountintHelp", icon = icon("question", verify_fa = FALSE), size="sm", style="background-color:white; border-color: #022F5A;")),
                                       #        tags$head(tags$style(".modal-dialog{ width:1200px}"))
                                       # )
                                   ),
                                   uiOutput("downPlotCountIntervals2"),
                                   plotOutput("CountIntervals"),
                                   busyIndicator(wait = 500)
                                   ),
                          tabPanel("Rank distribution", 
                                   fluidRow(div(style="display:block;margin-left: 97%;padding-bottom: 0px;",
                                                circleButton(inputId = "rankdistribHelp", icon = icon("question", verify_fa = FALSE), #size="sm", 
                                                             style="background-color: #337ab7; border-color: #337ab7; margin-top: -10px;
                                                                      border-radius: 25px;  font-size: 15px; height: 25px; color:white;
                                                                      line-height: 50%; padding: 2px 0; text-align: center; width: 25px;")),
                                            tags$head(tags$style(".modal-dialog{ width:1200px}")),
                                       column(width = 2,  style="margin-top: -22px;",
                                              selectizeInput("rankDistribGroupMeth", 
                                                          "Select a scale",
                                                          choices = list("count" = "count", "frequency" = "frequency"),
                                                          options = list(onInitialize = I('function() { this.setValue(""); }')))
                                       ),
                                       column(width = 2,  style="margin-top: -22px;",
                                              selectizeInput("rankDistribLevel", 
                                                          "Select a level",
                                                          choices = list("ntCDR3", "aaCDR3", "aaClone", "ntClone"),
                                                          options = list(onInitialize = I('function() { this.setValue(""); }')))
                                       ),
                                       column(width = 2, style="margin-top: -22px;",
                                              uiOutput("rankDistribcolor")
                                       ),
                                       column(width = 4, style="margin-top: -22px;",
                                              uiOutput("rankDistribfacet")
                                       )
                                       # column(width = 2,
                                       #        div(style="display:block;margin-left: 98.25%;padding-bottom: 10px;",
                                       #            circleButton(inputId = "rankdistribHelp", icon = icon("question", verify_fa = FALSE), size="sm", style="background-color:white; border-color: #022F5A;")),
                                       #        tags$head(tags$style(".modal-dialog{ width:1200px}"))
                                       # )
                                   ),
                                   uiOutput("downPlotrankDistrib"),
                                   plotOutput("rankDistrib"),
                                   busyIndicator(wait = 500)
                          )
                          )
                          )
                      )

