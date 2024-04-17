#-------------------------------------------------------------------------------------------------------------------------------------------#
#  multiple comparison section
#-------------------------------------------------------------------------------------------------------------------------------------------#    

output$statisticsStat <- renderUI({
  selectGroupStat("statisticsStat", dataFilt())
})

output$statisticsGroup <- renderUI({
  selectColorGroupmulti("statisticsGroup", dataFilt())
})

output$statisticsFacet <- renderUI({
  selectFacetGroup("statisticsFacet", dataFilt())
})



# plot statistics
#observeEvent(input$doStats, {
  output$Statistics <- renderPlot({
      validate(need(!(is.null(input$statisticsStat) || input$statisticsStat == ""), "Statistic"))
      validate(need(!(is.null(input$statisticsGroup) || input$statisticsGroup == ""), "Colors"))
      plotStatistics(x = dataFilt(), stat = input$statisticsStat, grouped=TRUE, colorBy = input$statisticsGroup, facetBy=input$statisticsFacet, show_stats=input$statisticsshowstats, label_colors = NULL)    
  })  
#})

output$StatisticsHelp <- renderText({
  createHelp(?plotStatistics)
})

observeEvent(input$statsHelp,
             showModal(modalDialog(
               title = paste("Help"),
               htmlOutput("StatisticsHelp"),
               size = "l",
               easyClose = T
             ))
)

output$downPlotStatistics <- renderUI({
  if (!is.null(input$statisticsStat) & !(is.null(input$statisticsGroup)) ) {
    downloadButton("PlotStatistics", "Download PDF", style="background-color:white; border-color: #022F5A;")
  }
}) 

output$PlotStatistics <- downloadHandler(
  filename =  function() {
    paste0("metadataStatistics_", input$statisticsStat, "_", input$statisticsGroup, ".pdf")
  },
  # content is a function with argument file. content writes the plot to the device
  content = function(file) {
    pdf(file, height=4, width=6)
    grid.draw(plotStatistics(x = dataFilt(), stat = input$statisticsStat, grouped=TRUE, colorBy = input$statisticsGroup, facetBy=input$statisticsFacet, show_stats=input$statisticsshowstats, label_colors = NULL)    
)
    dev.off()
  }
)

output$diverGroup <- renderUI({
  selectColorGroupmulti("diverGroup", dataFilt())
})


output$diverfacet <- renderUI({
  selectFacetGroup("diverfacet", dataFilt())
})

# plot diversity
#observeEvent(input$doDiversity, {
  output$Diversity <- renderPlot({
    validate(need(!(is.null(input$diverLevel) || input$diverLevel == ""), "Select a level"))
    validate(need(!(is.null(input$diverIndex) || input$diverIndex == ""), "Select an index"))
    validate(need(!(is.null(input$diverGroup) || input$diverGroup == ""), "Select a group for colours"))
    plotDiversity(x = dataFilt(), index = input$diverIndex, level = input$diverLevel, grouped=T, colorBy = input$diverGroup, facetBy=input$diverfacet, show_stats=input$divshowstats, label_colors = NULL)    
  })  
#})
output$downPlotDiversity <- renderUI({
  if (!is.null(input$diverLevel) & !(is.null(input$diverGroup))& !(is.null(input$diverIndex))# & input$doDiversity == 1
      ) {
    downloadButton("PlotDiversity", "Download PDF", style="background-color:white; border-color: #022F5A;")
  }
}) 

output$PlotDiversity <- downloadHandler(
  filename =  function() {
    paste0("diversity_", input$diverLevel, "_", input$diverGroup, "_", input$diverIndex, ".pdf")
  },
  # content is a function with argument file. content writes the plot to the device
  content = function(file) {
    pdf(file, height=4, width=6)
    grid.draw(plotDiversity(x = dataFilt(), level = input$diverLevel, grouped=T, colorBy = input$diverGroup, index = input$diverIndex, facetBy=input$diverfacet, show_stats=input$divshowstats,label_colors = NULL)    
)
    dev.off()
  }
)

output$DiversityHelp <- renderText({
  createHelp(?plotDiversity)
})

observeEvent(input$DivHelp,
             showModal(modalDialog(
               title = paste("Help"),
               htmlOutput("DiversityHelp"),
               size = "l",
               easyClose = T
             ))
)
# output$multrenGroup <- renderUI({
#   selectMultGroupDE("multrenGroup", dataFilt())
# })

#plot renyi index
# output$RenyiDiversity <- renderPlot({
#   validate(need(!(is.null(input$multrenLevel) || input$multrenLevel == ""), "Select a level"))
#   validate(need(!(is.null(input$multrenGroup) || input$multrenGroup == ""), "Select a group"))
#   plotRenyiIndex(x = dataFilt(), level = input$multrenLevel, colorBy = input$multrenGroup, grouped = TRUE, label_colors = NULL)    
# })  

