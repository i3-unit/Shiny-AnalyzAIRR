CompBasicTab<- 
    tabItem(tabName = "showCompBasicTab",
        fluidRow(
            tabBox(width = 12,
                tabPanel("Metadata statistics",
                    fluidRow(
                        column(width = 2,
                               uiOutput("statisticsStat")
                        ),
                        column(width = 2,
                               uiOutput("statisticsGroup")
                        ),
                        column(width = 8,
                               div(style="display:block;margin-left: 95%;padding-bottom: 10px;",
                                   circleButton(inputId = "statsHelp", icon = icon("question", verify_fa = FALSE), size="sm")),
                               tags$head(tags$style(".modal-dialog{ width:1200px}"))
                        )
                    ),
                    uiOutput("downPlotStatistics"),
                    plotOutput("Statistics"),
                    busyIndicator(wait = 500)
                ),
                tabPanel("Repertoire diversity",
                         fluidRow(
                             column(width = 2,
                                    selectizeInput("diverLevel",
                                                   "Select a level",
                                                   choices = list("V", "J", "VJ", "clone", "clonotype", "CDR3nt", "CDR3aa"),
                                                   options = list(onInitialize = I('function() { this.setValue(""); }')))
                             ), 
                             column(width = 2,
                                    selectizeInput("diverIndex",
                                                   "Select an index",
                                                   choices = list("chao1", "shannon", "simpson", "invsimpson", "gini", "iChao"),
                                                   options = list(onInitialize = I('function() { this.setValue(""); }')))
                             ),
                             column(width = 2,
                                    uiOutput("diverGroup")
                             ),
                             column(width = 6,
                                    div(style="display:block;margin-left: 95%;padding-bottom: 10px;",
                                        circleButton(inputId = "DivHelp", icon = icon("question", verify_fa = FALSE), size="sm")),
                                    tags$head(tags$style(".modal-dialog{ width:1200px}"))
                             )
                         ),
                         uiOutput("downPlotDiversity"),
                         plotOutput("Diversity"),
                         busyIndicator(wait = 500),
                         hr(),
                         div(style="display:block;margin-left: 97.5%;padding-bottom: 10px;",
                             circleButton(inputId = "RenHelp", icon = icon("question", verify_fa = FALSE), size="sm")),
                         tags$head(tags$style(".modal-dialog{ width:1200px}")),
                         uiOutput("downPlotRenyi"),
                         plotOutput("RenyiDiversity"),
                         busyIndicator(wait = 500)
                ),
                tabPanel("Clonal distribution",
                         fluidRow(
                             column(width = 2,
                                    selectizeInput("countIntervalsLevel",
                                                   "Select a level",
                                                   choices = list("clone", "clonotype", "CDR3nt", "CDR3aa"),
                                                   options = list(onInitialize = I('function() { this.setValue(""); }')))
                             ), 
                             column(width = 2,
                                    uiOutput("countIntervalsGroup")
                             ),
                             column(width = 8,
                                    div(style="display:block;margin-left: 95%;padding-bottom: 10px;",
                                        circleButton(inputId = "CIHelp", icon = icon("question", verify_fa = FALSE), size="sm")),
                                    tags$head(tags$style(".modal-dialog{ width:1200px}"))
                             )
                         ),
                         uiOutput("downPlotCountInt"),
                         plotOutput("CountInt"),
                         busyIndicator(wait = 500)
                )
            )
        )
    )

