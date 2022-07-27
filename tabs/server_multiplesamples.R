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
    validate(need(!(is.null(input$statisticsStat) || input$statisticsStat == ""), "select stat"))
    validate(need(!(is.null(input$statisticsGroup) || input$statisticsGroup == ""), "select group"))
    plotStatistics(x = dataFilt(), stat = input$statisticsStat, groupBy = input$statisticsGroup, label_colors = NULL)    
})  

output$downPlotStatistics <- renderUI({
  if (!is.null(input$statisticsStat) & !(is.null(input$statisticsGroup))) {
    downloadButton("PlotStatistics", "Download PNG")
  }
}) 

output$PlotStatistics <- downloadHandler(
  filename =  function() {
    paste0("metadataStatistics_", input$statisticsStat, "_", input$statisticsGroup, ".png")
  },
  # content is a function with argument file. content writes the plot to the device
  content = function(file) {
    png(file, height=2400, width=4800, res=300)
    grid.newpage()
    grid.draw(plotStatistics(x = dataFilt(), stat = input$statisticsStat, groupBy = input$statisticsGroup, label_colors = NULL))
    dev.off()
  }
)

output$diverGroup <- renderUI({
  selectGroupDE("diverGroup", dataFilt())
})

# plot diversity
output$Diversity <- renderPlot({
  validate(need(!(is.null(input$diverLevel) || input$diverLevel == ""), "select level"))
  validate(need(!(is.null(input$diverIndex) || input$diverIndex == ""), "select index"))
  validate(need(!(is.null(input$diverGroup) || input$diverGroup == ""), "select group"))
  plotDiversity(x = dataFilt(), level = input$diverLevel, groupBy = input$diverGroup, index = input$diverIndex, label_colors = NULL)    
})  

output$downPlotDiversity <- renderUI({
  if (!is.null(input$diverLevel) & !(is.null(input$diverGroup))& !(is.null(input$diverIndex))) {
    downloadButton("PlotDiversity", "Download PNG")
  }
}) 

output$PlotDiversity <- downloadHandler(
  filename =  function() {
    paste0("diversity_", input$diverLevel, "_", input$diverGroup, "_", input$diverIndex, ".png")
  },
  # content is a function with argument file. content writes the plot to the device
  content = function(file) {
    png(file, height=2400, width=4800, res=300)
    grid.newpage()
    grid.draw(plotDiversity(x = dataFilt(), level = input$diverLevel, groupBy = input$diverGroup, index = input$diverIndex, label_colors = NULL))
    dev.off()
  }
)

output$RenyiDiversity <- renderPlot({
  validate(need(!(is.null(input$diverLevel) || input$diverLevel == ""), "select level"))
  validate(need(!(is.null(input$diverGroup) || input$diverGroup == ""), "select group"))
  plotRenyiIndex(x = dataFilt(), level = input$diverLevel, colorBy = input$diverGroup, grouped = TRUE, label_colors = NULL)    
})  

output$downPlotRenyi <- renderUI({
  if (!is.null(input$diverLevel) & !(is.null(input$diverGroup))) {
    downloadButton("PlotRenyi", "Download PNG")
  }
}) 

output$PlotRenyi <- downloadHandler(
  filename =  function() {
    paste0("renyi_", input$diverLevel, "_", input$diverGroup, ".png")
  },
  # content is a function with argument file. content writes the plot to the device
  content = function(file) {
    png(file, height=2400, width=4800, res=300)
    grid.newpage()
    grid.draw(plotRenyiIndex(x = dataFilt(), level = input$diverLevel, colorBy = input$diverGroup, grouped = TRUE, label_colors = NULL))
    dev.off()
  }
)

output$countIntervalsGroup <- renderUI({
  selectGroupDE("countIntervalsGroup", dataFilt())
})
# plot count intervals
output$CountInt <- renderPlot({
  validate(need(!(is.null(input$countIntervalsLevel) || input$countIntervalsLevel == ""), "select level"))
  validate(need(!(is.null(input$countIntervalsGroup) || input$countIntervalsGroup == ""), "select group"))
  plotCountIntervals(x = dataFilt(), level = input$countIntervalsLevel, groupBy = input$countIntervalsGroup, label_colors = NULL)    
}) 

output$downPlotCountInt <- renderUI({
  if (!is.null(input$countIntervalsLevel) & !(is.null(input$countIntervalsGroup))) {
    downloadButton("PlotCountInt", "Download PNG")
  }
}) 

