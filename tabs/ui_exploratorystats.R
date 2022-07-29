basicstats <- 
    tabItem(tabName = "showBasicTab", 
        fluidRow(
            tabBox(width = 12,
                tabPanel("Metadata statistics",
                    fluidRow(
                        column(width = 2,
                               uiOutput("plotStats")
                        ),
                        column(width = 10,
                               div(style="display:block;margin-left: 97%;padding-bottom: 10px;",
                                   circleButton(inputId = "basicstatsHelp", icon = icon("question", verify_fa = FALSE), size="sm")),
                               tags$head(tags$style(".modal-dialog{ width:1200px}"))
                        )
                    ), 
                    uiOutput("downPlotStatsBasic"),
                    plotOutput("plotStatistic"), 
                    busyIndicator(wait = 500)
                 ),
                tabPanel("Detailed repertoire level statistics",
                         fluidRow(
                             column(width = 2,
                                    selectizeInput(
                                        "countLevel",
                                        "Select a level",
                                        choices = list("clone", "V", "J", "VJ", "CDR3aa", "clonotype", "CDR3nt"),
                                        options = list(onInitialize = I('function() { this.setValue(""); }')))
                             ),
                             column(width = 2,
                                    selectizeInput(
                                        "countScale",
                                        "Select a scale",
                                        choices = list("count", "frequency"),
                                        options = list(onInitialize = I('function() { this.setValue(""); }')))
                             ),
                             column(width = 8,
                                    div(style="display:block;margin-left: 96.25%;padding-bottom: 10px;",
                                        circleButton(inputId = "countfeaturesHelp", icon = icon("question", verify_fa = FALSE), size="sm")),
                                    tags$head(tags$style(".modal-dialog{ width:1200px}"))
                             )
                         ),
                         downloadButton("downloadCountFeatures", "Export table"),
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
                                   fluidRow(
                                     column(width = 2,
                                            uiOutput("plotRare")
                                     ),
                                     column(width = 10,
                                            div(style="display:block;margin-left: 97%;padding-bottom: 10px;",
                                                circleButton(inputId = "rareHelp", icon = icon("question", verify_fa = FALSE), size="sm")),
                                            tags$head(tags$style(".modal-dialog{ width:1200px}"))
                                     )
                                ),
                                uiOutput("downPlotRare"),
                                plotly::plotlyOutput("plotrarefaction"), 
                                busyIndicator(wait = 50),
                                hr(),
                                h4("Results"),
                                div(style="display:block;margin-left: 97.25%;padding-bottom: 10px;",
                                    circleButton(inputId = "raretabHelp", icon = icon("question", verify_fa = FALSE), size="sm")),
                                tags$head(tags$style(".modal-dialog{ width:1200px}")),
                                downloadButton("downloaddataRare", "Export table"),
                                dataTableOutput("dataRare"),
                                busyIndicator(wait = 500)
                                ),
                          tabPanel("Diversity indices",
                                   fluidRow(
                                       column(width = 2,
                                              selectizeInput(
                                                  "divIndex",
                                                  "Select an index",
                                                  choices = list("chao1", "shannon", "simpson", "invsimpson", "gini", "iChao"),
                                                  options = list(onInitialize = I('function() { this.setValue(""); }')))
                                       ),
                                       column(width = 2,
                                              selectizeInput(
                                                  "divLevel",
                                                  "Select a level",
                                                  choices = list("clone", "clonotype", "V", "J", "VJ", "CDR3nt", "CDR3aa"),
                                                  options = list(onInitialize = I('function() { this.setValue(""); }')))
                                       ),
                                       column(width = 8,
                                              div(style="display:block;margin-left: 96.25%;padding-bottom: 10px;",
                                                  circleButton(inputId = "basicdivHelp", icon = icon("question", verify_fa = FALSE), size="sm")),
                                              tags$head(tags$style(".modal-dialog{ width:1200px}"))
                                       )
                                   ), 
                                   uiOutput("downPlotDiv"),
                                   plotOutput("plotDiv"), 
                                   busyIndicator(wait = 500),
                                   hr(),
                                   h4("Results"),
                                   div(style="display:block;margin-left: 97.25%;padding-bottom: 10px;",
                                       circleButton(inputId = "divtabHelp", icon = icon("question", verify_fa = FALSE), size="sm")),
                                   tags$head(tags$style(".modal-dialog{ width:1200px}")),
                                   downloadButton("downloaddataDiv", "Export table"),
                                   dataTableOutput("dataDiv"),
                                   busyIndicator(wait = 500)
                                   ),
                          tabPanel("Renyi index",
                                   fluidRow(
                                       column(width = 2,
                                              selectizeInput(
                                                  "renyiLevel",
                                                  "Select a level",
                                                  choices = list("clone", "clonotype", "V", "J", "VJ", "CDR3nt", "CDR3aa"),
                                                  options = list(onInitialize = I('function() { this.setValue(""); }')))
                                       ),
                                       column(width = 10,
                                              div(style="display:block;margin-left: 97%;padding-bottom: 10px;",
                                                  circleButton(inputId = "basicrenHelp", icon = icon("question", verify_fa = FALSE), size="sm")),
                                              tags$head(tags$style(".modal-dialog{ width:1200px}"))
                                       )
                                   ),
                                   uiOutput("downPlotRenyi2"),
                                   plotly::plotlyOutput("plotRenyi"),
                                   busyIndicator(wait = 500),
                                   hr(),                                
                                   h4("Results"),
                                   div(style="display:block;margin-left: 97.25%;padding-bottom: 10px;",
                                       circleButton(inputId = "rentabHelp", icon = icon("question", verify_fa = FALSE), size="sm")),
                                   tags$head(tags$style(".modal-dialog{ width:1200px}")),
                                   downloadButton("downloaddataRenyi", "Export table"),
                                   dataTableOutput("dataRenyi"),
                                   busyIndicator(wait = 500)
                          )
                          )
                          )
                   )


