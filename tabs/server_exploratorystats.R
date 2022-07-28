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
        downloadButton("PlotStatsBasic", "Download PDF")
    }
}) 

output$PlotStatsBasic <- downloadHandler(
    filename =  function() {
        paste0("metadataStatistics_", input$plotStats, ".pdf")
    },
    # content is a function with argument file. content writes the plot to the device
    content = function(file) {
        pdf(file, height=12, width=24)
        grid.draw(plotStatistics(x=dataFilt(), stat = input$plotStats, groupBy = NULL, label_colors = NULL))
        dev.off()
    }
)

output$basicStatsHelp <- renderText({
    createHelp(?plotStatistics)
})

observeEvent(input$basicstatsHelp,
             showModal(modalDialog(
                 title = paste("Help page"),
                 htmlOutput("basicStatsHelp"),
                 size = "l",
                 easyClose = T
             ))
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

output$countFeaturesHelp <- renderText({
    createHelp(?countFeatures)
})

observeEvent(input$countfeaturesHelp,
             showModal(modalDialog(
                 title = paste("Help page"),
                 htmlOutput("countFeaturesHelp"),
                 size = "l",
                 easyClose = T
             ))
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
        downloadButton("PlotRare", "Download PDF")
    }
}) 

output$PlotRare <- downloadHandler(
    filename =  function() {
        paste0("rarefactionCurve_", input$plotRare, ".pdf")
    },
    # content is a function with argument file. content writes the plot to the device
    content = function(file) {
        pdf(file, height=12, width=24)
        grid.draw(plotRarefaction(x=dataFilt(), colorBy = input$plotRare, label_colors = NULL))
        dev.off()
    }
)

output$RareHelp <- renderText({
    createHelp(?plotRarefaction)
})

observeEvent(input$rareHelp,
             showModal(modalDialog(
                 title = paste("Help page"),
                 htmlOutput("RareHelp"),
                 size = "l",
                 easyClose = T
             ))
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
        downloadButton("PlotDiv", "Download PDF")
    }
}) 

output$PlotDiv <- downloadHandler(
    filename =  function() {
        paste0("diversityPlot_", input$divIndex, "_", input$divLevel, ".pdf")
    },
    # content is a function with argument file. content writes the plot to the device
    content = function(file) {
        pdf(file, height=12, width=24)
        grid.draw(plotDiversity(x=dataFilt(), index = input$divIndex, level = input$divLevel, groupBy = NULL, label_colors = NULL))
        dev.off()
    }
)

output$basicDivHelp <- renderText({
    createHelp(?plotDiversity)
})

observeEvent(input$basicdivHelp,
             showModal(modalDialog(
                 title = paste("Help page"),
                 htmlOutput("basicDivHelp"),
                 size = "l",
                 easyClose = T
             ))
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
        downloadButton("PlotRenyi2", "Download PDF")
    }
}) 

output$PlotRenyi2 <- downloadHandler(
    filename =  function() {
        paste0("RenyiPlot_", input$renyiLevel, ".pdf")
    },
    # content is a function with argument file. content writes the plot to the device
    content = function(file) {
        pdf(file, height=12, width=24)
        grid.draw(plotRenyiIndex(x=dataFilt(), level = input$renyiLevel, colorBy = "sample_id", grouped = FALSE, label_colors = NULL))
        dev.off()
    }
)

output$basicRenyiHelp <- renderText({
    createHelp(?plotRenyiIndex)
})

observeEvent(input$basicrenHelp,
             showModal(modalDialog(
                 title = paste("Help page"),
                 htmlOutput("basicRenyiHelp"),
                 size = "l",
                 easyClose = T
             ))
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
        downloadButton("PlotCountIntervals2", "Download PDF")
    }
}) 

output$PlotCountIntervals2 <- downloadHandler(
    filename =  function() {
        paste0("CountIntervals_", input$countIntLevel, ".pdf")
    },
    # content is a function with argument file. content writes the plot to the device
    content = function(file) {
        pdf(file, height=12, width=24)
        grid.draw(plotCountIntervals(x=dataFilt(), level = input$countIntLevel, groupBy = NULL, label_colors = NULL))
        dev.off()
    }
)

output$basicCountIntHelp <- renderText({
    createHelp(?plotCountIntervals)
})

observeEvent(input$basiccountintHelp,
             showModal(modalDialog(
                 title = paste("Help page"),
                 htmlOutput("basicCountIntHelp"),
                 size = "l",
                 easyClose = T
             ))
)

# plot VJ distribution
output$rankDistrib <- renderPlot({
    validate(need(!(is.null(input$rankDistribGroupMeth) || input$rankDistribGroupMeth == ""), "select scale"))
    validate(need(!(is.null(input$rankDistribLevel) || input$rankDistribLevel == ""), "select level"))
    plotRankDistrib(x = dataFilt(), level = input$rankDistribLevel, scale = input$rankDistribGroupMeth, colorBy = "sample_id", grouped = FALSE, label_colors = NULL)
})

output$downPlotrankDistrib <- renderUI({
    if (!is.null(input$rankDistribLevel) & !is.null(input$rankDistribGroupMeth)) {
        downloadButton("PlotrankDistrib", "Download PDF")
    }
}) 

output$PlotrankDistrib <- downloadHandler(
    filename =  function() {
        paste0("rankDistrib_", input$rankDistribLevel, "_", input$rankDistribGroupMeth, ".pdf")
    },
    # content is a function with argument file. content writes the plot to the device
    content = function(file) {
        pdf(file, height=12, width=24)
        grid.draw(plotRankDistrib(x = dataFilt(), level = input$rankDistribLevel, scale = input$rankDistribGroupMeth, colorBy = "sample_id", grouped = FALSE, label_colors = NULL))
        dev.off()
    }
)


output$rankDistribHelp <- renderText({
    createHelp(?plotRankDistrib)
})

observeEvent(input$rankdistribHelp,
             showModal(modalDialog(
                 title = paste("Help page"),
                 htmlOutput("rankDistribHelp"),
                 size = "l",
                 easyClose = T
             ))
)