output$PlotCountInt <- downloadHandler(
  filename =  function() {
    paste0("countIntervals_", input$countIntervalsLevel, "_", input$countIntervalsGroup, ".png")
  },
  # content is a function with argument file. content writes the plot to the device
  content = function(file) {
    png(file, height=2400, width=4800, res=300)
    grid.newpage()
    grid.draw(plotCountIntervals(x = dataFilt(), level = input$countIntervalsLevel, groupBy = input$countIntervalsGroup, label_colors = NULL))
    dev.off()
  }
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
  validate(need(!(is.null(input$vennLevel) || input$vennLevel == ""), "select level"))
  validate(need(!(is.null(input$vennSamples) || input$vennSamples ==""), "select samples"))
  validate(need(length(input$vennSamples)>1, "select a second sample"))
  plotEulerr(x = dataFilt(), level = input$vennLevel, sampleNames = input$vennSamples)
})

output$downPlotEulerr <- renderUI({
  if (!is.null(input$vennLevel) & !(is.null(input$vennSamples))) {
    downloadButton("PlotEulerr", "Download PNG")
  }
}) 

output$PlotEulerr <- downloadHandler(
  filename =  function() {
    paste0("eulerr_", input$vennLevel, "_", input$vennSamples, ".png")
  },
  # content is a function with argument file. content writes the plot to the device
  content = function(file) {
    png(file, height=2400, width=4800, res=300)
    grid.newpage()
    grid.draw(plotEulerr(x = dataFilt(), level = input$vennLevel, sampleNames = input$vennSamples))
    dev.off()
  }
)

output$scatterUISample <- renderUI({
  choices <- rownames(mData(dataFilt()))
  selectizeInput("scatterUISample",
                 "Select samples (maximum 2)",  
                 choices = choices,
                 options = list(maxItems = 2, onInitialize = I('function() { this.setValue(""); }')),
                 multiple = T)
})

output$Scatter <- renderPlot({
  validate(need(!(is.null(input$scatterLevel) || input$scatterLevel == ""), "select level"))
  validate(need(!(is.null(input$scatterScale) || input$scatterScale == ""), "select scale"))
  validate(need(!(is.null(input$scatterUISample) || input$scatterUISample ==""), "select samples"))
  validate(need(length(input$scatterUISample)>1, "select a second sample"))
  plotScatter(x = dataFilt(), sampleNames = input$scatterUISample, level = input$scatterLevel, scale = input$scatterScale)
})

output$downPlotScatter <- renderUI({
  if (!is.null(input$scatterUISample) & !(is.null(input$scatterLevel)) & !(is.null(input$scatterScale))) {
    downloadButton("PlotScatter", "Download PNG")
  }
}) 

output$PlotScatter <- downloadHandler(
  filename =  function() {
    paste0("scatter_", input$scatterUISample, "_", input$scatterLevel, "_", input$scatterScale, ".png")
  },
  # content is a function with argument file. content writes the plot to the device
  content = function(file) {
    png(file, height=2400, width=4800, res=300)
    grid.newpage()
    grid.draw(plotScatter(x = dataFilt(), sampleNames = input$scatterUISample, level = input$scatterLevel, scale = input$scatterScale))
    dev.off()
  }
)

output$GrpColMDS <- renderUI({
    validate(need(!(is.null(input$dissimilarityLevel) || input$dissimilarityLevel == ""), " "))
    validate(need(!(is.null(input$dissimilarityIndex) || input$dissimilarityIndex == ""), " "))
    validate(need(!(is.null(input$dissimilarityClustering) || input$dissimilarityClustering == ""), " "))
    validate(need(!(is.null(input$dissimilarityMethod) || input$dissimilarityMethod == ""), " "))
    selectGroupDE("grpCol4MDS", dataFilt())
})
# plot dissimilarity
output$plotDissimilarityHM <- renderPlot({
    validate(need(!(is.null(input$dissimilarityLevel) || input$dissimilarityLevel == ""), "select level"))
    validate(need(!(is.null(input$dissimilarityIndex) || input$dissimilarityIndex == ""), "select dissimilarity index"))
    validate(need(!(is.null(input$dissimilarityClustering) || input$dissimilarityClustering == ""), "select dissimilarity clustering"))
    plotDissimilarityMatrix(x = dataFilt(), level = input$dissimilarityLevel, method = input$dissimilarityIndex, binary = FALSE, clustering = input$dissimilarityClustering, label_colors = NULL)    
})    

output$downPlotDisHM <- renderUI({
  if (!is.null(input$dissimilarityLevel) & !(is.null(input$dissimilarityIndex)) & !(is.null(input$dissimilarityClustering))) {
    downloadButton("PlotDisHM", "Download PNG")
  }
}) 