output$multrenGroup <- renderUI({
  selectColorGroupmulti("multrenGroup", dataFilt())
})


output$multrenfacet <- renderUI({
  selectFacetGroup("multrenfacet", dataFilt())
})


output$multrenshape <- renderUI({
  selectShapeGroup("multrenshape", dataFilt())
})


#observeEvent(input$doRenyi, {
  output$RenyiDiversity <- renderPlot({
    validate(need(!(is.null(input$multrenLevel) || input$multrenLevel == ""), "Select a level"))
    validate(need(!(is.null(input$multrenGroup) || input$multrenGroup == ""), "Select a group for colours"))
    print(input$multrenshape)
    print(input$multrenfacet)
    if(input$multrenshape == ''){
      shape <- NULL
    } else {
      shape <- input$multrenshape
    }
    plotRenyiIndex(x = dataFilt(), level = input$multrenLevel, colorBy = input$multrenGroup, 
                   grouped = TRUE, shapeBy=shape, 
                   facetBy=input$multrenfacet,
                   label_colors = NULL)    
    })  
#})


output$downPlotRenyi <- renderUI({
  if (!is.null(input$multrenLevel) & !(is.null(input$multrenGroup)) #& input$doRenyi == 1
      ) {
    downloadButton("PlotRenyi", "Download PDF", style="background-color:white; border-color: #022F5A;")
  }
}) 

output$PlotRenyi <- downloadHandler(
  filename =  function() {
    paste0("renyi_", input$multrenLevel, "_", input$multrenGroup, ".pdf")
  },
  # content is a function with argument file. content writes the plot to the device
  content = function(file) {
    pdf(file, height=4, width=6)
    grid.draw(plotRenyiIndex(x = dataFilt(), level = input$multrenLevel, colorBy = input$multrenGroup, 
                             grouped = TRUE, shapeBy=input$multrenshape, label_colors = NULL,
                             facetBy=input$multrenfacet
                             )    
)
    dev.off()
  }
)

output$RenyiHelp <- renderText({
  createHelp(?plotRenyiIndex)
})

observeEvent(input$RenHelp,
             showModal(modalDialog(
               title = paste("Help"),
               htmlOutput("RenyiHelp"),
               size = "l",
               easyClose = T
             ))
)

output$countIntervalsGroup <- renderUI({
  selectColorGroupmulti("countIntervalsGroup", dataFilt())
})

output$countIntervalsFacet <- renderUI({
  selectFacetGroup("countIntervalsFacet", dataFilt())
})

# plot count intervals
#observeEvent(input$doCountInt, {
  output$CountInt <- renderPlot({
    validate(need(!(is.null(input$countIntervalsLevel) || input$countIntervalsLevel == ""), "Select a level"))
    validate(need(!(is.null(input$countIntervalsscale) || input$countIntervalsscale == ""), "Select a scale for fractions"))
    validate(need(!(is.null(input$countIntervalsGroup) || input$countIntervalsGroup == ""), "Select a group for colours"))
    plotIntervals(x = dataFilt(), level = input$countIntervalsLevel, fractions=input$countIntervalsscale, colorBy = input$countIntervalsGroup, 
                  grouped=TRUE, facetBy=input$countIntervalsFacet, show_stats=input$countIntervalsshowstats, label_colors = NULL)    
  }) 
#})

output$downPlotCountInt <- renderUI({
  if (!is.null(input$countIntervalsLevel) & !(is.null(input$countIntervalsGroup)) #& input$doCountInt==1
      ) {
    downloadButton("PlotCountInt", "Download PDF", style="background-color:white; border-color: #022F5A;")
  }
}) 

output$PlotCountInt <- downloadHandler(
  filename =  function() {
    paste0("countIntervals_", input$countIntervalsLevel, "_", input$countIntervalsGroup, ".pdf")
  },
  # content is a function with argument file. content writes the plot to the device
  content = function(file) {
    pdf(file, height=4, width=6)
    grid.draw( plotIntervals(x = dataFilt(), level = input$countIntervalsLevel, fractions=input$countIntervalsscale, colorBy = input$countIntervalsGroup, 
                             grouped=TRUE, facetBy=input$countIntervalsFacet, show_stats=input$countIntervalsshowstats, label_colors = NULL))
    dev.off()
  }
)

output$CountIntHelp <- renderText({
  createHelp(?plotIntervals)
})

observeEvent(input$CIHelp,
             showModal(modalDialog(
               title = paste("Help"),
               htmlOutput("CountIntHelp"),
               size = "l",
               easyClose = T
             ))
)


output$multRankGroup <- renderUI({
  selectColorGroupmulti("multRankGroup", dataFilt())
})

output$multRankFacet <- renderUI({
  selectFacetGroup("multRankFacet", dataFilt())
})

