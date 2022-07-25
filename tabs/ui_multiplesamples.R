CompBasicTab<- 
    tabItem(tabName = "showCompBasicTab",
        fluidRow(
            tabBox(width = 12,
                tabPanel("Compare metaData statistics",
                    fluidRow(
                        column(width = 3,
                               uiOutput("statisticsStat")
                        ),
                        column(width = 3,
                               uiOutput("statisticsGroup")
                        )
                    ),
                    plotOutput("Statistics"),
                    busyIndicator(wait = 500)
                ),
                tabPanel("Compare repertoire diversities",
                         fluidRow(
                             column(width = 2,
                                    selectizeInput("diverLevel",
                                                   "Select level",
                                                   choices = list("V", "J", "VJ", "clone", "clonotype", "CDR3nt", "CDR3aa"),
                                                   options = list(onInitialize = I('function() { this.setValue(""); }')))
                             ), 
                             column(width = 2,
                                    selectizeInput("diverIndex",
                                                   "Select index",
                                                   choices = list("chao1", "shannon", "simpson", "invsimpson", "gini", "iChao"),
                                                   options = list(onInitialize = I('function() { this.setValue(""); }')))
                             ),
                             column(width = 3,
                                    uiOutput("diverGroup")
                             )
                         ),
                         plotOutput("Diversity"),
                         busyIndicator(wait = 500),
                         plotOutput("RenyiDiversity"),
                         busyIndicator(wait = 500)
                ),
                tabPanel("Compare clonal distributions",
                         fluidRow(
                             column(width = 2,
                                    selectizeInput("countIntervalsLevel",
                                                   "Select level",
                                                   choices = list("clone", "clonotype", "CDR3nt", "CDR3aa"),
                                                   options = list(onInitialize = I('function() { this.setValue(""); }')))
                             ), 
                             column(width = 3,
                                    uiOutput("countIntervalsGroup")
                             )
                         ),
                         plotOutput("CountInt"),
                         busyIndicator(wait = 500)
                )

                # tabPanel("Sample correlation",
                #     fluidRow(
                #         column(width = 3,
                #             selectizeInput("count2v2Level",
                #                 "Select level",
                #                 choices = list("V", "J", "VJ", "clone", "clonotype", "CDR3nt", "CDR3aa"),
                #                 options = list(onInitialize = I('function() { this.setValue(""); }'))
                #             )
                #         ),
                #         column(width = 3,
                #             uiOutput("count2v2Libs")
                #         ),
                #         column(width = 3,
                #             radioButtons("count2v2scale", 
                #                 "Choose a scale",
                #                 choices = c("frequency", "log"),  #modified by VMH
                #                 selected = "frequency", #modified by VMH
                #                 inline = T
                #             )
                #         )
                #     ),
                #     plotOutput("plot2v2count", brush = brushOpts(id = "plot2v2count_brush")),
                #     tags$hr(),
                #     uiOutput("downloadSelected"),
                #     dataTableOutput("brush2v2countDT")
                # )
            )
        )
    )

