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
                               div(style="display:block;margin-left: 95%;padding-bottom: 10px;",
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
                                    div(style="display:block;margin-left: 95%;padding-bottom: 10px;",
                                        circleButton(inputId = "countfeaturesHelp", icon = icon("question", verify_fa = FALSE), size="sm")),
                                    tags$head(tags$style(".modal-dialog{ width:1200px}"))
                             )
                         ),
                         hr(),
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
                                            div(style="display:block;margin-left: 95%;padding-bottom: 10px;",
                                                circleButton(inputId = "rareHelp", icon = icon("question", verify_fa = FALSE), size="sm")),
                                            tags$head(tags$style(".modal-dialog{ width:1200px}"))
                                     )
                                ),
                                uiOutput("downPlotRare"),
                                plotOutput("plotrarefaction"), 
                                busyIndicator(wait = 50),
                                h4(textOutput("dataselected")),
                                hr(),
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
                                                  selected = "chao1")
                                       ),
                                       column(width = 2,
                                              selectizeInput(
                                                  "divLevel",
                                                  "Select a level",
                                                  choices = list("clone", "clonotype", "V", "J", "VJ", "CDR3nt", "CDR3aa"),
                                                  selected = "clone")
                                       ),
                                       column(width = 8,
                                              div(style="display:block;margin-left: 95%;padding-bottom: 10px;",
                                                  circleButton(inputId = "basicdivHelp", icon = icon("question", verify_fa = FALSE), size="sm")),
                                              tags$head(tags$style(".modal-dialog{ width:1200px}"))
                                       )
                                   ), 
                                   uiOutput("downPlotDiv"),
                                   plotOutput("plotDiv"), 
                                   busyIndicator(wait = 500),
                                   h4(textOutput("Diversity table")),
                                   hr(),
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
                                                  selected = "clone")
                                       ),
                                       column(width = 10,
                                              div(style="display:block;margin-left: 95%;padding-bottom: 10px;",
                                                  circleButton(inputId = "basicrenHelp", icon = icon("question", verify_fa = FALSE), size="sm")),
                                              tags$head(tags$style(".modal-dialog{ width:1200px}"))
                                       )
                                   ),
                                   uiOutput("downPlotRenyi2"),
                                   plotOutput("plotRenyi"),
                                   busyIndicator(wait = 500),
                                   h4(textOutput("Renyi diversity table")),
                                   hr(),
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
                                                  selected = "clone")
                                       ),
                                       column(width = 10,
                                              div(style="display:block;margin-left: 95%;padding-bottom: 10px;",
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
                                              selectInput("rankDistribGroupMeth", 
                                                          "Select a method",
                                                          choices = list("count" = "count", "frequency" = "frequency"), 
                                                          selected = "count"   
                                              )
                                       ),
                                       column(width = 2, 
                                              selectInput("rankDistribLevel", 
                                                          "Select a level",
                                                          choices = list("clone", "clonotype", "CDR3nt", "CDR3aa"), 
                                                          selected = "clone" 
                                              )
                                       ),
                                       column(width = 8,
                                              div(style="display:block;margin-left: 95%;padding-bottom: 10px;",
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