output$multRank <- renderPlot({
  validate(need(!(is.null(input$multRankLevel) || input$multRankLevel == ""), "Select a level"))
  validate(need(!(is.null(input$multRankScale) || input$multRankScale == ""), "Select a scale"))
  validate(need(!(is.null(input$multRankGroup) || input$multRankGroup == ""), "Select a group for colours"))
  plotRankDistrib(x = dataFilt(), level = input$multRankLevel, scale = input$multRankScale,
                  colorBy = input$multRankGroup, facetBy=input$multRankFacet, grouped = TRUE, label_colors = NULL)    
}) 

output$downPlotMultRank <- renderUI({
  if (!is.null(input$multRankLevel) & !(is.null(input$multRankScale)) & !(is.null(input$multRankGroup))) {
    downloadButton("PlotMultRank", "Download PDF", style="background-color:white; border-color: #022F5A;")
  }
}) 

output$PlotMultRank <- downloadHandler(
  filename =  function() {
    paste0("rankDistrib_", input$multRankLevel, "_", input$multRankScale,"_",input$multRankGroup, ".pdf")
  },
  # content is a function with argument file. content writes the plot to the device
  content = function(file) {
    pdf(file, height=4, width=6)
    grid.draw(plotRankDistrib(x = dataFilt(), level = input$multRankLevel, scale = input$multRankScale,
                              colorBy = input$multRankGroup, facetBy=input$multRankFacet, grouped = TRUE, label_colors = NULL)    
    )
    dev.off()
  }
)

output$MultRankHelp <- renderText({
  createHelp(?plotRankDistrib)
})

observeEvent(input$mrankHelp,
             showModal(modalDialog(
               title = paste("Help"),
               htmlOutput("MultRankHelp"),
               size = "l",
               easyClose = T
             ))
)

output$geneUsageGroup <- renderUI({
  selectColorGroupmulti("geneUsageGroup", dataFilt())
})


output$geneUsagefacet <- renderUI({
  selectFacetGroup("geneUsagefacet", dataFilt())
})

# plot V and J gene usages
observeEvent(input$dogeneUsage, {
  output$geneUsage <- plotly::renderPlotly({
    validate(need(!(is.null(input$geneUsageScale) ||  input$geneUsageScale == ""), "Select a scale"))
    validate(need(!(is.null(input$geneUsageLevel) ||  input$geneUsageLevel == ""), "Select a level"))
    validate(need(!(is.null(input$geneUsageGroup) ||  input$geneUsageGroup == ""), "Select a group for colours"))
    plotly::ggplotly(plotGeneUsage(x = dataFilt(), level = input$geneUsageLevel, 
                                   scale = input$geneUsageScale, 
                                   colorBy = input$geneUsageGroup, 
                                   facetBy= input$geneUsagefacet, 
                                   label_colors = NULL,
                                   show_stats=input$geneUsageshowstats)+
                                   ggplot2::theme(legend.position = "none"), 
                                   tooltip = c("x", "y")) %>%
      plotly::layout(boxmode = "group")
  })
})

output$downPlotgeneUsage <- renderUI({
  if (!is.null(input$geneUsageGroup) & !(is.null(input$geneUsageLevel)) & !(is.null(input$geneUsageScale)) ) {
    downloadButton("PlotgeneUsage", "Download PDF", style="background-color:white; border-color: #022F5A;")
  }
})


output$PlotgeneUsage <- downloadHandler(
  filename =  function() {
    paste0("geneUsage_", input$geneUsageGroup, "_", input$geneUsageLevel, "_", input$geneUsageScale, ".pdf")
  },
  # content is a function with argument file. content writes the plot to the device
  content = function(file) {
    pdf(file, height=5, width=20)
    grid.draw(plotGeneUsage(x = dataFilt(), level = input$geneUsageLevel, 
                            scale = input$geneUsageScale, 
                            colorBy = input$geneUsageGroup, 
                            facetBy=input$geneUsagefacet, 
                            label_colors = NULL,
                            show_stats=input$geneUsageshowstats))
    dev.off()
  }
)

output$geneUsageHelp <- renderText({
  createHelp(?plotGeneUsage)
})

observeEvent(input$geneusageHelp,
             showModal(modalDialog(
               title = paste("Help"),
               htmlOutput("geneUsageHelp"),
               size = "l",
               easyClose = T
             ))
)


##### Similarity analysis #####
# render VennUI for selecting type of Venn Diagram
output$vennUISample <- renderUI({
  choices <- rownames(mData(dataFilt()))
  selectizeInput("vennSamples",
                 HTML("Select samples <i>(maximum 7)</i>"),  #modified by VMH
                 choices = choices,
                 options = list(maxItems = 7, onInitialize = I('function() { this.setValue(""); }')),
                 multiple = T)  #VMH changed 3 to 4
})

