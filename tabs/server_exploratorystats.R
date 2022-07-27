#--------------------------------------------------------------------------------#
#  statistical analysis - diffferential analysis section
#--------------------------------------------------------------------------------#  
#### Basic Statistics ####

output$plotStats <- renderUI({
    selectGroupStat("plotStats", dataFilt())
})
output$plotStatistic <- renderPlot({
        validate(need(!(is.null(input$plotStats) || input$plotStats == ""), "select stat"))
        plotStatistics(x=dataFilt(), stat = input$plotStats, groupBy = NULL, label_colors = NULL)
    })

output$downPlotStatsBasic <- renderUI({
    if (!is.null(input$plotStats)) {
        downloadButton("PlotStatsBasic", "Download PNG")
    }
}) 

output$PlotStatsBasic <- downloadHandler(
    filename =  function() {
        paste0("metadataStatistics_", input$plotStats, ".png")
    },
    # content is a function with argument file. content writes the plot to the device
    content = function(file) {
        png(file, height=2400, width=4800, res=300)
        grid.newpage()
        grid.draw(plotStatistics(x=dataFilt(), stat = input$plotStats, groupBy = NULL, label_colors = NULL))
        dev.off()
    }
)

output$dataCountFeatures <- renderDataTable({
    validate(need(!(is.null(input$countLevel) || input$countLevel == ""), "select level"))
    validate(need(!(is.null(input$countScale) || input$countScale == ""), "select scale"))
    countFeatures(x=dataFilt(), level = input$countLevel, scale = input$countScale, group = NULL)
})
output$downloadCountFeatures <- downloadHandler(
    "RepSeq_detailedStatistics.csv",
    content = function(file) {
        write.table(countFeatures(x=dataFilt(), level = input$countLevel, scale = input$countScale, group = NULL), file, row.names = F, sep = '\t')
    }, contentType = "text/csv"
) 

output$plotRare <- renderUI({
    selectGroup("plotRare", dataFilt())
})
output$plotrarefaction <- renderPlot({
    validate(need(!(is.null(input$plotRare) || input$plotRare == ""), "select group"))
    plotRarefaction(x=dataFilt(), colorBy = input$plotRare, label_colors = NULL)
})

output$downPlotRare <- renderUI({
    if (!is.null(input$plotRare)) {
        downloadButton("PlotRare", "Download PNG")
    }
}) 

output$PlotRare <- downloadHandler(
    filename =  function() {
        paste0("rarefactionCurve_", input$plotRare, ".png")
    },
    # content is a function with argument file. content writes the plot to the device
    content = function(file) {
        png(file, height=2400, width=4800, res=300)
        grid.newpage()
        grid.draw(plotRarefaction(x=dataFilt(), colorBy = input$plotRare, label_colors = NULL))
        dev.off()
    }
)

output$dataRare <- renderDataTable({
    validate(need(!(is.null(input$plotRare) || input$plotRare == ""), "select group"))
    rarefactionTab(x = dataFilt())
})
output$downloaddataRare <- downloadHandler(
    "RepSeq_rarefactionData.csv",
    content = function(file) {
        write.table(    rarefactionTab(x = dataFilt()), file, row.names = F, sep = '\t')
    }, contentType = "text/csv"
) 
#### Diversity estimation ####

output$plotDiv <- renderPlot({
    validate(need(!(is.null(input$divIndex) || input$divIndex == ""), "select index"))
    validate(need(!(is.null(input$divLevel) || input$divLevel == ""), "select level"))
    plotDiversity(x=dataFilt(), index = input$divIndex, level = input$divLevel, groupBy = NULL, label_colors = NULL)
})
output$downPlotDiv <- renderUI({
    if (!is.null(input$plotRare) & !is.null(input$divLevel)) {
        downloadButton("PlotDiv", "Download PNG")
    }
}) 

output$PlotDiv <- downloadHandler(
    filename =  function() {
        paste0("diversityPlot_", input$divIndex, "_", input$divLevel, ".png")
    },
    # content is a function with argument file. content writes the plot to the device
    content = function(file) {
        png(file, height=2400, width=4800, res=300)
        grid.newpage()
        grid.draw(plotDiversity(x=dataFilt(), index = input$divIndex, level = input$divLevel, groupBy = NULL, label_colors = NULL))
        dev.off()
    }
)