output$PlotDisHM <- downloadHandler(
  filename =  function() {
    paste0("dissimilarityHeatmap_", input$dissimilarityLevel, "_", input$dissimilarityIndex, "_", input$dissimilarityClustering, ".png")
  },
  # content is a function with argument file. content writes the plot to the device
  content = function(file) {
    png(file, height=2400, width=4800, res=300)
    grid.newpage()
    grid.draw(plotDissimilarityMatrix(x = dataFilt(), level = input$dissimilarityLevel, method = input$dissimilarityIndex, binary = FALSE, clustering = input$dissimilarityClustering, label_colors = NULL))
    dev.off()
  }
)

# plot MDS
output$plotMDS <- renderPlot({
    validate(need(!(is.null(input$dissimilarityLevel) || input$dissimilarityLevel == ""), " "))
    validate(need(!(is.null(input$dissimilarityIndex) || input$dissimilarityIndex == ""), " "))
    validate(need(!(is.null(input$dissimilarityClustering) || input$dissimilarityClustering == ""), "select dissimilarity clustering"))
    validate(need(!(is.null(input$dissimilarityMethod) || input$dissimilarityMethod == ""), "select dissimilarity method"))
    validate(need(!(is.null(input$grpCol4MDS) || input$grpCol4MDS == ""), "select group"))
    group <- switch((input$grpCol4MDS == "Sample") + 1, input$grpCol4MDS, NULL)
    plotDimReduction(x = dataFilt(), level = input$dissimilarityLevel, method = input$dissimilarityIndex, colorBy = group, label_colors = NULL, dim_method = input$dissimilarityMethod)
})

output$downPlotMDS <- renderUI({
  if (!is.null(input$dissimilarityLevel) & !(is.null(input$dissimilarityIndex)) & !(is.null(input$grpCol4MDS)) & !(is.null(input$dissimilarityMethod))) {
    downloadButton("PlotMDS", "Download PNG")
  }
}) 

output$PlotMDS <- downloadHandler(
  filename =  function() {
    paste0("dissimilarity", input$dissimilarityMethod, "_", input$dissimilarityLevel, "_", input$dissimilarityIndex, "_", input$grpCol4MDS, ".png")
  },
  # content is a function with argument file. content writes the plot to the device
  content = function(file) {
    png(file, height=2400, width=4800, res=300)
    group <- switch((input$grpCol4MDS == "Sample") + 1, input$grpCol4MDS, NULL)
    grid.newpage()
    grid.draw(plotDimReduction(x = dataFilt(), level = input$dissimilarityLevel, method = input$dissimilarityIndex, colorBy = group, label_colors = NULL, dim_method = input$dissimilarityMethod))
    dev.off()
  }
)


# include md formula distance function
output$distFuncsMD <- renderUI({
    shiny::withMathJax(includeMarkdown("markdown/distanceFuncs.md"))
})

# include md diversity index computation
output$diversityMD <- renderUI({
    shiny::withMathJax(includeMarkdown("markdown/DiversityIndex.md"))
})

output$diffColGroup <- renderUI({
  selectGroupDE("diffColGroup", dataFilt())
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
                 "Select a group and features",  
                 choices = choices,
                 options = list(minItems=3, onInitialize = I('function() { this.setValue(""); }')),
                 multiple = T)
})

output$tableDiffExpGroup <- DT::renderDataTable({
  validate(need(!(is.null(input$diffLevel) || input$diffLevel == ""), "select level"))
  validate(need(!(is.null(input$diffColGroup) || input$diffColGroup == ""), "select group")) 
  validate(need(!(is.null(input$diffGroup) || input$diffGroup == ""), "select group and features")) 
  validate(need(length(input$diffGroup)>=3, "Need at least one group and 2 features")) 
  diffExpGroup(x = dataFilt(), colGrp = input$diffColGroup, level = input$diffLevel, group = input$diffGroup)
})

output$Volcano <- plotly::renderPlotly({
  validate(need(!(is.null(input$diffLevel) || input$diffLevel == ""), " "))
  validate(need(!(is.null(input$diffFC) || input$diffFC == ""), "select fold-change threshold")) 
  validate(need(!(is.null(input$diffPV) || input$diffPV == ""), "select pvalue threshold")) 
  validate(need(!(is.null(input$diffGroup) || input$diffGroup == ""), "select group and features")) 
  validate(need(length(input$diffGroup)>=3, "Need at least one group and 2 features")) 
  plotly::ggplotly(plotVolcano(x = dataFilt(), level = input$diffLevel, group =  input$diffGroup, FC.TH = input$diffFC, PV.TH = input$diffPV, top = 0))
})

output$downPlotVolcano <- renderUI({
  if (!is.null(input$diffLevel) & !(is.null(input$diffGroup)) & !(is.null(input$diffFC)) & !(is.null(input$diffPV))) {
    downloadButton("PlotVolcano", "Download PNG")
  }
}) 