observeEvent(input$doVenn, {
  output$plotEulerr <- renderPlot({
    validate(need(!(is.null(input$vennLevel) || input$vennLevel == ""), "Select a level"))
    validate(need(!(is.null(input$vennSamples) || input$vennSamples ==""), "Select samples"))
    validate(need(length(input$vennSamples)>1, "Select a second sample"))
    plotVenn(x = dataFilt(), level = input$vennLevel, sampleNames = input$vennSamples)
  })
})


output$downPlotEulerr <- renderUI({
  if (!is.null(input$vennLevel) & !(is.null(input$vennSamples))) {
    downloadButton("PlotEulerr", "Download PDF", style="background-color:white; border-color: #022F5A;")
  }
}) 

output$PlotEulerr <- downloadHandler(
  filename =  function() {
    paste0("eulerr_", input$vennLevel, "_", input$vennSamples, ".pdf")
  },
  # content is a function with argument file. content writes the plot to the device
  content = function(file) {
    pdf(file, height=4, width=6)
    grid.draw(plotVenn(x = dataFilt(), level = input$vennLevel, sampleNames = input$vennSamples))
    dev.off()
  }
)

output$EulerrHelp <- renderText({
  createHelp(?plotVenn)
})

observeEvent(input$eulerHelp,
             showModal(modalDialog(
               title = paste("Help"),
               htmlOutput("EulerrHelp"),
               size = "l",
               easyClose = T
             ))
)


output$scatterUISample <- renderUI({
  choices <- rownames(mData(dataFilt()))
  selectizeInput("scatterUISample",
                 "Select samples <i>(maximum 2)</i>",  
                 choices = choices,
                 options = list(maxItems = 2, onInitialize = I('function() { this.setValue(""); }')),
                 multiple = T)
})

output$Scatter <- plotly::renderPlotly({
  validate(need(!(is.null(input$scatterLevel) || input$scatterLevel == ""), "Select a level"))
  validate(need(!(is.null(input$scatterScale) || input$scatterScale == ""), "Select a scale"))
  validate(need(!(is.null(input$scatterUISample) || input$scatterUISample ==""), "Select samples"))
  validate(need(length(input$scatterUISample)>1, "Select a second sample"))
  plotly::ggplotly(plotScatter(x = dataFilt(), sampleNames = input$scatterUISample, level = input$scatterLevel, scale = input$scatterScale))
})

output$downPlotScatter <- renderUI({
  if (!is.null(input$scatterUISample) & !(is.null(input$scatterLevel)) & !(is.null(input$scatterScale))) {
    downloadButton("PlotScatter", "Download PDF", style="background-color:white; border-color: #022F5A;")
  }
}) 

output$PlotScatter <- downloadHandler(
  filename =  function() {
    paste0("scatter_", input$scatterUISample, "_", input$scatterLevel, "_", input$scatterScale, ".pdf")
  },
  # content is a function with argument file. content writes the plot to the device
  content = function(file) {
    pdf(file, height=4, width=6)
    grid.draw(plotScatter(x = dataFilt(), sampleNames = input$scatterUISample, level = input$scatterLevel, scale = input$scatterScale))
    dev.off()
  }
)

output$ScatterHelp <- renderText({
  createHelp(?plotScatter)
})

observeEvent(input$scatterHelp,
             showModal(modalDialog(
               title = paste("Help"),
               htmlOutput("ScatterHelp"),
               size = "l",
               easyClose = T
             ))
)

output$multdissGroup <- renderUI({
  selectMultGroupDE("multdissGroup", dataFilt())
})


observeEvent(input$doHm1, {
  validate(need(!(is.null(input$dissimilarityLevel) || input$dissimilarityLevel == ""), "Select a level"))
  validate(need(!(is.null(input$dissimilarityIndex) || input$dissimilarityIndex == ""), "Select a dissimilarity method"))
  validate(need(!(is.null(input$dissimilarityClustering) || input$dissimilarityClustering == ""), "Select a clustering method"))
  validate(need(!(is.null(input$multdissGroup) || input$multdissGroup == ""), "Select one or multiple groups"))
  pdf(file = NULL)
  hm1 <- plotDissimilarity(x = dataFilt(), level = input$dissimilarityLevel, method = input$dissimilarityIndex, colorBy = input$multdissGroup, binary = FALSE, clustering = input$dissimilarityClustering, label_colors = NULL, plot = 'Heatmap')    
  hm1@column_names_param$gp$fontsize <- 10
  hm1@row_names_param$gp$fontsize <- 10
  ht1 <- ComplexHeatmap::draw(hm1)
  makeInteractiveComplexHeatmap(input, output, session, ht1, "ht1")
})   

