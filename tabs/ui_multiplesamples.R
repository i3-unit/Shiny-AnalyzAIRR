CompBasicTab<- 
    tabItem(tabName = "showCompBasicTab",
        fluidRow(
            tabBox(width = 12,
                tabPanel("Metadata statistics",
                         fluidRow(div(style="display:block;margin-left: 97%;padding-bottom: 0px;",
                                      circleButton(inputId = "statsHelp", icon = icon("question", verify_fa = FALSE), #size="sm", 
                                                   style="background-color: #337ab7; border-color: #337ab7; margin-top: -10px;
                                                                      border-radius: 25px;  font-size: 15px; height: 25px; color:white;
                                                                      line-height: 50%; padding: 2px 0; text-align: center; width: 25px;")),
                                  tags$head(tags$style(".modal-dialog{ width:1200px}")),
                        column(width = 2, style="margin-top: -22px;",
                               uiOutput("statisticsStat")
                        ),
                        column(width = 2, style="margin-top: -22px;",
                               uiOutput("statisticsGroup")
                        ),
                        # column(width = 1,
                        #        style = "margin-top: 25px;",
                        #        tags$head(
                        #          tags$style(HTML('#doStats{background-color:white; border-color: #022F5A;}'))
                        #        ),
                        #        actionButton("doStats", "run")
                        # ),
                        column(width = 4, style="margin-top: -22px;",
                               uiOutput("statisticsFacet")
                        ),
                        column(width = 3, style="margin-top: -22px;",
                               selectizeInput("statisticsshowstats",
                                              HTML("Perform a statistical test <i>(optional)</i>"),
                                              choices = list("yes"=TRUE, "no"=FALSE),
                                              options = list(onInitialize = I('function() { this.setValue(""); }')))
                        )
                      
                        # column(width = 2,
                        #        div(style="position: absolute; top: 0; right: 0;",
                        #            circleButton(inputId = "statsHelp", icon = icon("question", verify_fa = FALSE), size="sm", style="background-color:white; border-color: #022F5A;")),
                        #        tags$head(tags$style(".modal-dialog{ width:1200px}"))
                        # )
                    ),
                    uiOutput("downPlotStatistics"),
                    plotOutput("Statistics"),
                    busyIndicator(wait = 500)
                ),
                navbarMenu("Repertoire diversity",
                    tabPanel("Diversity indices",
                             fluidRow(div(style="display:block;margin-left: 97%;padding-bottom: 0px;",
                                          circleButton(inputId = "DivHelp", icon = icon("question", verify_fa = FALSE), #size="sm", 
                                                       style="background-color: #337ab7; border-color: #337ab7; margin-top: -10px;
                                                                      border-radius: 25px;  font-size: 15px; height: 25px; color:white;
                                                                      line-height: 50%; padding: 2px 0; text-align: center; width: 25px;")),
                                      tags$head(tags$style(".modal-dialog{ width:1200px}")),
                                 column(width = 2, style="margin-top: -22px;",
                                        selectizeInput("diverLevel",
                                                       "Select a level",
                                                       choices = list("V", "J", "VJ", "ntCDR3", "aaCDR3", "aaClone", "ntClone"),
                                                       options = list(onInitialize = I('function() { this.setValue(""); }')))
                                 ), 
                                 column(width = 2, style="margin-top: -22px;",
                                        selectizeInput("diverIndex",
                                                       "Select an index",
                                                       choices = list("chao1", "shannon", "simpson", "invsimpson", "bergerparker","gini", "iChao"),
                                                       options = list(onInitialize = I('function() { this.setValue(""); }')))
                                 ),
                                 column(width = 2, style="margin-top: -22px;",
                                        uiOutput("diverGroup")
                                 ),
                                 # column(width = 1, 
                                 #        style = "margin-top: 25px;",
                                 #        tags$head(
                                 #          tags$style(HTML('#doDiversity{background-color:white; border-color: #022F5A;}'))
                                 #        ),
                                 #        actionButton("doDiversity", "run")
                                 # ),
                                 
                                  column(width = 3, style="margin-top: -22px;",
                                          uiOutput("diverfacet")
                                 ),
                                 column(width = 3, style="margin-top: -22px;",
                                        selectizeInput("divshowstats",
                                                       HTML("Perform a statistical test <i>(optional)</i>"),
                                                       choices = list("yes"=TRUE, "no"=FALSE),
                                                       options = list(onInitialize = I('function() { this.setValue(""); }')))
                                 )
                                 #column(width = 1,
                                 # tags$head(tags$style(".modal-dialog{ width:1200px}")),
                                 #        div(style="position: absolute; top: 0; right: 0px;",
                                 #            circleButton(inputId = "DivHelp", icon = icon("question", verify_fa = FALSE), size="sm", style="background-color:white; border-color: #022F5A;")),
                                 #       # tags$head(tags$style(".modal-dialog{ width:1200px}"))
                                 # column(width = 1
                             #)
                             ),
                             uiOutput("downPlotDiversity"),
                             plotOutput("Diversity"),
                             busyIndicator(wait = 500)),
                      tabPanel("Renyi diversity",
                               fluidRow(div(style="display:block;margin-left: 97%;padding-bottom: 0px;",
                                            circleButton(inputId = "RenHelp", icon = icon("question", verify_fa = FALSE), #size="sm", 
                                                         style="background-color: #337ab7; border-color: #337ab7; margin-top: -10px;
                                                                      border-radius: 25px;  font-size: 15px; height: 25px; color:white;
                                                                      line-height: 50%; padding: 2px 0; text-align: center; width: 25px;")),
                                        tags$head(tags$style(".modal-dialog{ width:1200px}")),
                                   column(width = 2, style="margin-top: -22px;",
                                          selectizeInput("multrenLevel",
                                                         "Select a level",
                                                         choices = list("V", "J", "VJ", "ntCDR3", "aaCDR3", "aaClone", "ntClone"),
                                                         options = list(onInitialize = I('function() { this.setValue(""); }')))
                                   ),
                                   column(width = 2, style="margin-top: -22px;",
                                          uiOutput("multrenGroup")
                                   ), 
                                   column(width = 3, style="margin-top: -22px;",
                                          uiOutput("multrenshape")
                                   ),
                                   column(width = 4, style="margin-top: -22px;",
                                          uiOutput("multrenfacet")
                                   ),
                                   # column(width = 2, 
                                   #        style = "margin-top: 25px;",
                                   #        tags$head(
                                   #          tags$style(HTML('#doRenyi{background-color:white; border-color: #022F5A;}'))
                                   #        ),
                                   #        actionButton("doRenyi", "run")
                                   # ),
                                   # column(width = 2,
                                   #        div(style="position: absolute; top: 0; right: 0;",
                                   #            circleButton(inputId = "RenHelp", icon = icon("question", verify_fa = FALSE), size="sm", style="background-color:white; border-color: #022F5A;")),
                                   #        tags$head(tags$style(".modal-dialog{ width:1200px}"))
                                   # )
                               ),
                             uiOutput("downPlotRenyi"),
                             plotOutput("RenyiDiversity"),#, height = "600px"),
                             busyIndicator(wait = 500)
                    )
                ),
                navbarMenu("Clonal distribution",
                    tabPanel("Count intervals",
                             fluidRow(div(style="display:block;margin-left: 97%;padding-bottom: 0px;",
                                          circleButton(inputId = "CIHelp", icon = icon("question", verify_fa = FALSE), #size="sm", 
                                                       style="background-color: #337ab7; border-color: #337ab7; margin-top: -10px;
                                                                      border-radius: 25px;  font-size: 15px; height: 25px; color:white;
                                                                      line-height: 50%; padding: 2px 0; text-align: center; width: 25px;")),
                                      tags$head(tags$style(".modal-dialog{ width:1200px}")),
                                 column(width = 2, style="margin-top: -22px;",
                                        selectizeInput("countIntervalsLevel",
                                                       "Select a level",
                                                       choices = list("ntCDR3", "aaCDR3", "aaClone", "ntClone"),
                                                       options = list(onInitialize = I('function() { this.setValue(""); }')))
                                 ), 
                                 column(width = 2, style="margin-top: -22px;",
                                        selectizeInput("countIntervalsscale",
                                                       "Select a scale for fractions",
                                                       choices = list("count", "frequency"),
                                                       options = list(onInitialize = I('function() { this.setValue(""); }')))
                                 ),
                                 column(width = 2, style="margin-top: -22px;",
                                        uiOutput("countIntervalsGroup")
                                 ),
                                 # column(width = 1, 
                                 #        style = "margin-top: 25px;",
                                 #        tags$head(
                                 #          tags$style(HTML('#doCountInt{background-color:white; border-color: #022F5A;}'))
                                 #        ),
                                 #        actionButton("doCountInt", "run")
                                 # ),
                                 column(width = 3, style="margin-top: -22px;",
                                        uiOutput("countIntervalsFacet")
                                 ),
                                 column(width = 3, style="margin-top: -22px;",
                                        selectizeInput("countIntervalsshowstats",
                                                       HTML("Perform a statistical test <i>(optional)</i>"),
                                                       choices = list("yes"=TRUE, "no"=FALSE),
                                                       options = list(onInitialize = I('function() { this.setValue(""); }')))
                                 )
                               
                                 # column(width = 2,
                                 #        div(style="position: absolute; top: 0; right: 0;",
                                 #            circleButton(inputId = "CIHelp", icon = icon("question", verify_fa = FALSE), size="sm", style="background-color:white; border-color: #022F5A;")),
                                 #        tags$head(tags$style(".modal-dialog{ width:1200px}"))
                                 # )
                             ),
                             uiOutput("downPlotCountInt"),
                             plotOutput("CountInt" ),
                             busyIndicator(wait = 500)
                    ),
                    tabPanel("Rank distribution",
                             fluidRow(div(style="display:block;margin-left: 97%;padding-bottom: 0px;",
                                          circleButton(inputId = "mrankHelp", icon = icon("question", verify_fa = FALSE), #size="sm", 
                                                       style="background-color: #337ab7; border-color: #337ab7; margin-top: -10px;
                                                                      border-radius: 25px;  font-size: 15px; height: 25px; color:white;
                                                                      line-height: 50%; padding: 2px 0; text-align: center; width: 25px;")),
                                      tags$head(tags$style(".modal-dialog{ width:1200px}")),
                                 column(width = 2, style="margin-top: -22px;",
                                        selectizeInput("multRankLevel",
                                                       "Select a level",
                                                       choices = list("ntCDR3", "aaCDR3", "aaClone", "ntClone"),
                                                       options = list(onInitialize = I('function() { this.setValue(""); }')))
                                 ), 
                                 column(width = 2, style="margin-top: -22px;",
                                        selectizeInput("multRankScale",
                                                       "Select a scale",
                                                       choices = list("count", "frequency"),
                                                       options = list(onInitialize = I('function() { this.setValue(""); }')))
                                 ), 
                                 column(width = 2, style="margin-top: -22px;",
                                        uiOutput("multRankGroup")
                                 ),
                                 column(width = 3, style="margin-top: -22px;",
                                        sliderInput(inputId = "multRankSize",
                                                    label = HTML("Select number of ranks <i>(optional)</i>"),
                                                                 value = 1000,
                                                                 min = 1,
                                                                 max = 1000000)
                                  ),
                                 column(width = 4, style="margin-top: -22px;",
                                        uiOutput("multRankFacet")
                                 )
                                 # column(width = 2,
                                 #        div(style="position: absolute; top: 0; right: 0;",
                                 #            circleButton(inputId = "mrankHelp", icon = icon("question", verify_fa = FALSE), size="sm", style="background-color:white; border-color: #022F5A;")),
                                 #        tags$head(tags$style(".modal-dialog{ width:1200px}"))
                                 # )
                             ),
                             uiOutput("downPlotMultRank"),
                             plotOutput("multRank"),
                             busyIndicator(wait = 500)
                    )
                ),
                tabPanel("V/J usage",
                         fluidRow(div(style="display:block;margin-left: 97%;padding-bottom: 0px;",
                                      circleButton(inputId = "geneusageHelp", icon = icon("question", verify_fa = FALSE), #size="sm", 
                                                   style="background-color: #337ab7; border-color: #337ab7; margin-top: -10px;
                                                                      border-radius: 25px;  font-size: 15px; height: 25px; color:white;
                                                                      line-height: 50%; padding: 2px 0; text-align: center; width: 25px;")),
                                  tags$head(tags$style(".modal-dialog{ width:1200px}")),
                           column(width = 2, style="margin-top: -22px;",
                                         selectizeInput("geneUsageLevel",
                                                        "Select a level",
                                                        choices = list("V", "J"),
                                                        options = list(onInitialize = I('function() { this.setValue(""); }')))
                         ),
                         column(width = 2, style="margin-top: -22px;",
                                  selectizeInput("geneUsageScale",
                                                 "Select a scale",
                                                 choices = list("count", "frequency"),
                                                 options = list(onInitialize = I('function() { this.setValue(""); }')))
                         ), 
                         column(width = 2, style="margin-top: -22px;",
                                uiOutput("geneUsageGroup")
                         ),
                         column(width = 2, style="margin-top: -22px;",
                                uiOutput("geneUsagefacet")
                         ),
                         column(width = 2, style="margin-top: -22px;",
                                selectizeInput("geneUsageshowstats",
                                               HTML("Perform a statistical test <i>(optional)</i>"),
                                               choices = list("yes"=TRUE, "no"=FALSE),
                                               options = list(onInitialize = I('function() { this.setValue(""); }')))
                         )
                         # column(width = 2, style="margin-top: -22px;",
                         #        style = "margin-top: 25px;",
                         #        tags$head(
                         #            tags$style(HTML('#dogeneUsage{background-color:white; border-color: #022F5A; border-radius: 50px;}'))
                         #        ),
                         #        actionButton("dogeneUsage", "Run")
                         # )
                         # column(width = 4,
                         #        div(style="position: absolute; top: 0; right: 0;",
                         #            circleButton(inputId = "geneusageHelp", icon = icon("question", verify_fa = FALSE), size="sm", style="background-color:white; border-color: #022F5A;")),
                         #        tags$head(tags$style(".modal-dialog{ width:1200px}"))
                         # )
                         ),
                         uiOutput("downPlotgeneUsage"),
                         plotly::plotlyOutput("geneUsage"),
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
                                fluidRow(div(style="display:block;margin-left: 97%;padding-bottom: 0px;",
                                             circleButton(inputId = "eulerHelp", icon = icon("question", verify_fa = FALSE), #size="sm", 
                                                          style="background-color: #337ab7; border-color: #337ab7; margin-top: -10px;
                                                                      border-radius: 25px;  font-size: 15px; height: 25px; color:white;
                                                                      line-height: 50%; padding: 2px 0; text-align: center; width: 25px;")),
                                         tags$head(tags$style(".modal-dialog{ width:1200px}")),
                               column(width = 2,  style="margin-top: -22px;",
                                   selectizeInput("vennLevel",
                                       "Select a level",
                                       choices = list("V", "J", "VJ", "ntCDR3", "aaCDR3", "aaClone", "ntClone"),
                                       options = list(onInitialize = I('function() { this.setValue(""); }'))
                                   )
                               ),
                               column(width = 3,  style="margin-top: -22px;",
                                       uiOutput("vennUISample")
                               ),
                               column(width = 2,   
                                      style = "margin-top: 2px;",
                                      tags$head(
                                          tags$style(HTML('#doVenn{background-color:white; border-color: #022F5A;  border-radius: 50px;}'))
                                      ),
                                      actionButton("doVenn", "Run")
                               )
                               # column(width = 4,  style="margin-top: -22px;",
                               #        div(style="position: absolute; top: 0; right: 0;",
                               #            circleButton(inputId = "", icon = icon("question", verify_fa = FALSE), size="sm", style="background-color:white; border-color: #022F5A;")),
                               #        tags$head(tags$style(".modal-dialog{ width:1200px}"))
                               # )

                           ),
                           uiOutput("downPlotEulerr"),
                           plotOutput("plotEulerr", height = 800, width = 800),
                           busyIndicator(wait = 500)
                       ),
                       tabPanel("Repertoire correlation",
                                fluidRow(div(style="display:block;margin-left: 97%;padding-bottom: 0px;",
                                             circleButton(inputId = "scatterHelp", icon = icon("question", verify_fa = FALSE), #size="sm", 
                                                          style="background-color: #337ab7; border-color: #337ab7; margin-top: -10px;
                                                                      border-radius: 25px;  font-size: 15px; height: 25px; color:white;
                                                                      line-height: 50%; padding: 2px 0; text-align: center; width: 25px;")),
                                         tags$head(tags$style(".modal-dialog{ width:1200px}")),
                                    column(width = 2, style="margin-top: -22px;",
                                           selectizeInput("scatterLevel",
                                                          "Select a level",
                                                          choices = list("V", "J", "VJ", "ntCDR3", "aaCDR3", "aaClone", "ntClone"),
                                                          options = list(onInitialize = I('function() { this.setValue(""); }'))
                                           )
                                    ),
                                    column(width = 2, style="margin-top: -22px;",
                                           selectizeInput("scatterScale",
                                                          "Select a scale",
                                                          choices = list("frequency", "log"),
                                                          options = list(onInitialize = I('function() { this.setValue(""); }'))
                                           )
                                    ),
                                    column(width = 3, style="margin-top: -22px;",
                                           uiOutput("scatterUISample")
                                    )
                                    # column(width = 4, style="margin-top: -22px;",
                                    #        div(style="position: absolute; top: 0; right: 0;",
                                    #            circleButton(inputId = "scatterHelp", icon = icon("question", verify_fa = FALSE), size="sm", style="background-color:white; border-color: #022F5A;")),
                                    #        tags$head(tags$style(".modal-dialog{ width:1200px}"))
                                    # )
                                    
                                ),
                                uiOutput("downPlotScatter"),
                                plotly::plotlyOutput("Scatter"),
                                busyIndicator(wait = 500)
                       ),
                       navbarMenu("Dissimilarity indices",
                            tabPanel("Hierarchical clustering",
                                     fluidRow(div(style="display:block;margin-left: 97%;padding-bottom: 0px;",
                                                  circleButton(inputId = "disHMHelp", icon = icon("question", verify_fa = FALSE), #size="sm", 
                                                               style="background-color: #337ab7; border-color: #337ab7; margin-top: -10px;
                                                                      border-radius: 25px;  font-size: 15px; height: 25px; color:white;
                                                                      line-height: 50%; padding: 2px 0; text-align: center; width: 25px;")),
                                              tags$head(tags$style(".modal-dialog{ width:1200px}")),
                                    column(width = 2, style="margin-top: -22px;",
                                           selectizeInput(
                                               "dissimilarityLevel",
                                               "Select a level",
                                               choices = list("V", "J", "VJ", "ntCDR3", "aaCDR3", "aaClone", "ntClone"),
                                               options = list(onInitialize = I('function() { this.setValue(""); }'))
                                           )
                                    ),
                                    column(width = 3, style="margin-top: -22px;",
                                           selectizeInput("dissimilarityIndex", "Select a dissimlarity method",
                                                          choices = list("manhattan", "euclidean", "canberra", "clark", "bray", 
                                                                         "kulczynski", "jaccard", "gower", "altGower", "morisita", "horn", 
                                                                         "mountford", "raup", "binomial", "chao", "cao", "mahalanobis"),
                                                          options = list(onInitialize = I('function() { this.setValue(""); }'))
                                           )
                                    ),
                                    column(width = 2, style="margin-top: -22px;",
                                           selectizeInput("dissimilarityClustering", "Select a clustering method",
                                                          choices = list("ward.D", "ward.D2", "single", "complete", "average", "mcquitty",
                                                                           "median", "centroid"),
                                                          options = list(onInitialize = I('function() { this.setValue(""); }'))
                                           )
                                    ),
                                    column(width = 3, style="margin-top: -22px;",
                                           uiOutput("multdissGroup")
                                    ),
                                    column(width = 2, 
                                           style = "margin-top: 2px;",
                                           tags$head(
                                               tags$style(HTML('#doHm1{background-color:white; border-color: #022F5A; border-radius: 50px;}'))
                                           ),
                                           actionButton("doHm1", "Run")
                                    )
                                    # column(width = 2,
                                    #        div(style="position: absolute; top: 0; right: 0;",
                                    #            circleButton(inputId = "disHMHelp", icon = icon("question", verify_fa = FALSE), size="sm", style="background-color:white; border-color: #022F5A;")),
                                    #        tags$head(tags$style(".modal-dialog{ width:1200px}"))
                                    # )
                                ),
                                uiOutput("downPlotDisHM"),
                                InteractiveComplexHeatmapOutput("ht1", 
                                                                width1 = 700, 
                                                                width2 = 600, 
                                                                width3 = 0, 
                                                                title3 = " ", 
                                                                output_ui = NULL, 
                                                                height1 = 600, 
                                                                height2 = 400),  
                                busyIndicator(wait = 500),
                                htmlOutput("NB_diss")
                            ),
                            tabPanel("Multidimensional scaling",
                                     fluidRow(div(style="display:block;margin-left: 97%;padding-bottom: 0px;",
                                                  circleButton(inputId = "disMDSHelp", icon = icon("question", verify_fa = FALSE), #size="sm", 
                                                               style="background-color: #337ab7; border-color: #337ab7; margin-top: -10px;
                                                                      border-radius: 25px;  font-size: 15px; height: 25px; color:white;
                                                                      line-height: 50%; padding: 2px 0; text-align: center; width: 25px;")),
                                              tags$head(tags$style(".modal-dialog{ width:1200px}")),
                                       column(width = 2, style="margin-top: -22px;",
                                              selectizeInput(
                                                "MDSLevel",
                                                "Select a level",
                                                choices = list("V", "J", "VJ", "ntCDR3", "aaCDR3", "aaClone", "ntClone"),
                                                options = list(onInitialize = I('function() { this.setValue(""); }'))
                                              )
                                       ),
                                       column(width = 3, style="margin-top: -22px;",
                                              selectizeInput("MDSMethod", "Select a dissimlarity method",
                                                             choices = list("manhattan", "euclidean", "canberra", "clark", "bray", 
                                                                            "kulczynski", "jaccard", "gower", "altGower", "morisita", "horn", 
                                                                            "mountford", "raup", "binomial", "chao", "cao", "mahalanobis"),
                                                             options = list(onInitialize = I('function() { this.setValue(""); }'))
                                              )
                                       ),
                                       column(width = 3, style="margin-top: -22px;",
                                              uiOutput("multMDSGroup")
                                       ),
                                       column(width = 2, 
                                              style = "margin-top: 2px;",
                                              tags$head(
                                                tags$style(HTML('#doMds{background-color:white; border-color: #022F5A; border-radius: 50px;}'))
                                              ),
                                              actionButton("doMds", "Run")
                                       )
                                       # column(width = 4,
                                       #        div(style="position: absolute; top: 0; right: 0;",
                                       #            circleButton(inputId = "disMDSHelp", icon = icon("question", verify_fa = FALSE), size="sm", style="background-color:white; border-color: #022F5A;")),
                                       #        tags$head(tags$style(".modal-dialog{ width:1200px}"))
                                       # )
                                     ),
                                     uiOutput("downPlotMDS"),
                                     plotly::plotlyOutput("MDS", height = "600px"),
                                     busyIndicator(wait = 500)
                            )
                       )
                )
            )
    )



DiffTab<- 
    tabItem(tabName = "showDiffTab",
            # fluidRow(
            #     tabBox(width=12,
            #            navbarMenu("Analysis",
            #                tabPanel("Volcano plot",
            fluidRow(div(style="display:block;margin-left: 97%;padding-bottom: 0px;",
                         circleButton(inputId = "difftabHelp", icon = icon("question", verify_fa = FALSE), #size="sm", 
                                      style="background-color: #337ab7; border-color: #337ab7; margin-top: -10px;
                                                                      border-radius: 25px;  font-size: 15px; height: 25px; color:white;
                                                                      line-height: 50%; padding: 2px 0; text-align: center; width: 25px;")),
                     tags$head(tags$style(".modal-dialog{ width:1200px}")),
                                        column(width = 2, style="margin-top: -22px;",
                                               selectizeInput(
                                                   "diffLevel",
                                                   "Select a level",
                                                   choices = list("V", "J", "VJ", "ntCDR3", "aaCDR3", "aaClone", "ntClone"),
                                                   options = list(onInitialize = I('function() { this.setValue(""); }'))
                                               )
                                        ),
                                        column(width = 3, style="margin-top: -22px;",
                                               uiOutput("diffGroup")
                                        ),
                                        column(width = 3, style="margin-top: -22px;",
                                               sliderInput(inputId = "diffFC",
                                                           label = "Set a fold-change threshold",
                                                           value = 1,
                                                           min = 0,
                                                           max = 10)
                                        ),
                                        column(width = 2, style="margin-top: -22px;",
                                               sliderInput(inputId = "diffPV",
                                                           label = "Set a pvalue threshold",
                                                           value = 0.05,
                                                           min = 0,
                                                           max = 1)
                                        )
                                        ),
                                    uiOutput("downPlotVolcano"),
                                    plotly::plotlyOutput("Volcano", height = "600px"),
                                    busyIndicator(wait = 500),
                                    hr(),
                                    h4('Table of values'),
            # div(style="position: absolute; top: 0; right: 0;",
            #     circleButton(inputId = "difftabHelp", icon = icon("question", verify_fa = FALSE), size="sm", style="background-color:white; border-color: #022F5A;")),
            #                         tags$head(tags$style(".modal-dialog{ width:1200px}")),
                                    downloadButton("downloadtableDiffExpGroup", "Export table", style="background-color:white; border-color: #022F5A;"),
                                    dataTableOutput("tableDiffExpGroup"),
                                    busyIndicator(wait = 500)
                           )#,
                           # tabPanel("Principal Component Analysis",
                           #              fluidRow(
                           #                  column(width = 2,
                           #                         selectizeInput(
                           #                             "diffPCALevel",
                           #                             "Select a level",
                           #                             choices = list("V", "J", "VJ", "ntCDR3", "aaCDR3", "clone", "ntClone"),
                           #                             options = list(onInitialize = I('function() { this.setValue(""); }'))
                           #                         )
                           #                  ),
                           #                  column(width = 2,
                           #                         uiOutput("diffPCAGroup")
                           #                  ),
                           #                  column(width = 8,
                           #                         div(style="display:block;margin-left: 95%;padding-bottom: 10px;",
                           #                             circleButton(inputId = "pcaHelp", icon = icon("question", verify_fa = FALSE), size="sm", style="background-color:white; border-color: #022F5A;")),
                           #                         tags$head(tags$style(".modal-dialog{ width:1200px}"))
                           #                  )
                           #              ),
                           #              uiOutput("downPlotPCA"),
                           #              plotly::plotlyOutput("plotPCA", height = "700px"),
                           #              busyIndicator(wait = 500)
                           #              
                           # )
    #             )
    #            )
    #         )
    # )




PertTab<- 
    tabItem(tabName = "showPertTab",
            fluidRow(div(style="display:block;margin-left: 97%;padding-bottom: 0px;",
                         circleButton(inputId = "perttabHelp", icon = icon("question", verify_fa = FALSE), #size="sm", 
                                      style="background-color: #337ab7; border-color: #337ab7; margin-top: -10px;
                                                                      border-radius: 25px;  font-size: 15px; height: 25px; color:white;
                                                                      line-height: 50%; padding: 2px 0; text-align: center; width: 25px;")),
                     tags$head(tags$style(".modal-dialog{ width:1200px}")),
                                    column(width = 2, style="margin-top: -22px;",
                                           uiOutput("PertGroupUI")
                                    ),
                                    column(width = 2, style="margin-top: -22px;",
                                           uiOutput("CtrlGroupUI")
                                    ),
                                    column(width = 2, style="margin-top: -22px;",
                                           uiOutput("PertDistUI")
                                    ),
                                    column(width = 2, style="margin-top: -22px;",
                                           uiOutput("pertOrder")
                                    ),
                                    column(width = 2,  style="margin-top: -22px;",
                                           style = "margin-top: 2px;",
                                           tags$head(
                                               tags$style(HTML('#doHm{background-color:white; border-color: #022F5A; border-radius: 50px;}'))
                                           ),
                                           actionButton("doHm", "Run")
                                    )
                                    ),
                                uiOutput("downPlotPert"),
                                InteractiveComplexHeatmapOutput("ht", width1 = 800, width2 = 600, width3 = 0, title3 = " ", output_ui = NULL, height1=600, height2 = 400),
                                busyIndicator(wait = 500),
                                htmlOutput("NB_pert"),
                                h4("Perturbation values"),
            # div(style="position: absolute; top: 0; right: 0;",
            #     circleButton(inputId = "perttabHelp", icon = icon("question", verify_fa = FALSE), size="sm", style="background-color:white; border-color: #022F5A;")),
            #                     tags$head(tags$style(".modal-dialog{ width:1200px}")),
                                downloadButton("downloadPertTab", "Export table", style="background-color:white; border-color: #022F5A;"),
                                dataTableOutput("PertTab"),
                                busyIndicator(wait = 500)
    )