SimTab<- 
    tabItem(tabName = "showSimTab",
            fluidRow(
                tabBox(width = 12,
                       tabPanel("Repertoire overlap",
                           fluidRow(
                               column(width = 2,
                                   selectizeInput("vennLevel",
                                       "Select a level",
                                       choices = list("V", "J", "VJ", "clone", "clonotype", "CDR3nt", "CDR3aa"),
                                       options = list(onInitialize = I('function() { this.setValue(""); }'))
                                   )
                               ),
                               column(width = 2,
                                       uiOutput("vennUISample")
                               ),
                               column(width = 2,
                                      sliderInput(inputId = "vennSeed",
                                                  label = "Set a seed",
                                                  value = 1234,
                                                  min = 1,
                                                  max = 9999,
                                                  width = NULL)
                               ),
                               column(width = 6,
                                      div(style="display:block;margin-left: 95%;padding-bottom: 10px;",
                                          circleButton(inputId = "eulerHelp", icon = icon("question", verify_fa = FALSE), size="sm")),
                                      tags$head(tags$style(".modal-dialog{ width:1200px}"))
                               )

                           ),
                           uiOutput("downPlotEulerr"),
                           plotOutput("plotEulerr", height = 800, width = 800),
                           busyIndicator(wait = 500)
                       ),
                       tabPanel("Repertoire correlation",
                                fluidRow(
                                    column(width = 2,
                                           selectizeInput("scatterLevel",
                                                          "Select a level",
                                                          choices = list("V", "J", "VJ", "clone", "clonotype", "CDR3nt", "CDR3aa"),
                                                          options = list(onInitialize = I('function() { this.setValue(""); }'))
                                           )
                                    ),
                                    column(width = 2,
                                           selectizeInput("scatterScale",
                                                          "Select a scale",
                                                          choices = list("frequency", "log"),
                                                          options = list(onInitialize = I('function() { this.setValue(""); }'))
                                           )
                                    ),
                                    column(width = 2,
                                           uiOutput("scatterUISample")
                                    ),
                                    column(width = 6,
                                           div(style="display:block;margin-left: 95%;padding-bottom: 10px;",
                                               circleButton(inputId = "scatterHelp", icon = icon("question", verify_fa = FALSE), size="sm")),
                                           tags$head(tags$style(".modal-dialog{ width:1200px}"))
                                    )
                                    
                                ),
                                uiOutput("downPlotScatter"),
                                plotOutput("Scatter"),
                                busyIndicator(wait = 500)
                       ),
                       tabPanel("Dissimilarity indices",
                                h4("Heatmap parameters"),
                                fluidRow(
                                    column(width = 2,
                                           selectizeInput(
                                               "dissimilarityLevel",
                                               "Select a level",
                                               choices = list("V", "J", "VJ", "clone", "clonotype", "CDR3nt", "CDR3aa"),
                                               options = list(onInitialize = I('function() { this.setValue(""); }'))
                                           )
                                    ),
                                    column(width = 2,
                                           selectizeInput("dissimilarityIndex", "Select a dissimlarity method",
                                                          choices = list("manhattan", "euclidean", "canberra", "clark", "bray", 
                                                                         "kulczynski", "jaccard", "gower", "altGower", "morisita", "horn", 
                                                                         "mountford", "raup", "binomial", "chao", "cao", "mahalanobis"),
                                                          options = list(onInitialize = I('function() { this.setValue(""); }'))
                                           )
                                    ),
                                    column(width = 2,
                                           selectizeInput("dissimilarityClustering", "Select a dissimlarity clustering",
                                                          choices = list("ward.D", "ward.D2", "single", "complete", "average", "mcquitty",
                                                                           "median", "centroid"),
                                                          options = list(onInitialize = I('function() { this.setValue(""); }'))
                                           )
                                    ),
                                    column(width = 6,
                                           div(style="display:block;margin-left: 95%;padding-bottom: 10px;",
                                               circleButton(inputId = "disHMHelp", icon = icon("question", verify_fa = FALSE), size="sm")),
                                           tags$head(tags$style(".modal-dialog{ width:1200px}"))
                                    )
                                ),
                                h4("MDS/PCA parameters"),
                                fluidRow(
                                    
                                    column(width = 3,
                                           selectizeInput("dissimilarityMethod", "Select a dimension reduction method",
                                                          choices = list("MDS", "PCA"),
                                                          options = list(onInitialize = I('function() { this.setValue(""); }'))
                                           )
                                    ),
                                    column(width = 3,
                                           uiOutput("GrpColMDS")
                                    ),
                                    column(width = 6,
                                           div(style="display:block;margin-left: 95%;padding-bottom: 10px;",
                                               circleButton(inputId = "mdsHelp", icon = icon("question", verify_fa = FALSE), size="sm")),
                                           tags$head(tags$style(".modal-dialog{ width:1200px}"))
                                    )
                                ),
                                splitLayout(cellWidths = c("50%", "50%"), uiOutput("downPlotDisHM"), uiOutput("downPlotMDS")),
                                splitLayout(cellWidths = c("50%", "50%"), plotOutput("plotDissimilarityHM"), plotOutput("plotMDS")),
                                busyIndicator(wait = 500),
                                # withMathJax(),
                                # htmlOutput("distFuncsMD"),
                                value = "dissimilarityHM"
                       )
                )
            )
    )