output$downPlotDisHM <- renderUI({
  if (!is.null(input$dissimilarityLevel) & !(is.null(input$dissimilarityIndex)) & !(is.null(input$dissimilarityClustering)) & !(is.null(input$multdissGroup))) {
    downloadButton("PlotDisHM", "Download PDF", style="background-color:white; border-color: #022F5A;")
  }
}) 

output$PlotDisHM <- downloadHandler(
  filename =  function() {
    paste0("dissimilarityHeatmap_", input$dissimilarityLevel, "_", input$dissimilarityIndex, "_", input$dissimilarityClustering, '_', input$multdissGroup, ".pdf")
  },
  # content is a function with argument file. content writes the plot to the device
  content = function(file) {
    pdf(file, height=8, width=12)
    hm <- plotDissimilarity(x = dataFilt(), level = input$dissimilarityLevel,
                            method = input$dissimilarityIndex, binary = FALSE,
                            clustering = input$dissimilarityClustering, 
                            colorBy = input$multdissGroup, label_colors = NULL, plot = 'Heatmap')
    ComplexHeatmap::draw(hm)
    dev.off()
  }
)

output$DisHMHelp <- renderText({
  createHelp(?plotDissimilarity)
})

observeEvent(input$disHMHelp,
             showModal(modalDialog(
               title = paste("Help"),
               htmlOutput("DisHMHelp"),
               size = "l",
               easyClose = T
             ))
)

output$NB_diss <- renderText({
  "<b>Note: Do not use the interactivate sub-heatmap mode in the configure sub-heatmap tab.</b>"
})

# plot MDS
output$multMDSGroup <- renderUI({
  selectMultGroupDE("multMDSGroup", dataFilt())
})

observeEvent(input$doMds, {
output$MDS <- plotly::renderPlotly({
  validate(need(!(is.null(input$MDSLevel) || input$MDSLevel == ""), "Select a level"))
  validate(need(!(is.null(input$MDSMethod) || input$MDSMethod == ""), "Select a dissimilarity method"))
  validate(need(!(is.null(input$multMDSGroup) || input$multMDSGroup == ""), "Select one or multiple groups"))
  plotly::ggplotly(plotDissimilarity(x = dataFilt(), level = input$MDSLevel, method = input$MDSMethod, colorBy = input$multMDSGroup, binary = FALSE, label_colors = NULL, plot = 'MDS'))  
})   
})

output$downPlotMDS <- renderUI({
  if (!is.null(input$MDSLevel) & !(is.null(input$MDSMethod)) & !(is.null(input$multMDSGroup)) & input$doMds ==1) {
    downloadButton("PlotMDS", "Download PDF", style="background-color:white; border-color: #022F5A;")
  }
}) 

output$PlotMDS <- downloadHandler(
  filename =  function() {
    paste0("MDS_", input$MDSLevel, "_", input$MDSMethod, "_",  input$multMDSGroup, ".pdf")
  },
  # content is a function with argument file. content writes the plot to the device
  content = function(file) {
    pdf(file, height=8, width=12)
    grid.draw(plotDissimilarity(x = dataFilt(), level = input$MDSLevel, method = input$MDSMethod, binary = FALSE, colorBy = input$multMDSGroup, label_colors = NULL, plot = 'MDS'))
    dev.off()
  }
)

output$DisMDSHelp <- renderText({
  createHelp(?plotDissimilarity)
})

observeEvent(input$DisMDSHelp,
             showModal(modalDialog(
               title = paste("Help"),
               htmlOutput("DisMDSHelp"),
               size = "l",
               easyClose = T
             ))
)



# include md formula distance function
output$distFuncsMD <- renderUI({
    shiny::withMathJax(includeMarkdown("markdown/distanceFuncs.md"))
})

# include md diversity index computation
output$diversityMD <- renderUI({
    shiny::withMathJax(includeMarkdown("markdown/DiversityIndex.md"))
})

output$diffGroup <- renderUI({
  sdata <- mData(dataFilt())[,unlist(lapply(mData(dataFilt()), function(y) { is.character(y) | is.factor(y)} )), drop = FALSE]
  to_keep <- sapply(sdata, function(i) nlevels(i)/length(i))
  to_keep <- names(to_keep)[which(to_keep < 1)]
  idx <- sapply(sdata, function(i) unique(i))[to_keep]
  
  choices <- list()
  for(i in 1:length(idx)){
    choices[[names(idx)[i]]] <- c(names(idx)[i], as.character(idx[[i]]))
  }
  selectizeInput("diffGroup",
                 "Select a group and subgroups",  
                 choices = choices,
                 options = list(minItems=3, onInitialize = I('function() { this.setValue(""); }')),
                 multiple = T)
})

output$tableDiffExpGroup <- DT::renderDataTable({
  validate(need(!(is.null(input$diffLevel) || input$diffLevel == ""), "Select a level"))
  validate(need(!(is.null(input$diffGroup) || input$diffGroup == ""), "Select a group and subgroups")) 
  validate(need(length(input$diffGroup)>=3, "Need at least one group and 2 subgroups")) 
  diffExpGroup(x = dataFilt(), colGrp = input$diffGroup[[1]], level = input$diffLevel, group = input$diffGroup)
})

