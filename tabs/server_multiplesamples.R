#-------------------------------------------------------------------------------------------------------------------------------------------#
#  multiple comparison section
#-------------------------------------------------------------------------------------------------------------------------------------------#    

output$statisticsStat <- renderUI({
  selectGroupStat("statisticsStat", dataFilt())
})

output$statisticsGroup <- renderUI({
  selectGroupDE("statisticsGroup", dataFilt())
})

# plot statistics
output$Statistics <- renderPlot({
    validate(need(!(is.null(input$statisticsStat) || input$statisticsStat == ""), "select a statistic"))
    validate(need(!(is.null(input$statisticsGroup) || input$statisticsGroup == ""), "select a group"))
    plotStatistics(x = dataFilt(), stat = input$statisticsStat, groupBy = input$statisticsGroup, label_colors = NULL)    
})  

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
  if (!is.null(input$statisticsStat) & !(is.null(input$statisticsGroup))) {
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
    grid.draw(plotStatistics(x = dataFilt(), stat = input$statisticsStat, groupBy = input$statisticsGroup, label_colors = NULL))
    dev.off()
  }
)

output$diverGroup <- renderUI({
  selectGroupDE("diverGroup", dataFilt())
})

# plot diversity
output$Diversity <- renderPlot({
  validate(need(!(is.null(input$diverLevel) || input$diverLevel == ""), "select a level"))
  validate(need(!(is.null(input$diverIndex) || input$diverIndex == ""), "select an index"))
  validate(need(!(is.null(input$diverGroup) || input$diverGroup == ""), "select a group"))
  plotDiversity(x = dataFilt(), level = input$diverLevel, groupBy = input$diverGroup, index = input$diverIndex, label_colors = NULL)    
})  

