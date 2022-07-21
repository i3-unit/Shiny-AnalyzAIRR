compareSampleTab <- 
    tabItem(tabName = "multipleSampleTab",
        fluidRow(
            tabBox(width = 12,
                id = 'multiple.topTabs',
                tabPanel("Rarefaction",
                    fluidRow(
                        column(width = 3,
                            uiOutput("rareChoiceGroup")
                        ),
                        column(width = 3, 
                            radioButtons(inputId = "samplingchoice", 
                                    label = "Transformation method:", 
                                    choices = c("No" = "N", "Downsampling" = "Y"), #VMH removed "-" in downsampling
                                    )
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
                                            width = NULL
                                        )
                                    ),
                                    column(width = 3,
                                        actionButton("down", "Downsampling") #modified by VMH
                                    )
                                )
                            )
                        )
                    ),
                    #splitLayout(cellWidths = c("50%", "50%"), plotOutput("rarecurves"), plotly::plotlyOutput("libsizes")),
                    plotOutput("rarecurves"), 
                    busyIndicator(wait = 50),
                    plotly::plotlyOutput("libsizes"),
                    busyIndicator(wait = 50),
                    value = "rarefaction",
                    tags$hr(),
                    h4(textOutput("dataselected")),
                    plotOutput("histdownlibsizes")
                ),
                tabPanel("Renyi Profile",
                    fluidRow(
                        column(width = 3,
                            selectizeInput(
                                "renyiLevel",
                                "Select level",
                                choices = list("V", "J", "VJ", "clone", "clonotype", "CDR3nt", "CDR3aa"),
                                options = list(onInitialize = I('function() { this.setValue(""); }')))
                        ),
                        column(width = 3,
                            uiOutput("renyiGroup")
                        )
                    ),  
                    plotOutput("plotRenyi"),
                    busyIndicator(wait = 50),
                    htmlOutput("renyiMD"),
                    value = "Renyitab"
                ),
                tabPanel("Dissimilarity Analysis",
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
                ),
                tabPanel("Clonotype distribution",  #modified by VMH
                    fluidRow(
                        column(width = 3, 
                            uiOutput("distribVpJGroup")
                        ),
                        column(width = 3, 
                            selectInput("distribVpJGroupMeth", 
                                "Select method",
                                choices = list("count" = "count", "frequency" = "frequency"), #modified by VMH
                                selected = "count"   #modified by VMH
                            )
                        ),
                        column(width = 3, 
                               selectInput("distribVpJLevel", 
                                           "Select level",
                                           choices = list("V", "J", "VJ", "clone", "clonotype", "CDR3nt", "CDR3aa"), #modified by VMH
                                           selected = "V"   #modified by VMH
                               )
                        )
                    ),
                    plotOutput("plotDistribVpJ"),
                    busyIndicator(wait = 500)
                ),
                tabPanel("Venn Diagram",
                    fluidRow(
                        column(width = 2,
                            selectizeInput("vennLevel",
                                "Select level",
                                choices = list("V", "J", "VJ", "clone", "clonotype", "CDR3nt", "CDR3aa"),
                                options = list(onInitialize = I('function() { this.setValue(""); }'))
                            )
                        ),
                        #column(width = 2,
                        #    selectizeInput("venntype",
                        #        "Select type",
                        #        choices = list("Samples", "Groups of samples"),
                        #        options = list(onInitialize = I('function() { this.setValue(""); }'))
                        #    )
                        #),
                        #conditionalPanel("input.venntype == 'Samples'",
                            column(width = 3,
                                uiOutput("vennUISample")
                            )
                        #),    
                        #conditionalPanel("input.venntype == 'Groups of samples'",
                        #    fluidRow(
                        #        column(width = 3,
                        #            uiOutput("vennUIGroup")
                        #        ),
                        #        column(width = 3, 
                        #            uiOutput("vennSubGroup")
                        #        )
                        #    )    
                        #)
                    ),
                    plotOutput("plotEulerr", height = 800, width = 800),
                    busyIndicator(wait = 500)
                ),
                tabPanel("Multivariate scores",
                    fluidRow(
                        column(width = 3,
                            selectizeInput("muLevel",
                                "Select level",
                                choices = list("V", "J", "VJ"),
                                options = list(onInitialize = I('function() { this.setValue(""); }'))
                            )
                        ),
                        column(width = 3,
                            selectizeInput("muType",
                                "Select data type",
                                choices = c("count", "usage"),
                                options = list(onInitialize = I('function() { this.setValue(""); }'))
                            )
                        )
                    ),
                    plotOutput("plotmuScore", height = "auto", width = "100%"),
                    busyIndicator(wait = 500)                            
                ),
                tabPanel("Sample correlation",
                    fluidRow(
                        column(width = 3,
                            selectizeInput("count2v2Level",
                                "Select level",
                                choices = list("V", "J", "VJ", "clone", "clonotype", "CDR3nt", "CDR3aa"),
                                options = list(onInitialize = I('function() { this.setValue(""); }'))
                            )
                        ),
                        column(width = 3,
                            uiOutput("count2v2Libs")
                        ),
                        column(width = 3,
                            radioButtons("count2v2scale", 
                                "Choose a scale",
                                choices = c("frequency", "log"),  #modified by VMH
                                selected = "frequency", #modified by VMH
                                inline = T
                            )
                        )
                    ),
                    plotOutput("plot2v2count", brush = brushOpts(id = "plot2v2count_brush")),
                    tags$hr(),
                    uiOutput("downloadSelected"),
                    dataTableOutput("brush2v2countDT")
                )
            )
        )
    )
