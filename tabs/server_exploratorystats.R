#--------------------------------------------------------------------------------#
#  statistical analysis - diffferential analysis section
#--------------------------------------------------------------------------------#  
#### Basic Statistics ####

output$plotStats <- renderUI({
    selectGroupStat("plotStats", dataFilt())
})

output$plotcolorgroup <- renderUI({
  selectColorGroup("plotcolorgroup", dataFilt())
})

output$plotfacetgroup <- renderUI({
  selectFacetGroup("plotfacetgroup", dataFilt())
})


output$plotStatistic <- renderPlot({
        validate(need(!(is.null(input$plotStats) || input$plotStats == ""), "select a statistic"))
        validate(need(!(is.null(input$plotcolorgroup) || input$plotcolorgroup == ""), "select a group for colors"))
        #validate(need(!(is.null(input$plotfacetgroup) || input$plotfacetgroup == ""), "select up to two groups for facets"))
        
        plotStatistics(x=dataFilt(), stat = input$plotStats, colorBy = input$plotcolorgroup , facetBy = input$plotfacetgroup, label_colors = NULL)
    })

output$downPlotStatsBasic <- renderUI({
    if (!is.null(input$plotStats)) {
        downloadButton("PlotStatsBasic", "Download PDF", style="background-color:white; border-color: #022F5A;")
    }
}) 

output$PlotStatsBasic <- downloadHandler(
    filename =  function() {
        paste0("metadataStatistics_", input$plotStats, ".pdf")
    },
    # content is a function with argument file. content writes the plot to the device
    content = function(file) {
        pdf(file, height=4, width=6)
        grid.draw( plotStatistics(x=dataFilt(), stat = input$plotStats, colorBy = input$plotcolorgroup , facetBy = input$plotfacetgroup, label_colors = NULL)
)
        dev.off()
    }
)

output$basicStatsHelp <- renderText({
    createHelp(?plotStatistics)
})

observeEvent(input$basicstatsHelp,
             showModal(modalDialog(
                 title = paste("Help"),
                 htmlOutput("basicStatsHelp"),
                 size = "l",
                 easyClose = T
             ))
)