output$downloadtableDiffExpGroup <- downloadHandler(
  "RepSeqData_differentialExpressionTable.csv",
  content = function(file) {
    write.table(diffExpGroup(x = dataFilt(), colGrp = input$diffGroup[[1]], level = input$diffLevel, group = input$diffGroup), file, row.names = F, sep = '\t')
  }, contentType = "text/csv"
) 

output$DiffExpTabHelp <- renderText({
  createHelp(?diffExpGroup)
})

observeEvent(input$difftabHelp,
             showModal(modalDialog(
               title = paste("Help"),
               htmlOutput("DiffExpTabHelp"),
               size = "l",
               easyClose = T
             ))
)

output$Volcano <- plotly::renderPlotly({
  validate(need(!(is.null(input$diffLevel) || input$diffLevel == ""), "Select a level"))
  validate(need(!(is.null(input$diffFC) || input$diffFC == ""), "Select a fold-change threshold")) 
  validate(need(!(is.null(input$diffPV) || input$diffPV == ""), "Select a pvalue threshold")) 
  validate(need(!(is.null(input$diffGroup) || input$diffGroup == ""), "Select a group and subgroups")) 
  validate(need(length(input$diffGroup)>=3, "Need at least one group and 2 subgroups"))
  plotly::ggplotly(plotDiffExp(x = dataFilt(), level = input$diffLevel, group =  input$diffGroup, FC.TH = input$diffFC, PV.TH = input$diffPV, top = 0))
})

output$downPlotVolcano <- renderUI({
  if (!is.null(input$diffLevel) & !(is.null(input$diffGroup)) & !(is.null(input$diffFC)) & !(is.null(input$diffPV))) {
    downloadButton("plotVolcano", "Download PDF", style="background-color:white; border-color: #022F5A;")
  }
}) 

output$PlotVolcano <- downloadHandler(
  filename =  function() {
    paste0("volcano_", input$diffLevel, "_", input$diffGroup, "_", input$diffFC, "_", input$diffPV, ".pdf")
  },
  # content is a function with argument file. content writes the plot to the device
  content = function(file) {
    pdf(file, height=4, width=6)
    grid.draw(plotDiffExp(x = dataFilt(), level = input$diffLevel, group =  input$diffGroup, FC.TH = input$diffFC, PV.TH = input$diffPV, top = 0))
    dev.off()
  }
)

output$VolcanoHelp <- renderText({
  createHelp(?plotDiffExp)
})

observeEvent(input$volcanoHelp,
             showModal(modalDialog(
               title = paste("Help"),
               htmlOutput("VolcanoHelp"),
               size = "l",
               easyClose = T
             ))
)
# output$diffPCAGroup <- renderUI({
#   sdata <- mData(dataFilt())[,unlist(lapply(mData(dataFilt()), function(y) { is.character(y) | is.factor(y)} )), drop = FALSE]
#   to_keep <- sapply(sdata, function(i) nlevels(i)/length(i))
#   to_keep <- names(to_keep)[which(to_keep < 1)]
#   idx <- sapply(sdata, function(i) unique(i))[to_keep]
#   
#   choices <- list()
#   for(i in 1:length(idx)){
#     choices[[names(idx)[i]]] <- c(names(idx)[i], as.character(idx[[i]]))
#   }
#   selectizeInput("diffPCAGroup",
#                  "Select a group and subgroups",  
#                  choices = choices,
#                  options = list(minItems=3, onInitialize = I('function() { this.setValue(""); }')),
#                  multiple = T)
# })

# output$plotPCA <- plotly::renderPlotly({
#   validate(need(!(is.null(input$diffPCALevel) || input$diffPCALevel == ""), "Select a level"))
#   validate(need(!(is.null(input$diffPCAGroup) || input$diffPCAGroup == ""), "Select a group and subgroups")) 
#   validate(need(length(input$diffPCAGroup)>=3, "Need at least one group and 2 subgroups"))
#   plotly::ggplotly(plotDiffExp(x = dataFilt(), level = input$diffPCALevel, group = input$diffPCAGroup, label_colors = NULL, plot = "PCA"))
# })
# 
# output$downPlotPCA <- renderUI({
#   if (!is.null(input$diffPCALevel) & !(is.null(input$PCAMethod)) & !(is.null(input$diffPCAGroup))) {
#     downloadButton("PlotPCA", "Download PDF", style="background-color:white; border-color: #022F5A;")
#   }
# }) 
# 
# output$PlotPCA <- downloadHandler(
#   filename =  function() {
#     paste0("PCA", "_", input$diffPCALevel, "_", input$PCAMethod, "_", input$diffPCAGroup, ".pdf")
#   },
#   # content is a function with argument file. content writes the plot to the device
#   content = function(file) {
#     pdf(file, height=4, width=6)
#     grid.draw(plotDiffExp(x = dataFilt(), level = input$diffPCALevel, group = input$diffPCAGroup, label_colors = NULL, plot = "PCA"))
#     dev.off()
#   }
# )
# 
# output$PCAHelp <- renderText({
#   createHelp(?plotDiffExp)
# })
# 
# observeEvent(input$pcaHelp,
#              showModal(modalDialog(
#                title = paste("Help"),
#                htmlOutput("PCAHelp"),
#                size = "l",
#                easyClose = T
#              ))
# )