SimTab<- 
    tabItem(tabName = "showSimTab",
            fluidRow(
                tabBox(width = 12,
                       tabPanel("Compare the number of shared sequences",
                           fluidRow(
                               column(width = 2,
                                   selectizeInput("vennLevel",
                                       "Select level",
                                       choices = list("V", "J", "VJ", "clone", "clonotype", "CDR3nt", "CDR3aa"),
                                       options = list(onInitialize = I('function() { this.setValue(""); }'))
                                   )
                               ),
                               column(width = 3,
                                       uiOutput("vennUISample")
                                   )

                           ),
                           plotOutput("plotEulerr", height = 800, width = 800),
                           busyIndicator(wait = 500)
                       ),
                       tabPanel("Assess the correlation between a pair of samples",
                                fluidRow(
                                    column(width = 2,
                                           selectizeInput("scatterLevel",
                                                          "Select level",
                                                          choices = list("V", "J", "VJ", "clone", "clonotype", "CDR3nt", "CDR3aa"),
                                                          options = list(onInitialize = I('function() { this.setValue(""); }'))
                                           )
                                    ),
                                    column(width = 2,
                                           selectizeInput("scatterScale",
                                                          "Select scale",
                                                          choices = list("frequency", "log"),
                                                          options = list(onInitialize = I('function() { this.setValue(""); }'))
                                           )
                                    ),
                                    column(width = 3,
                                           uiOutput("scatterUISample")
                                    )
                                    
                                ),
                                plotOutput("Scatter"),
                                busyIndicator(wait = 500)
                       ),
                       tabPanel("Compute dissimilarity distances",
                                fluidRow(
                                    column(width = 5,
                                           selectizeInput(
                                               "dissimilarityLevel",
                                               "Select level",
                                               choices = list("V", "J", "VJ", "clone", "clonotype", "CDR3nt", "CDR3aa"),
                                               options = list(onInitialize = I('function() { this.setValue(""); }'))
                                           )
                                    ),
                                    column(width = 5,
                                           selectizeInput("dissimilarityIndex", "Select dissimlarity Index",
                                                          choices = list("manhattan", "euclidean", "canberra", "clark", "bray", 
                                                                         "kulczynski", "jaccard", "gower", "altGower", "morisita", "horn", 
                                                                         "mountford", "raup", "binomial", "chao", "cao", "mahalanobis"),
                                                          options = list(onInitialize = I('function() { this.setValue(""); }'))
                                           )
                                    ),
                                    column(width = 5,
                                           selectizeInput("dissimilarityClustering", "Select dissimlarity Clustering",
                                                          choices = list("ward.D", "ward.D2", "single", "complete", "average", "mcquitty",
                                                                         "median", "centroid"),
                                                          options = list(onInitialize = I('function() { this.setValue(""); }'))
                                           )
                                    ),
                                    column(width = 5,
                                           selectizeInput("dissimilarityMethod", "Select dissimlarity Method",
                                                          choices = list("MDS", "PCA"),
                                                          options = list(onInitialize = I('function() { this.setValue(""); }'))
                                           )
                                    ),
                                    column(width = 5,
                                           uiOutput("GrpColMDS")
                                    )
                                ),
                                splitLayout(cellWidths = c("60%", "40%"), plotOutput("plotDissimilarityHM"), plotOutput("plotMDS")),
                                busyIndicator(wait = 500),
                                withMathJax(),
                                htmlOutput("distFuncsMD"),
                                value = "dissimilarityHM"
                       )
                )
            )
    )



DiffTab<- 
    tabItem(tabName = "showDiffTab",
            fluidRow(
                tabBox(width=12,
                       tabPanel("Perform differential analysis",
                                fluidRow(
                                    column(width = 5,
                                           selectizeInput(
                                               "diffLevel",
                                               "Select level",
                                               choices = list("V", "J", "VJ", "clone", "clonotype", "CDR3nt", "CDR3aa"),
                                               options = list(onInitialize = I('function() { this.setValue(""); }'))
                                           )
                                    ),
                                    column(width = 5,
                                           selectizeInput(
                                               "PCAMethod",
                                               "Select distance method",
                                               choices = list("manhattan", "euclidean", "canberra", "clark", "bray", 
                                                              "kulczynski", "jaccard", "gower", "altGower", "morisita", "horn", 
                                                              "mountford", "raup", "binomial", "chao", "cao", "mahalanobis"),
                                               options = list(onInitialize = I('function() { this.setValue(""); }'))
                                           )
                                    ),
                                    column(width = 5,
                                           selectizeInput(
                                               "PCAdimMethod",
                                               "Select dimension reduction method",
                                               choices = list("PCA", "MDS"),
                                               options = list(onInitialize = I('function() { this.setValue(""); }'))
                                           )
                                    ),
                                    column(width = 5,
                                           numericInput(inputId = "diffFC",
                                                        label = "Set fold-change threshold",
                                                        value = 1,
                                                        min = 0,
                                                        max = 10)
                                    ),
                                    column(width = 5,
                                           numericInput(inputId = "diffPV",
                                                        label = "Set pvalue threshold",
                                                        value = 0.05,
                                                        min = 0,
                                                        max = 1)
                                    ),
                                    column(width = 5,
                                           numericInput(inputId = "diffTop",
                                                        label = "Set top n features",
                                                        value = 5,
                                                        min = 0,
                                                        max = 15)
                                    ),
                                    column(width = 5,
                                           uiOutput("diffColGroup")
                                    ),
                                    column(width = 5,
                                           uiOutput("diffGroup")
                                    )
                                ),
                                splitLayout(cellWidths = c("60%", "40%"), plotOutput("Volcano"), plotOutput("plotPCA")),
                                busyIndicator(wait = 500),
                                dataTableOutput("tableDiffExpGroup"),
                                busyIndicator(wait = 500)
                       ))
            )
    )




PertTab<- 
    tabItem(tabName = "showPertTab",
            fluidRow(
                tabBox()
            )
    )