output$dataCountFeatures <- renderReactable({
    validate(need(!(is.null(input$countLevel) || input$countLevel == ""), "select a level"))
    validate(need(!(is.null(input$countScale) || input$countScale == ""), "select a scale"))
   
   dt<-countFeatures(x=dataFilt(), level = input$countLevel, scale = input$countScale, group = NULL)
   name<-colnames(dt)[1]
   
   dtb <- as.matrix(dt, rownames = name)
   if(input$countScale == "count") dtb <- apply(dtb, 2, function(y) (y - min(dtb)) / (max(dtb) - min(dtb)))
   
   color_list = lapply(1:ncol(dtb), function(x){
     rgb(colorRamp(c("#7fb7d7", "#ffffbf", "#fc8d59"), bias=.5)(dtb[,x]), maxColorValue = 255)
   })
   names(color_list) = LETTERS[1:ncol(dtb)]
   
   style_list = lapply(1:ncol(dtb), function(x){
     colDef(style = JS(paste0("function(rowInfo, column, state) {
                                      const { ", LETTERS[x], " } = state.meta
                                        return { backgroundColor: ", LETTERS[x], "[rowInfo.index] }
                                    }")))
   })
   names(style_list) <- colnames(dtb)
 
   reactable( dt, showSortable = TRUE,
              meta = color_list,
              columns =c(setNames(list(colDef(filterable = TRUE,
                                     sticky = "left",
                                     # Add a right border style to visually distinguish the sticky column
                                     style = list(borderRight = "1px solid #eee"),
                                     headerStyle = list(borderRight = "1px solid #eee"))), name), style_list),
              
              highlight = TRUE,
              showPageSizeOptions = TRUE,
              pageSizeOptions = c(5,10),
              defaultPageSize = 5,
              paginationType = "simple"
             
    )
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
                 title = paste("Help"),
                 htmlOutput("countFeaturesHelp"),
                 size = "l",
                 easyClose = T
             ))
)

output$plotRare <- renderUI({
  selectColorGroup("plotRare", dataFilt())
})
output$plotrarefaction <- plotly::renderPlotly({
    validate(need(!(is.null(input$plotRare) || input$plotRare == ""), "select a group"))
    plotly::ggplotly(plotRarefaction(x=dataFilt(), colorBy = input$plotRare, label_colors = NULL)+ggplot2::theme(legend.position = "right"))
})

output$downPlotRare <- renderUI({
    if (!is.null(input$plotRare)) {
        downloadButton("PlotRare", "Download PDF", style="background-color:white; border-color: #022F5A;")
    }
}) 

output$PlotRare <- downloadHandler(
    filename =  function() {
        paste0("rarefactionCurve_", input$plotRare, ".pdf")
    },
    # content is a function with argument file. content writes the plot to the device
    content = function(file) {
        pdf(file, height=4, width=6)
        grid.draw(plotRarefaction(x=dataFilt(), colorBy = input$plotRare, label_colors = NULL))
        dev.off()
    }
)

output$RareHelp <- renderText({
    createHelp(?plotRarefaction)
})

observeEvent(input$rareHelp,
             showModal(modalDialog(
                 title = paste("Help"),
                 htmlOutput("RareHelp"),
                 size = "l",
                 easyClose = T
             ))
)

output$dataRare <- renderDataTable({
    validate(need(!(is.null(input$plotRare) || input$plotRare == ""), "select a group"))
    rarefactionTab(x = dataFilt())
})
output$downloaddataRare <- downloadHandler(
    "RepSeq_rarefactionData.csv",
    content = function(file) {
        write.table(    rarefactionTab(x = dataFilt()), file, row.names = F, sep = '\t')
    }, contentType = "text/csv"
) 

output$dataRareHelp <- renderText({
    createHelp(?rarefactionTab)
})

observeEvent(input$raretabHelp,
             showModal(modalDialog(
                 title = paste("Help"),
                 htmlOutput("dataRareHelp"),
                 size = "l",
                 easyClose = T
             ))
)
#### Diversity estimation ####

output$divcolor <- renderUI({
  selectColorGroup("divcolor", dataFilt())
})

output$divfacet <- renderUI({
  selectFacetGroup("divfacet", dataFilt())
})

output$plotDiv <- renderPlot({
    validate(need(!(is.null(input$divIndex) || input$divIndex == ""), "select an index"))
    validate(need(!(is.null(input$divLevel) || input$divLevel == ""), "select a level"))
    validate(need(!(is.null(input$divcolor) || input$divcolor == ""), "select a group for colors"))
    
    plotDiversity(x=dataFilt(), index = input$divIndex, level = input$divLevel, colorBy=input$divcolor, facetBy=input$divfacet, label_colors = NULL)
})

output$downPlotDiv <- renderUI({
    if (!is.null(input$plotRare) & !is.null(input$divLevel)) {
        downloadButton("PlotDiv", "Download PDF", style="background-color:white; border-color: #022F5A;")
    }
}) 

output$PlotDiv <- downloadHandler(
    filename =  function() {
        paste0("diversityPlot_", input$divIndex, "_", input$divLevel, ".pdf")
    },
    # content is a function with argument file. content writes the plot to the device
    content = function(file) {
        pdf(file, height=4, width=6)
        grid.draw(plotDiversity(x=dataFilt(), index = input$divIndex, level = input$divLevel, colorBy=input$divcolor, facetBy=input$divfacet, label_colors = NULL)
)
        dev.off()
    }
)

output$basicDivHelp <- renderText({
    createHelp(?plotDiversity)
})

observeEvent(input$basicdivHelp,
             showModal(modalDialog(
                 title = paste("Help"),
                 htmlOutput("basicDivHelp"),
                 size = "l",
                 easyClose = T
             ))
)

output$dataDiv <- renderDataTable({
    validate(need(!(is.null(input$divLevel) || input$divLevel == ""), "select a level"))
    diversityIndices(x=dataFilt(), level = input$divLevel)
})
output$downloaddataDiv <- downloadHandler(
    "RepSeq_diversityIndices.csv",
    content = function(file) {
        write.table(diversityIndices(x=dataFilt(), level = input$divLevel), file, row.names = F, sep = '\t')
    }, contentType = "text/csv"
) 

output$divTabHelp <- renderText({
    createHelp(?diversityIndices)
})

observeEvent(input$divtabHelp,
             showModal(modalDialog(
                 title = paste("Help"),
                 htmlOutput("divTabHelp"),
                 size = "l",
                 easyClose = T
             ))
)

output$renyicolor <- renderUI({
  selectColorGroup("renyicolor", dataFilt())
})

output$renyifacet <- renderUI({
  selectFacetGroup("renyifacet", dataFilt())
})

# output$renyishape <- renderUI({
#   selectShapeGroup("renyishape", dataFilt())
# })

output$plotRenyi <- plotly::renderPlotly({
    validate(need(!(is.null(input$renyiLevel) || input$renyiLevel == ""), "select a level"))
    validate(need(!(is.null(input$renyicolor) || input$renyicolor == ""), "select a level"))
    
    plotly::ggplotly(plotRenyiIndex(x=dataFilt(), level = input$renyiLevel, colorBy = input$renyicolor, facetBy=input$renyifacet ,grouped = FALSE, label_colors = NULL))
})
output$downPlotRenyi2 <- renderUI({
    if (!is.null(input$renyiLevel)) {
        downloadButton("PlotRenyi2", "Download PDF", style="background-color:white; border-color: #022F5A;")
    }
}) 

output$PlotRenyi2 <- downloadHandler(
    filename =  function() {
        paste0("RenyiPlot_", input$renyiLevel, ".pdf")
    },
    # content is a function with argument file. content writes the plot to the device
    content = function(file) {
        pdf(file, height=4, width=6)
        grid.draw(plotRenyiIndex(x=dataFilt(), level = input$renyiLevel, colorBy = input$renyicolor, facetBy=input$renyifacet , grouped = FALSE, label_colors = NULL))
        dev.off()
    }
)

output$basicRenyiHelp <- renderText({
    createHelp(?plotRenyiIndex)
})

observeEvent(input$basicrenHelp,
             showModal(modalDialog(
                 title = paste("Help"),
                 htmlOutput("basicRenyiHelp"),
                 size = "l",
                 easyClose = T
             ))
)

output$dataRenyi <- renderDataTable({
    validate(need(!(is.null(input$renyiLevel) || input$renyiLevel == ""), "select a level"))
    renyiIndex(x=dataFilt(), level = input$renyiLevel)
})
output$downloaddataRenyi <- downloadHandler(
    "RepSeq_renyiIndex.csv",
    content = function(file) {
        write.table(renyiIndex(x=dataFilt(), level = input$renyiLevel), file, row.names = F, sep = '\t')
    }, contentType = "text/csv"
) 

output$renyiTabHelp <- renderText({
    createHelp(?renyiIndex)
})

observeEvent(input$rentabHelp,
             showModal(modalDialog(
                 title = paste("Help"),
                 htmlOutput("renyiTabHelp"),
                 size = "l",
                 easyClose = T
             ))
)


output$countIntfacet <- renderUI({
  selectFacetGroup("countIntfacet", dataFilt())
})

output$CountIntervals <- renderPlot({
    validate(need(!(is.null(input$countIntLevel) || input$countIntLevel == ""), "select a level"))
    validate(need(!(is.null(input$countIntGroupMeth) || input$countIntGroupMeth == ""), "select a statistics scale"))

    plotIntervals(x=dataFilt(), level = input$countIntLevel, grouped = F,colorBy=NULL, facetBy= input$countIntfacet,
                       fractions=input$countIntGroupMeth, label_colors = NULL)
})

output$downPlotCountIntervals2 <- renderUI({
    if (!is.null(input$countIntLevel)) {
        downloadButton("PlotCountIntervals2", "Download PDF", style="background-color:white; border-color: #022F5A;")
    }
}) 

output$PlotCountIntervals2 <- downloadHandler(
    filename =  function() {
        paste0("CountIntervals_", input$countIntLevel, ".pdf")
    },
    # content is a function with argument file. content writes the plot to the device
    content = function(file) {
        pdf(file, height=4, width=6)
        grid.draw(plotIntervals(x=dataFilt(), level = input$countIntLevel, grouped = F,colorBy=NULL, facetBy= input$countIntfacet,
                                fractions=input$countIntGroupMeth, label_colors = NULL))
        dev.off()
    }
)

output$basicCountIntHelp <- renderText({
    createHelp(?plotIntervals)
})

observeEvent(input$basiccountintHelp,
             showModal(modalDialog(
                 title = paste("Help"),
                 htmlOutput("basicCountIntHelp"),
                 size = "l",
                 easyClose = T
             ))
)

# plot rank distribution

output$rankDistribcolor <- renderUI({
  selectColorGroup("rankDistribcolor", dataFilt())
})

output$rankDistribfacet <- renderUI({
  selectFacetGroup("rankDistribfacet", dataFilt())
})


output$rankDistrib <- renderPlot({
    validate(need(!(is.null(input$rankDistribGroupMeth) || input$rankDistribGroupMeth == ""), "select a scale"))
    validate(need(!(is.null(input$rankDistribLevel) || input$rankDistribLevel == ""), "select a level"))
    validate(need(!(is.null(input$rankDistribcolor) || input$rankDistribcolor == ""), "select a group for colors"))

    plotRankDistrib(x = dataFilt(), level = input$rankDistribLevel, scale = input$rankDistribGroupMeth, ranks=input$rankDistribSize ,colorBy =input$rankDistribcolor, facetBy=input$rankDistribfacet, grouped = FALSE, label_colors = NULL)
})

output$downPlotrankDistrib <- renderUI({
    if (!is.null(input$rankDistribLevel) & !is.null(input$rankDistribGroupMeth)) {
        downloadButton("PlotrankDistrib", "Download PDF", style="background-color:white; border-color: #022F5A; margin-bottom: 14px;")
    }
}) 

output$PlotrankDistrib <- downloadHandler(
    filename =  function() {
        paste0("rankDistrib_", input$rankDistribLevel, "_", input$rankDistribGroupMeth,"_", input$rankDistribSize, ".pdf")
    },
    content = function(file) {
        pdf(file, height=4, width=6)
        grid.draw(plotRankDistrib(x = dataFilt(), level = input$rankDistribLevel, scale = input$rankDistribGroupMeth, ranks=input$rankDistribSize, colorBy =input$rankDistribcolor, facetBy=input$rankDistribfacet, grouped = FALSE, label_colors = NULL)
)
        dev.off()
    }
)


output$rankDistribHelp <- renderText({
    createHelp(?plotRankDistrib)
})

observeEvent(input$rankdistribHelp,
             showModal(modalDialog(
                 title = paste("Help"),
                 htmlOutput("rankDistribHelp"),
                 size = "l",
                 easyClose = T
             ))
)