output$downPlotDiversity <- renderUI({
  if (!is.null(input$diverLevel) & !(is.null(input$diverGroup))& !(is.null(input$diverIndex))) {
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
    grid.draw(plotDiversity(x = dataFilt(), level = input$diverLevel, groupBy = input$diverGroup, index = input$diverIndex, label_colors = NULL))
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
output$multrenGroup <- renderUI({
  selectGroupDE("multrenGroup", dataFilt())
})

output$RenyiDiversity <- renderPlot({
  validate(need(!(is.null(input$multrenLevel) || input$multrenLevel == ""), "select a level"))
  validate(need(!(is.null(input$multrenGroup) || input$multrenGroup == ""), "select a group"))
  plotRenyiIndex(x = dataFilt(), level = input$multrenLevel, colorBy = input$multrenGroup, grouped = TRUE, label_colors = NULL)    
})  

output$downPlotRenyi <- renderUI({
  if (!is.null(input$multrenLevel) & !(is.null(input$multrenGroup))) {
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
    grid.draw(plotRenyiIndex(x = dataFilt(), level = input$multrenLevel, colorBy = input$multrenGroup, grouped = TRUE, label_colors = NULL))
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
  selectGroupDE("countIntervalsGroup", dataFilt())
})
# plot count intervals
output$CountInt <- renderPlot({
  validate(need(!(is.null(input$countIntervalsLevel) || input$countIntervalsLevel == ""), "select a level"))
  validate(need(!(is.null(input$countIntervalsGroup) || input$countIntervalsGroup == ""), "select a group"))
  plotCountIntervals(x = dataFilt(), level = input$countIntervalsLevel, groupBy = input$countIntervalsGroup, label_colors = NULL)    
}) 

output$downPlotCountInt <- renderUI({
  if (!is.null(input$countIntervalsLevel) & !(is.null(input$countIntervalsGroup))) {
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
    grid.draw(plotCountIntervals(x = dataFilt(), level = input$countIntervalsLevel, groupBy = input$countIntervalsGroup, label_colors = NULL))
    dev.off()
  }
)

output$CountIntHelp <- renderText({
  createHelp(?plotCountIntervals)
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
  selectGroupDE("multRankGroup", dataFilt())
})
output$multRank <- renderPlot({
  validate(need(!(is.null(input$multRankLevel) || input$multRankLevel == ""), "select a level"))
  validate(need(!(is.null(input$multRankScale) || input$multRankScale == ""), "select a scale"))
  validate(need(!(is.null(input$multRankGroup) || input$multRankGroup == ""), "select a group"))
  plotRankDistrib(x = dataFilt(), level = input$multRankLevel, scale = input$multRankScale, colorBy = input$multRankGroup, grouped = TRUE, label_colors = NULL)    
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
    grid.draw(plotRankDistrib(x = dataFilt(), level = input$multRankLevel, scale = input$multRankScale, colorBy = input$multRankGroup, grouped = TRUE, label_colors = NULL))
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
  selectGroupDE("geneUsageGroup", dataFilt())
})
# plot V and J gene usages
output$geneUsage <- plotly::renderPlotly({
  validate(need(!(is.null(input$geneUsageScale) ||  input$geneUsageScale == ""), "select a scale"))
  validate(need(!(is.null(input$geneUsageLevel) ||  input$geneUsageLevel == ""), "select a level"))
  validate(need(!(is.null(input$geneUsageGroup) ||  input$geneUsageGroup == ""), "select a group"))
  plotly::ggplotly(plotGeneUsage(x = dataFilt(), level = input$geneUsageLevel, scale = input$geneUsageScale, groupBy = input$geneUsageGroup, label_colors = NULL)+theme(legend.position = "none"), 
                   tooltip = c("x", "y")) %>%
    plotly::layout(boxmode = "group")
})
output$downPlotgeneUsage <- renderUI({
  if (!is.null(input$geneUsageGroup) & !(is.null(input$geneUsageLevel)) & !(is.null(input$geneUsageScale))) {
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
    grid.draw(plotGeneUsage(x = dataFilt(), level = input$geneUsageLevel, scale = input$geneUsageScale, groupBy = input$geneUsageGroup, label_colors = NULL))
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
                 "Select samples",  #modified by VMH
                 choices = choices,
                 options = list(maxItems = length(choices), onInitialize = I('function() { this.setValue(""); }')),
                 multiple = T)  #VMH changed 3 to 4
})

output$plotEulerr <- renderPlot({
  validate(need(!(is.null(input$vennLevel) || input$vennLevel == ""), "select a level"))
  validate(need(!(is.null(input$vennSamples) || input$vennSamples ==""), "select samples"))
  validate(need(length(input$vennSamples)>1, "select a second sample"))
  validate(need(!(is.null(input$vennSeed) || input$vennSeed ==""), "select a seed"))
  set.seed(input$vennSeed)
  plotEulerr(x = dataFilt(), level = input$vennLevel, sampleNames = input$vennSamples)
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
    grid.draw(plotEulerr(x = dataFilt(), level = input$vennLevel, sampleNames = input$vennSamples))
    dev.off()
  }
)

output$EulerrHelp <- renderText({
  createHelp(?plotEulerr)
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
                 "Select samples (maximum 2)",  
                 choices = choices,
                 options = list(maxItems = 2, onInitialize = I('function() { this.setValue(""); }')),
                 multiple = T)
})

output$Scatter <- plotly::renderPlotly({
  validate(need(!(is.null(input$scatterLevel) || input$scatterLevel == ""), "select a level"))
  validate(need(!(is.null(input$scatterScale) || input$scatterScale == ""), "select a scale"))
  validate(need(!(is.null(input$scatterUISample) || input$scatterUISample ==""), "select samples"))
  validate(need(length(input$scatterUISample)>1, "select a second sample"))
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

output$GrpColMDS <- renderUI({
    selectGroupDE("grpCol4MDS", dataFilt())
})
# plot dissimilarity
# output$plotDissimilarityHM <- renderPlot({
#     validate(need(!(is.null(input$dissimilarityLevel) || input$dissimilarityLevel == ""), "select a level"))
#     validate(need(!(is.null(input$dissimilarityIndex) || input$dissimilarityIndex == ""), "select a dissimilarity method"))
#     validate(need(!(is.null(input$dissimilarityClustering) || input$dissimilarityClustering == ""), "select a dissimilarity clustering"))
#     hm1 <- plotDissimilarityMatrix(x = dataFilt(), level = input$dissimilarityLevel, method = input$dissimilarityIndex, binary = FALSE, clustering = input$dissimilarityClustering, label_colors = NULL)    
#     ht1 <- ComplexHeatmap::draw(hm1)
#     makeInteractiveComplexHeatmap(input, output, session, ht1, "ht1")
# })    

observeEvent(input$doHm1, {
  validate(need(!(is.null(input$dissimilarityLevel) || input$dissimilarityLevel == ""), "select a level"))
  validate(need(!(is.null(input$dissimilarityIndex) || input$dissimilarityIndex == ""), "select a dissimilarity method"))
  validate(need(!(is.null(input$dissimilarityClustering) || input$dissimilarityClustering == ""), "select a dissimilarity clustering"))
  hm1 <- plotDissimilarityMatrix(x = dataFilt(), level = input$dissimilarityLevel, method = input$dissimilarityIndex, binary = FALSE, clustering = input$dissimilarityClustering, label_colors = NULL)    
  hm1@column_names_param$gp$fontsize <- 10
  hm1@row_names_param$gp$fontsize <- 10
  ht1 <- ComplexHeatmap::draw(hm1)
  makeInteractiveComplexHeatmap(input, output, session, ht1, "ht1")
})   

output$downPlotDisHM <- renderUI({
  if (!is.null(input$dissimilarityLevel) & !(is.null(input$dissimilarityIndex)) & !(is.null(input$dissimilarityClustering))) {
    downloadButton("PlotDisHM", "Download PDF", style="background-color:white; border-color: #022F5A;")
  }
}) 

output$PlotDisHM <- downloadHandler(
  filename =  function() {
    paste0("dissimilarityHeatmap_", input$dissimilarityLevel, "_", input$dissimilarityIndex, "_", input$dissimilarityClustering, ".pdf")
  },
  # content is a function with argument file. content writes the plot to the device
  content = function(file) {
    pdf(file, height=8, width=12)
    hm <- plotDissimilarityMatrix(x = dataFilt(), level = input$dissimilarityLevel, method = input$dissimilarityIndex, binary = FALSE, clustering = input$dissimilarityClustering, label_colors = NULL)
    ComplexHeatmap::draw(hm)
    dev.off()
  }
)

output$DisHMHelp <- renderText({
  createHelp(?plotDissimilarityMatrix)
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
output$plotMDS <- renderPlot({
    validate(need(!(is.null(input$MDSLevel) || input$MDSLevel == ""), "select a level"))
    validate(need(!(is.null(input$MDSMethod) || input$MDSMethod == ""), "select a dissimilarity method"))
    validate(need(!(is.null(input$grpCol4MDS) || input$grpCol4MDS == ""), "select a group"))
    group <- switch((input$grpCol4MDS == "Sample") + 1, input$grpCol4MDS, NULL)
    plotDimReduction(x = dataFilt(), level = input$MDSLevel, method = input$MDSMethod, colorBy = group, label_colors = NULL, dim_method = "MDS")
})

output$downPlotMDS <- renderUI({
  if (!is.null(input$MDSLevel) & !(is.null(input$MDSMethod)) & !(is.null(input$grpCol4MDS))) {
    downloadButton("PlotMDS", "Download PDF", style="background-color:white; border-color: #022F5A;")
  }
}) 

output$PlotMDS <- downloadHandler(
  filename =  function() {
    paste0("dissimilarityMDS", "_", input$MDSLevel, "_", input$MDSMethod, "_", input$grpCol4MDS, ".pdf")
  },
  # content is a function with argument file. content writes the plot to the device
  content = function(file) {
    pdf(file, height=4, width=6)
    group <- switch((input$grpCol4MDS == "Sample") + 1, input$grpCol4MDS, NULL)
    grid.draw(plotDimReduction(x = dataFilt(), level = input$MDSLevel, method = input$MDSMethod, colorBy = group, label_colors = NULL, dim_method = "MDS"))
    dev.off()
  }
)

output$MDSHelp <- renderText({
  createHelp(?plotDimReduction)
})

observeEvent(input$mdsHelp,
             showModal(modalDialog(
               title = paste("Help"),
               htmlOutput("MDSHelp"),
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
  validate(need(!(is.null(input$diffLevel) || input$diffLevel == ""), "select a level"))
  validate(need(!(is.null(input$diffGroup) || input$diffGroup == ""), "select a group and subgroups")) 
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
  validate(need(!(is.null(input$diffLevel) || input$diffLevel == ""), "select a level"))
  validate(need(!(is.null(input$diffFC) || input$diffFC == ""), "select a fold-change threshold")) 
  validate(need(!(is.null(input$diffPV) || input$diffPV == ""), "select a pvalue threshold")) 
  validate(need(!(is.null(input$diffGroup) || input$diffGroup == ""), "select a group and subgroups")) 
  validate(need(length(input$diffGroup)>=3, "Need at least one group and 2 subgroups"))
  plotly::ggplotly(plotVolcano(x = dataFilt(), level = input$diffLevel, group =  input$diffGroup, FC.TH = input$diffFC, PV.TH = input$diffPV, top = 0))
})

output$downPlotVolcano <- renderUI({
  if (!is.null(input$diffLevel) & !(is.null(input$diffGroup)) & !(is.null(input$diffFC)) & !(is.null(input$diffPV))) {
    downloadButton("PlotVolcano", "Download PDF", style="background-color:white; border-color: #022F5A;")
  }
}) 

output$PlotVolcano <- downloadHandler(
  filename =  function() {
    paste0("volcano_", input$diffLevel, "_", input$diffGroup, "_", input$diffFC, "_", input$diffPV, ".pdf")
  },
  # content is a function with argument file. content writes the plot to the device
  content = function(file) {
    pdf(file, height=4, width=6)
    grid.draw(plotVolcano(x = dataFilt(), level = input$diffLevel, group =  input$diffGroup, FC.TH = input$diffFC, PV.TH = input$diffPV, top = 0))
    dev.off()
  }
)

output$VolcanoHelp <- renderText({
  createHelp(?plotVolcano)
})

observeEvent(input$volcanoHelp,
             showModal(modalDialog(
               title = paste("Help"),
               htmlOutput("VolcanoHelp"),
               size = "l",
               easyClose = T
             ))
)
output$diffPCAGroup <- renderUI({
  selectGroupDE("diffPCAGroup", dataFilt())
})

output$plotPCA <- renderPlot({
  validate(need(!(is.null(input$diffPCALevel) || input$diffPCALevel == ""), "select a level"))
  validate(need(!(is.null(input$PCAMethod) || input$PCAMethod == ""), "select a distance method")) 
  validate(need(!(is.null(input$diffPCAGroup) || input$diffPCAGroup == ""), "select a group")) 
  plotDimReduction(x = dataFilt(), level = input$diffPCALevel, method = input$PCAMethod, colorBy = input$diffPCAGroup, label_colors = NULL, dim_method = "PCA")
})

output$downPlotPCA <- renderUI({
  if (!is.null(input$diffPCALevel) & !(is.null(input$PCAMethod)) & !(is.null(input$diffPCAGroup))) {
    downloadButton("PlotPCA", "Download PDF", style="background-color:white; border-color: #022F5A;")
  }
}) 

output$PlotPCA <- downloadHandler(
  filename =  function() {
    paste0("PCA", "_", input$diffPCALevel, "_", input$PCAMethod, "_", input$diffPCAGroup, ".pdf")
  },
  # content is a function with argument file. content writes the plot to the device
  content = function(file) {
    pdf(file, height=4, width=6)
    grid.draw(plotDimReduction(x = dataFilt(), level = input$diffPCALevel, method = input$PCAMethod, colorBy = input$diffPCAGroup, label_colors = NULL, dim_method = "PCA"))
    dev.off()
  }
)

output$PCAHelp <- renderText({
  createHelp(?plotDimReduction)
})

observeEvent(input$pcaHelp,
             showModal(modalDialog(
               title = paste("Help"),
               htmlOutput("PCAHelp"),
               size = "l",
               easyClose = T
             ))
)


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
  pertscore <- perturbationScore(x = dataFilt(), ctrl.names = ctrnames, distance = input$pertDist, p = input$pertPower)
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
  validate(need(!(is.null(input$PertGroupSelected) || input$PertGroupSelected == ""), "select a group"))
  validate(need(!(is.null(input$CtrlGroup) || input$CtrlGroup == ""), "select a control group"))
  validate(need(!(is.null(input$pertDist) || input$pertDist == ""), "select a distance method"))
  validate(need(!(is.null(input$pertOrder) || input$pertOrder == ""), "select an order sample by"))
  sampleinfo <- mData(dataFilt())
  ctrnames <- rownames(sampleinfo)[which(sampleinfo[, input$PertGroupSelected] %in% input$CtrlGroup)]
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