# render select group UI
output$PertGroupUI <- renderUI({
  selectGroupDE("PertGroupSelected", dataFilt())
})
# render selection control group
output$CtrlGroupUI <- renderUI({
  validate(need(!(is.null(input$PertGroupSelected) || input$PertGroupSelected ==""), ""))
  selectizeInput("CtrlGroup",
                 "Select a control group",
                 choices = levels(mData(dataFilt())[, input$PertGroupSelected]),
                 options = list(onInitialize = I('function() { this.setValue(""); }')),
                 multiple = F
  )
})
# render selection distance
output$PertDistUI <- renderUI({
  validate(need(!(is.null(input$PertGroupSelected) || input$PertGroupSelected ==""), ""))
  validate(need(!(is.null(input$CtrlGroup) || input$CtrlGroup == ""), ""))
  selectizeInput("pertDist",
                 "Select a distance",
                 choices = list("manhattan", "euclidean"),
                 options = list(onInitialize = I('function() { this.setValue(""); }')),
                 multiple = F
  )
})
# create perturbation data
dataPert <- reactive({
  validate(need(!(is.null(input$PertGroupSelected) || input$PertGroupSelected ==""), ""))
  validate(need(!(is.null(input$CtrlGroup) || input$CtrlGroup == ""), ""))
  validate(need(!(is.null(input$pertDist) || input$pertDist == ""), ""))
  validate(need(!(is.null(input$pertOrder) || input$pertOrder == ""), ""))
  sampleinfo <- mData(dataFilt())
  ctrnames <- rownames(sampleinfo)[which(sampleinfo[, input$PertGroupSelected] %in% input$CtrlGroup)]
  pertscore <- perturbationScore(x = dataFilt(), ctrl.names = ctrnames, distance = input$pertDist, p = 2)
  return(pertscore)
})

output$PertTabHelp <- renderText({
  createHelp(?perturbationScore)
})

observeEvent(input$perttabHelp,
             showModal(modalDialog(
               title = paste("Help"),
               htmlOutput("PertTabHelp"),
               size = "l",
               easyClose = T
             ))
)

output$pertOrder <- renderUI({
  validate(need(!(is.null(input$PertGroupSelected) || input$PertGroupSelected ==""), ""))
  validate(need(!(is.null(input$CtrlGroup) || input$CtrlGroup == ""), ""))
  #validate(need(!(is.null(input$pertDist) || input$pertDist == ""), ""))
  sdata <- mData(dataFilt())[,unlist(lapply(mData(dataFilt()), function(y) { is.character(y) | is.factor(y)} )), drop = FALSE]
  idx <- sapply(sdata, function(i) nlevels(i)/length(i))
  choices <- colnames(sdata)[which(idx < 1)]
  
  selectizeInput(
    "pertOrder",
    "Order labels by",
    choices = choices,
    options = list(onInitialize = I('function() { this.setValue(""); }'))
  )
})

# output$plotPerturbation <- renderPlot({
#   validate(need(!(is.null(input$PertGroupSelected) || input$PertGroupSelected ==""), "select a group"))
#   validate(need(!(is.null(input$CtrlGroup) || input$CtrlGroup == ""), "select a control group"))
#   validate(need(!(is.null(input$pertDist) || input$pertDist == ""), "select a distance method"))
#   validate(need(!(is.null(input$pertOrder) || input$pertOrder == ""), "select an order sample by"))
#   sampleinfo <- mData(dataFilt())
#   ctrnames <- rownames(sampleinfo)[which(sampleinfo[, input$PertGroupSelected] %in% input$CtrlGroup)]
#   plotPerturbationScore(x = dataFilt(), ctrl.names = ctrnames, distance = input$pertDist, order = input$pertOrder, label_colors = NULL)
# })