DiffTab<- 
    tabItem(tabName = "showDiffTab",
            #fluidRow(
                #tabBox(width=12,
                 #      tabPanel("",#"Perform differential analysis",
                                    h4("Volcano plot parameters"),
                                    fluidRow(
                                        column(width = 2,
                                               selectizeInput(
                                                   "diffLevel",
                                                   "Select a level",
                                                   choices = list("V", "J", "VJ", "clone", "clonotype", "CDR3nt", "CDR3aa"),
                                                   options = list(onInitialize = I('function() { this.setValue(""); }'))
                                               )
                                        ),
                                        column(width = 2,
                                               uiOutput("diffGroup")
                                        ),
                                        column(width = 2,
                                               sliderInput(inputId = "diffFC",
                                                           label = "Set a fold-change threshold",
                                                           value = 1,
                                                           min = 0,
                                                           max = 10)
                                        ),
                                        column(width = 2,
                                               sliderInput(inputId = "diffPV",
                                                           label = "Set a pvalue threshold",
                                                           value = 0.05,
                                                           min = 0,
                                                           max = 1)
                                        ),
                                        column(width = 4,
                                               div(style="display:block;margin-left: 95%;padding-bottom: 10px;",
                                                   circleButton(inputId = "volcanoHelp", icon = icon("question", verify_fa = FALSE), size="sm")),
                                               tags$head(tags$style(".modal-dialog{ width:1200px}"))
                                        )
                                    ),
                                    h4("PCA/MDS parameters"),
                                    fluidRow(
                                        column(width = 3,
                                           selectizeInput(
                                               "PCAMethod",
                                               "Select a distance method",
                                               choices = list("manhattan", "euclidean", "canberra", "clark", "bray", 
                                                              "kulczynski", "jaccard", "gower", "altGower", "morisita", "horn", 
                                                              "mountford", "raup", "binomial", "chao", "cao", "mahalanobis"),
                                               options = list(onInitialize = I('function() { this.setValue(""); }'))
                                           )
                                        ),
                                        column(width = 3,
                                               selectizeInput(
                                                   "PCAdimMethod",
                                                   "Select a dimension reduction method",
                                                   choices = list("PCA", "MDS"),
                                                   options = list(onInitialize = I('function() { this.setValue(""); }'))
                                               )
                                        ),
                                        column(width = 3,
                                               uiOutput("diffColGroup")
                                        ),
                                        column(width = 3,
                                               div(style="display:block;margin-left: 93%;padding-bottom: 10px;",
                                                   circleButton(inputId = "pcaHelp", icon = icon("question", verify_fa = FALSE), size="sm")),
                                               tags$head(tags$style(".modal-dialog{ width:1200px}"))
                                        )
                                    ),
                                    splitLayout(cellWidths = c("50%", "50%"), uiOutput("downPlotVolcano"), uiOutput("downPlotPCA")),
                                    splitLayout(cellWidths = c("50%", "50%"), plotly::plotlyOutput("Volcano"), plotly::plotlyOutput("plotPCA")),
                                    busyIndicator(wait = 500),
                                    downloadButton("downloadtableDiffExpGroup", "Export table"),
                                    dataTableOutput("tableDiffExpGroup"),
                                    busyIndicator(wait = 500)
                 #      )
                #)
            #)
    )




PertTab<- 
    tabItem(tabName = "showPertTab",
            # fluidRow(
            #     tabBox(width=12,
            #            tabPanel("Compute perturbation scores",
                                fluidRow(
                                    column(width = 2,
                                           uiOutput("PertGroupUI")
                                    ),
                                    column(width = 2,
                                           uiOutput("CtrlGroupUI")
                                    ),
                                    column(width = 2,
                                           uiOutput("PertDistUI")
                                    ),
                                    column(width = 2,
                                           uiOutput("pertOrder")
                                    ),
                                    column(width = 4,
                                           div(style="display:block;margin-left: 95%;padding-bottom: 10px;",
                                               circleButton(inputId = "pertHelp", icon = icon("question", verify_fa = FALSE), size="sm")),
                                           tags$head(tags$style(".modal-dialog{ width:1200px}"))
                                    )
                                ),
                                uiOutput("downPlotPert"),
                                plotOutput("plotPerturbation"),
                                busyIndicator(wait = 500),
                                h4("Perturbation values:"),
                                downloadButton("downloadPertTab", "Export table"),
                                dataTableOutput("PertTab")
            #            )
            #            )
            # )
    )