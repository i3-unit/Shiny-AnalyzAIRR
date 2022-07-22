basicstats <- 
    tabItem(tabName = "showBasicTab", 
        fluidRow(
            tabBox(width = 12,
                tabPanel("Visualize the metaData statistics",
                    fluidRow(
                        column(width = 3,
                            selectizeInput(
                                "plotStats",
                                "Select stat",
                                choices = list("nSequences", "clone", "clonotype", "V", "J", "VJ", "CDR3aa", "CDR3nt"),
                                options = list(onInitialize = I('function() { this.setValue(""); }')))
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
                          tabPanel("Perturbation analysis",
                                   fluidRow(
                                    column(width = 2, 
                                        uiOutput("PertGroupUI")
                                    ),
                                    column(width = 3,
                                        uiOutput("CtrlGroupUI")
                                    ),
                                    column(width = 3,
                                        uiOutput("PertDistUI")
                                    )
                                   ),
                         splitLayout(cellWidths = c("50%", "50%"), plotOutput("pertPCA"), plotOutput("pertHeatmap")),
                         busyIndicator(wait = 500),
                         hr(),
                         h4("Perturbation values:"),
                         dataTableOutput("PertTab")
                ))))