output$PlotVolcano <- downloadHandler(
  filename =  function() {
    paste0("volcano_", input$diffLevel, "_", input$diffGroup, "_", input$diffFC, "_", input$diffPV, ".png")
  },
  # content is a function with argument file. content writes the plot to the device
  content = function(file) {
    png(file, height=2400, width=4800, res=300)
    grid.newpage()
    grid.draw(plotVolcano(x = dataFilt(), level = input$diffLevel, group =  input$diffGroup, FC.TH = input$diffFC, PV.TH = input$diffPV, top = 0))
    dev.off()
  }
)

output$plotPCA <- plotly::renderPlotly({
  validate(need(!(is.null(input$diffLevel) || input$diffLevel == ""), " "))
  validate(need(!(is.null(input$PCAMethod) || input$PCAMethod == ""), "select distance method")) 
  validate(need(!(is.null(input$PCAdimMethod) || input$PCAdimMethod == ""), "select dimension reduction method")) 
  validate(need(!(is.null(input$diffColGroup) || input$diffColGroup == ""), "select group")) 
  plotly::ggplotly(plotDimReduction(x = dataFilt(), level = input$diffLevel, method = input$PCAMethod, colorBy = input$diffColGroup, label_colors = NULL, dim_method = input$PCAdimMethod))
})

output$downPlotPCA <- renderUI({
  if (!is.null(input$diffLevel) & !(is.null(input$PCAMethod)) & !(is.null(input$PCAdimMethod)) & !(is.null(input$diffColGroup))) {
    downloadButton("PlotPCA", "Download PNG")
  }
}) 

output$PlotPCA <- downloadHandler(
  filename =  function() {
    paste0(input$PCAdimMethod, "_", input$diffLevel, "_", input$PCAMethod, "_", input$diffColGroup, ".png")
  },
  # content is a function with argument file. content writes the plot to the device
  content = function(file) {
    png(file, height=2400, width=4800, res=300)
    grid.newpage()
    grid.draw(plotDimReduction(x = dataFilt(), level = input$diffLevel, method = input$PCAMethod, colorBy = input$diffColGroup, label_colors = NULL, dim_method = input$PCAdimMethod))
    dev.off()
  }
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
  validate(need(!(is.null(input$pertOrder) || input$pertOrder == ""), ""))
  sampleinfo <- mData(dataFilt())
  ctrnames <- rownames(sampleinfo)[which(sampleinfo[, input$PertGroupSelected] %in% input$CtrlGroup)]
  pertscore <- perturbationScore(x = dataFilt(), ctrl.names = ctrnames, distance = input$pertDist, p = input$pertPower)
  return(pertscore)
})
output$pertOrder <- renderUI({
  validate(need(!(is.null(input$PertGroupSelected) || input$PertGroupSelected ==""), ""))
  validate(need(!(is.null(input$CtrlGroup) || input$CtrlGroup == ""), ""))
  validate(need(!(is.null(input$pertDist) || input$pertDist == ""), ""))
  selectGroupDE("pertOrder", dataFilt())
})

output$plotPerturbation <- renderPlot({
  validate(need(!(is.null(input$PertGroupSelected) || input$PertGroupSelected ==""), ""))
  validate(need(!(is.null(input$CtrlGroup) || input$CtrlGroup == ""), ""))
  validate(need(!(is.null(input$pertDist) || input$pertDist == ""), ""))
  validate(need(!(is.null(input$pertOrder) || input$pertOrder == ""), ""))
  sampleinfo <- mData(dataFilt())
  ctrnames <- rownames(sampleinfo)[which(sampleinfo[, input$PertGroupSelected] %in% input$CtrlGroup)]
  plotPerturbationScore(x = dataFilt(), ctrl.names = ctrnames, distance = input$pertDist, order = input$pertOrder, label_colors = NULL)
})

# data output
output$PertTab <- renderDataTable({
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
    downloadButton("PlotPert", "Download PNG")
  }
}) 

output$PlotPert <- downloadHandler(
  filename =  function() {
    paste0("perturbation", "_", input$pertDist, "_", input$pertOrder, ".png")
  },
  # content is a function with argument file. content writes the plot to the device
  content = function(file) {
    png(file, height=2400, width=4800, res=300)
    sampleinfo <- mData(dataFilt())
    ctrnames <- rownames(sampleinfo)[which(sampleinfo[, input$PertGroupSelected] %in% input$CtrlGroup)]
    grid.newpage()
    grid.draw(plotPerturbationScore(x = dataFilt(), ctrl.names = ctrnames, distance = input$pertDist, order = input$pertOrder, label_colors = NULL))
    dev.off()
  }
)

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