observeEvent(input$doHm, {
  validate(need(!(is.null(input$PertGroupSelected) || input$PertGroupSelected == ""), "Select a group"))
  validate(need(!(is.null(input$CtrlGroup) || input$CtrlGroup == ""), "Select a control group"))
  validate(need(!(is.null(input$pertDist) || input$pertDist == ""), "Select a distance method"))
  validate(need(!(is.null(input$pertOrder) || input$pertOrder == ""), "Select an order sample by"))
  sampleinfo <- mData(dataFilt())
  ctrnames <- rownames(sampleinfo)[which(sampleinfo[, input$PertGroupSelected] %in% input$CtrlGroup)]
  pdf(file = NULL)
  hm <- plotPerturbationScore(x = dataFilt(), ctrl.names = ctrnames, distance = input$pertDist, order = input$pertOrder, label_colors = NULL)
  hm@column_names_param$gp$fontsize <- 10
  hm@row_names_param$gp$fontsize <- 10
  ht <- ComplexHeatmap::draw(hm)
  makeInteractiveComplexHeatmap(input, output, session, ht, "ht")
})


# data output
output$PertTab <- renderDataTable({
  validate(need(input$doHm==1, ""))
  return(datatable(dataPert(), options = list(scrollX=TRUE, dom = 'Bfrtip', pageLength = 10)) %>% formatRound(c(1: ncol(dataPert())), 2))
})

output$downloadPertTab <- downloadHandler(
  "RepSeq_pertubationScore.csv",
  content = function(file) {
    write.table(dataPert(), file, row.names = F, sep = '\t')
  }, contentType = "text/csv"
) 

output$downPlotPert <- renderUI({
  if (!(is.null(input$pertDist)) & !(is.null(input$pertOrder))) {
    downloadButton("PlotPert", "Download PDF", style="background-color:white; border-color: #022F5A;")
  }
}) 

output$PlotPert <- downloadHandler(
  filename =  function() {
    paste0("perturbation", "_", input$pertDist, "_", input$pertOrder, ".pdf")
  },
  # content is a function with argument file. content writes the plot to the device
  content = function(file) {
    #graphics.off()
    pdf(file, height=4, width=7)
    sampleinfo <- mData(dataFilt())
    ctrnames <- rownames(sampleinfo)[which(sampleinfo[, input$PertGroupSelected] %in% input$CtrlGroup)]
    hm <- plotPerturbationScore(x = dataFilt(), ctrl.names = ctrnames, distance = input$pertDist, order = input$pertOrder, label_colors = NULL)
    ComplexHeatmap::draw(hm)
    dev.off()
  }
)

output$PertHelp <- renderText({
  createHelp(?plotPerturbationScore)
})

observeEvent(input$pertHelp,
             showModal(modalDialog(
               title = paste("Help"),
               htmlOutput("PertHelp"),
               size = "l",
               easyClose = T
             ))
)

output$NB_pert <- renderText({
  "<b>Note: Do not use the interactivate sub-heatmap mode in the configure sub-heatmap tab.</b>"
})

# 
# # render 2by2 comparison
# output$count2v2Libs <- renderUI({
#     selectizeInput("count2v2Libs",
#         "Select two samples", #modified by VMH
#         choices = rownames(mData(dat())),
#         options = list(maxItems = 2, onInitialize = I('function() { this.setValue(""); }')),
#         multiple = T
#     )
# })
# # plot 2by2 comparison
# output$plot2v2count <- renderPlot({
#     print(input$count2v2Libs)
#     validate(need(!(is.null(input$count2v2Level) || input$count2v2Level == ""), "select level"))
#     validate(need(!(is.null(input$count2v2Libs) || input$count2v2Libs == ""), "select a first sample"))
#     validate(need(length(input$count2v2Libs)==2, "select a second sample"))
#     plotScatter(x = dat(), level = input$count2v2Level, sampleNames = input$count2v2Libs, scale = input$count2v2scale) + 
#         ggplot2::theme(aspect.ratio = 1)
# })
# # selected region
# selected2v2count <- eventReactive(input$plot2v2count_brush,{
#     brush2v2count(dat(), input$count2v2Level, input$count2v2Libs, input$plot2v2count_brush)
# })
# # render selected region DT
# output$brush2v2countDT <- DT::renderDataTable({
#     validate(need(!(is.null(input$count2v2Level) || input$count2v2Level == ""), "select level"))
#     validate(need(!(is.null(input$count2v2Libs) || input$count2v2Libs == ""), "select the first sample")) #modified by VMH
#     validate(need(length(input$count2v2Libs)==2, "select a second sample"))
#     datatable(selected2v2count(), options=list(scrollX=TRUE))
# }) 
# # dowload button for the selected data set   
# output$downloadSelected <- renderUI({
#     if (!is.null(input$plot2v2count_brush)) {
#         downloadButton('OutputFile', 'Download Output File')
#     }
# })
# # make the download button 
# output$OutputFile <- downloadHandler(
#     filename = function() {
#         paste("data-", Sys.Date(), ".csv", sep="")
#     },
#     content = function(file) {
#         write.csv(selected2v2count(), file, row.names=TRUE)
#     }
# )