output$dataDiv <- renderDataTable({
    validate(need(!(is.null(input$divLevel) || input$divLevel == ""), "select level"))
    diversityIndices(x=dataFilt(), level = input$divLevel)
})
output$downloaddataDiv <- downloadHandler(
    "RepSeq_diversityIndices.csv",
    content = function(file) {
        write.table(diversityIndices(x=dataFilt(), level = input$divLevel), file, row.names = F, sep = '\t')
    }, contentType = "text/csv"
) 

output$plotRenyi <- renderPlot({
    validate(need(!(is.null(input$renyiLevel) || input$renyiLevel == ""), "select level"))
    plotRenyiIndex(x=dataFilt(), level = input$renyiLevel, colorBy = "sample_id", grouped = FALSE, label_colors = NULL)
})
output$downPlotRenyi2 <- renderUI({
    if (!is.null(input$renyiLevel)) {
        downloadButton("PlotRenyi2", "Download PNG")
    }
}) 

output$PlotRenyi2 <- downloadHandler(
    filename =  function() {
        paste0("RenyiPlot_", input$renyiLevel, ".png")
    },
    # content is a function with argument file. content writes the plot to the device
    content = function(file) {
        png(file, height=2400, width=4800, res=300)
        grid.newpage()
        grid.draw(plotRenyiIndex(x=dataFilt(), level = input$renyiLevel, colorBy = "sample_id", grouped = FALSE, label_colors = NULL))
        dev.off()
    }
)

output$dataRenyi <- renderDataTable({
    validate(need(!(is.null(input$renyiLevel) || input$renyiLevel == ""), "select level"))
    renyiIndex(x=dataFilt(), level = input$renyiLevel)
})
output$downloaddataRenyi <- downloadHandler(
    "RepSeq_renyiIndex.csv",
    content = function(file) {
        write.table(renyiIndex(x=dataFilt(), level = input$renyiLevel), file, row.names = F, sep = '\t')
    }, contentType = "text/csv"
) 
# output$countIntGroup <- renderUI({
#     selectGroup(ID = "countIntGroup", x = dataFilt())
# })

output$CountIntervals <- renderPlot({
    validate(need(!(is.null(input$countIntLevel) || input$countIntLevel == ""), "select level"))
    #validate(need(!(is.null(input$countIntGroup) || input$countIntGroup == ""), "select group"))
    plotCountIntervals(x=dataFilt(), level = input$countIntLevel, groupBy = NULL, label_colors = NULL)
})

output$downPlotCountIntervals2 <- renderUI({
    if (!is.null(input$countIntLevel)) {
        downloadButton("PlotCountIntervals2", "Download PNG")
    }
}) 

output$PlotCountIntervals2 <- downloadHandler(
    filename =  function() {
        paste0("CountIntervals_", input$countIntLevel, ".png")
    },
    # content is a function with argument file. content writes the plot to the device
    content = function(file) {
        png(file, height=2400, width=4800, res=300)
        grid.newpage()
        grid.draw(plotCountIntervals(x=dataFilt(), level = input$countIntLevel, groupBy = NULL, label_colors = NULL))
        dev.off()
    }
)

# plot VJ distribution
output$rankDistrib <- renderPlot({
    validate(need(!(is.null(input$rankDistribGroupMeth) || input$rankDistribGroupMeth == ""), "select scale"))
    validate(need(!(is.null(input$rankDistribLevel) || input$rankDistribLevel == ""), "select level"))
    plotRankDistrib(x = dataFilt(), level = input$rankDistribLevel, scale = input$rankDistribGroupMeth, colorBy = "sample_id", grouped = FALSE, label_colors = NULL)
})

output$downPlotrankDistrib <- renderUI({
    if (!is.null(input$rankDistribLevel) & !is.null(input$rankDistribGroupMeth)) {
        downloadButton("PlotrankDistrib", "Download PNG")
    }
}) 

output$PlotrankDistrib <- downloadHandler(
    filename =  function() {
        paste0("rankDistrib_", input$rankDistribLevel, "_", input$rankDistribGroupMeth, ".png")
    },
    # content is a function with argument file. content writes the plot to the device
    content = function(file) {
        png(file, height=2400, width=4800, res=300)
        grid.newpage()
        grid.draw(plotRankDistrib(x = dataFilt(), level = input$rankDistribLevel, scale = input$rankDistribGroupMeth, colorBy = "sample_id", grouped = FALSE, label_colors = NULL))
        dev.off()
    }
)