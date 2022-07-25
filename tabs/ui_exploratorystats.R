basicstats <- 
    tabItem(tabName = "showBasicTab", 
        fluidRow(
            tabBox(width = 12,
                tabPanel("Visualize the metaData statistics",
                    fluidRow(
                        column(width = 3,
                               uiOutput("plotStats")
                        ),
                        column(width = 3,
                               uiOutput("statGroup")
                        )
                    ), 
                    plotOutput("plotStatistic"), 
                    busyIndicator(wait = 500)
                 ),
                tabPanel("Calculate the count or the proportion of a chosen repertoire level",
                         fluidRow(
                             column(width = 3,
                                    selectizeInput(
                                        "countLevel",
                                        "Select level",
                                        choices = list("clone", "V", "J", "VJ", "CDR3aa", "clonotype", "CDR3nt"),
                                        options = list(onInitialize = I('function() { this.setValue(""); }')))
                             ),
                             column(width = 3,
                                    selectizeInput(
                                        "countScale",
                                        "Select scale",
                                        choices = list("count", "frequency"),
                                        options = list(onInitialize = I('function() { this.setValue(""); }')))
                             )
                         ),
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
                                       column(width = 3,
                                              uiOutput("rareChoiceGroup")
                                       ),
                                       column(width = 3,
                                              radioButtons(inputId = "samplingchoice", 
                                              label = "Transformation method:", 
                                              choices = c("No" = "N", "Downsampling" = "Y"))
                                       ),
                                       column(width = 6,
                                              conditionalPanel("input.samplingchoice == 'Y'",
                                                               fluidRow(
                                                                   column(width = 3,
                                                                          uiOutput("downlibsize")
                                                                   ),
                                                                   column(width = 3,
                                                                          numericInput(inputId = "downseed",
                                                                                       label = "Set seed",
                                                                                       value = 1234,
                                                                                       min = 1,
                                                                                       max = 9999,
                                                                                       width = NULL)
                                                                   ),
                                                                   column(width = 3,
                                                                          actionButton("down", "Downsampling")
                                                                   )
                                                              )
                                            )
                                     )
                                ),
                                plotOutput("rarecurves"), 
                                busyIndicator(wait = 50),
                                plotly::plotlyOutput("libsizes"),
                                busyIndicator(wait = 50),
                                value = "rarefaction",
                                tags$hr(),
                                h4(textOutput("dataselected")),
                                plotOutput("histdownlibsizes")
                                ),
                          tabPanel("Calculation of diversity indices",
                                   fluidRow(
                                       column(width = 3,
                                              selectizeInput(
                                                  "divIndex",
                                                  "Select index",
                                                  choices = list("chao1", "shannon", "simpson", "invsimpson", "gini", "iChao"),
                                                  selected = "chao1")
                                       ),
                                       column(width = 3,
                                              selectizeInput(
                                                  "divLevel",
                                                  "Select level",
                                                  choices = list("clone", "clonotype", "V", "J", "VJ", "CDR3nt", "CDR3aa"),
                                                  selected = "clone")
                                       ),
                                       column(width = 3,
                                              uiOutput("divGroup")
                                       )
                                   ), 
                                   plotOutput("plotDiv"), 
                                   busyIndicator(wait = 500),
                                   h4(textOutput("Diversity table")),
                                   dataTableOutput("dataDiv"),
                                   busyIndicator(wait = 500)
                                   ),
                          tabPanel("Evaluation of the Renyi diversity",
                                   fluidRow(
                                       column(width = 3,
                                              selectizeInput(
                                                  "renyiLevel",
                                                  "Select level",
                                                  choices = list("clone", "clonotype", "V", "J", "VJ", "CDR3nt", "CDR3aa"),
                                                  selected = "clone")
                                       ),
                                       column(width = 3,
                                              uiOutput("renyiGroup")
                                       )
                                   ),
                                   plotOutput("plotRenyi"),
                                   busyIndicator(wait = 500),
                                   h4(textOutput("Renyi diversity table")),
                                   dataTableOutput("dataRenyi"),
                                   busyIndicator(wait = 500)
                          )
                          )
                          )
                   )


clonalstats<- tabItem(tabName = "showClonalTab",
                      fluidRow(
                          tabBox(width = 12,
                          tabPanel("Clonal distribution with count intervals",
                                   fluidRow(
                                       column(width = 3,
                                              selectizeInput(
                                                  "countIntLevel",
                                                  "Select level",
                                                  choices = list("clone", "clonotype", "V", "J", "VJ", "CDR3nt", "CDR3aa"),
                                                  selected = "clone")
                                       ),
                                       column(width = 3,
                                              uiOutput("countIntGroup")
                                       )
                                   ),
                                   plotOutput("CountIntervals"),
                                   busyIndicator(wait = 500)
                                   ),
                          tabPanel("Clonal distribution per decreasing rank", 
                                   fluidRow(
                                       column(width = 4, 
                                              selectInput("rankDistribGroupMeth", 
                                                          "Select method",
                                                          choices = list("count" = "count", "frequency" = "frequency"), 
                                                          selected = "count"   
                                              )
                                       ),
                                       column(width = 4, 
                                              selectInput("rankDistribLevel", 
                                                          "Select level",
                                                          choices = list("clone", "clonotype", "CDR3nt", "CDR3aa"), 
                                                          selected = "clone" 
                                              )
                                       ),
                                       column(width = 4, 
                                              uiOutput("rankDistribGroup")
                                       )
                                   ),
                                   plotOutput("rankDistrib"),
                                   busyIndicator(wait = 500)
                          )
                          )
                          )
                      )