clonalstats<- tabItem(tabName = "showClonalTab",
                      fluidRow(
                          tabBox(width = 12,
                          tabPanel("Per count interval",
                                   fluidRow(
                                       column(width = 2,
                                              selectizeInput(
                                                  "countIntLevel",
                                                  "Select a level",
                                                  choices = list("clone", "clonotype", "V", "J", "VJ", "CDR3nt", "CDR3aa"),
                                                  options = list(onInitialize = I('function() { this.setValue(""); }')))
                                       ),
                                       column(width = 10,
                                              div(style="display:block;margin-left: 97%;padding-bottom: 10px;",
                                                  circleButton(inputId = "basiccountintHelp", icon = icon("question", verify_fa = FALSE), size="sm")),
                                              tags$head(tags$style(".modal-dialog{ width:1200px}"))
                                       )
                                   ),
                                   uiOutput("downPlotCountIntervals2"),
                                   plotOutput("CountIntervals"),
                                   busyIndicator(wait = 500)
                                   ),
                          tabPanel("Per decreasing rank", 
                                   fluidRow(
                                       column(width = 2, 
                                              selectizeInput("rankDistribGroupMeth", 
                                                          "Select a method",
                                                          choices = list("count" = "count", "frequency" = "frequency"),
                                                          options = list(onInitialize = I('function() { this.setValue(""); }')))
                                       ),
                                       column(width = 2, 
                                              selectizeInput("rankDistribLevel", 
                                                          "Select a level",
                                                          choices = list("clone", "clonotype", "CDR3nt", "CDR3aa"),
                                                          options = list(onInitialize = I('function() { this.setValue(""); }')))
                                       ),
                                       column(width = 8,
                                              div(style="display:block;margin-left: 96.25%;padding-bottom: 10px;",
                                                  circleButton(inputId = "rankdistribHelp", icon = icon("question", verify_fa = FALSE), size="sm")),
                                              tags$head(tags$style(".modal-dialog{ width:1200px}"))
                                       )
                                   ),
                                   uiOutput("downPlotrankDistrib"),
                                   plotOutput("rankDistrib"),
                                   busyIndicator(wait = 500)
                          )
                          )
                          )
                      )

