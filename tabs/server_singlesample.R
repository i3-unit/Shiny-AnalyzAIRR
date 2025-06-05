#-------------------------------------------------------------------------------------------------------------------------------------------#
#  single sample section
#-------------------------------------------------------------------------------------------------------------------------------------------#

# plot Ind Basic statistics
observeEvent(input$doIndStatistics, {
output$IndStatistics <- renderPlot({
  sampleError(input$singleSample)
  plotIndStatistics(x = dataFilt(), sampleName = input$singleSample, stat="metadata")
})
})

output$downPlotIndStatistics <- renderUI({
  if (!is.null(input$singleSample))  {
    downloadButton("PlotIndStatistics1", "Download PDF", style="background-color:white; border-color: #022F5A;")
  }
}) 


output$PlotIndStatistics1 <- downloadHandler(
  filename =  function() {
    paste0("individualStatistics_", input$singleSample,".pdf")
  },
  # content is a function with argument file. content writes the plot to the device
  content = function(file) {
    pdf(file, height=4, width=7)
    grid.draw( plotIndStatistics(x = dataFilt(), sampleName = input$singleSample, stat="metadata"))
    dev.off()
  }
)

output$IndStatisticsHelp <- renderText({
  createHelp(?plotIndStatistics)
})

observeEvent(input$indstatisticsHelp,
             showModal(modalDialog(
               title = paste("Help"),
               htmlOutput("IndStatisticsHelp"),
               size = "l",
               easyClose = T
             ))
)


# plot diversity statistics
output$IndDiversity <- renderPlot({
  sampleError(input$singleSample)
  validate(need(!(is.null(input$indLevel) ||  input$indLevel == ""), "Select a level"))
  plotIndStatistics(x = dataFilt(), sampleName = input$singleSample, stat="diversity", level = input$indLevel)
})

output$downPlotIndDiversity <- renderUI({
  if (!is.null(input$singleSample) & !(is.null(input$indLevel))) {
    downloadButton("PlotIndStatistics2", "Download PDF", style="background-color:white; border-color: #022F5A;")
  }
}) 


output$PlotIndStatistics2 <- downloadHandler(
  filename =  function() {
    paste0("individualDiversity_", input$singleSample, "_", input$indLevel, ".pdf")
  },
  # content is a function with argument file. content writes the plot to the device
  content = function(file) {
    pdf(file, height=3, width=6.5)
    grid.draw( plotIndStatistics(x = dataFilt(), sampleName = input$singleSample, stat="diversity", level = input$indLevel))
    dev.off()
  }
)

output$IndDiversityHelp <- renderText({
  createHelp(?plotIndStatistics)
})

observeEvent(input$inddiversityHelp,
             showModal(modalDialog(
               title = paste("Help"),
               htmlOutput("IndDiversityHelp"),
               size = "l",
               easyClose = T
             ))
)

# plot treemap
output$TreeMap <- renderPlot({
  sampleError(input$singleSample)
  validate(need(!(is.null(input$indTreeLevel) ||  input$indTreeLevel == ""), "Select a level"))
  validate(need(!(is.null(input$indProp) ||  input$indProp == ""), "Select a proportion"))
  plotIndMap(x = dataFilt(), sampleName = input$singleSample, level = input$indTreeLevel, prop = input$indProp)
})


output$downPlotIndMap <- renderUI({
  if (!is.null(input$singleSample) & !(is.null(input$indTreeLevel)) & !(is.null(input$indProp))) {
    downloadButton("PlotIndMap", "Download PDF", style="background-color:white; border-color: #022F5A;")
  }
}) 

output$PlotIndMap <- downloadHandler(
  filename =  function() {
    paste0("individualTreeMap_", input$singleSample, "_", input$indTreeLevel,  "_", input$indProp ,".pdf")
  },
  # content is a function with argument file. content writes the plot to the device
  content = function(file) {
    pdf(file, height=4, width=5)
    grid.draw(plotIndMap(x = dataFilt(), sampleName = input$singleSample, level = input$indTreeLevel, prop = input$indProp)
)
    dev.off()
  }
)

output$IndMapHelp <- renderText({
  createHelp(?plotIndMap)
})

observeEvent(input$indtreemapHelp,
             showModal(modalDialog(
               title = paste("Help"),
               htmlOutput("IndMapHelp"),
               size = "l",
               easyClose = T
             ))
)


# plot Ind Count Intervals
output$IndCountIntervals <- renderPlot({
    sampleError(input$singleSample)
    validate(need(!(is.null(input$indIntLevel) ||  input$indIntLevel == ""), "Select a level"))
    validate(need(!(is.null(input$indMeth) || input$indMeth == ""), "select a scale for fractions"))

    plotIndIntervals(x = dataFilt(), sampleName = input$singleSample, level = input$indIntLevel, interval_scale=input$indMeth)
})

output$downPlotIndCountIntervals <- renderUI({
    if (!is.null(input$singleSample) & !(is.null(input$indIntLevel)) & !(is.null(input$indMeth))) {
        downloadButton("PlotIndCountIntervals", "Download PDF", style="background-color:white; border-color: #022F5A;")
    }
}) 

output$PlotIndCountIntervals <- downloadHandler(
    filename =  function() {
        paste0("individualCountsIntervals_", input$singleSample, "_", input$indIntLevel,"_", input$indMeth, ".pdf")
    },
    # content is a function with argument file. content writes the plot to the device
    content = function(file) {
        pdf(file, height=3, width=5)
        grid.draw(plotIndIntervals(x = dataFilt(), sampleName = input$singleSample, level = input$indIntLevel, interval_scale=input$indMeth))
        dev.off()
    }
)

output$IndCountIntHelp <- renderText({
    createHelp(?plotIndIntervals)
})

observeEvent(input$indcountintHelp,
             showModal(modalDialog(
                 title = paste("Help"),
                 htmlOutput("IndCountIntHelp"),
                 size = "l",
                 easyClose = T
             ))
)

# plot V and J gene usages
  observeEvent(input$indgeneUsageLevel, {
    sampleError(input$singleSample)
    # validate(need(!(is.null(input$indgeneUsageLevel) ||  input$indgeneUsageLevel == ""), "select a level"))
    pdf(file = NULL)
    hm <- plotIndGeneUsage(x = dataFilt(), sampleName = input$singleSample, level = input$indgeneUsageLevel)
    ht2<- ComplexHeatmap::draw(hm)
    makeInteractiveComplexHeatmap(input, output, session, ht2, "ht2") 
})

output$downPlotIndGeneUsage <- renderUI({
    if (!is.null(input$singleSample) & !(is.null(input$indgeneUsageLevel))) {
        downloadButton("PlotIndGeneUsage", "Download PDF", style="background-color:white; border-color: #022F5A;")
    }
}) 

output$PlotIndGeneUsage <- downloadHandler(
    filename =  function() {
        paste0("IndGeneUsage_", input$singleSample, "_", input$indgeneUsageLevel, ".pdf")
    },
    # content is a function with argument file. content writes the plot to the device
    content = function(file) {
        pdf(file, height=4, width=8)
        draw(plotIndGeneUsage(x = dataFilt(), sampleName = input$singleSample, level = input$indgeneUsageLevel))
        dev.off()
    }
)

output$indgeneUsageHelp <- renderText({
    createHelp(?plotIndGeneUsage)
})

observeEvent(input$indgeneusageHelp,
             showModal(modalDialog(
                 title = paste("Help"),
                 htmlOutput("indgeneUsageHelp"),
                 size = "l",
                 easyClose = T
             ))
)


# # plot V and J gene usages
# output$VJUsage <- renderPlot({
#     sampleError(input$singleSample)
#     validate(need(!(is.null(input$singleScale) ||  input$singleScale == ""), "Select a scale"))
#     validate(need(!(is.null(input$VJLevel) ||  input$VJLevel == ""), "Select a level"))
#     validate(need(!(is.null(input$VJProp) ||  input$VJProp == ""), "Select a proportion"))
#     validate(need(!(is.null(input$VJViz) ||  input$VJViz == ""), "Select a visualization"))
#     if(input$VJViz == "Heatmap"){
#         hm2 <- plotVJusage(x = dataFilt(), sampleName = input$singleSample, scale = input$singleScale, level = input$VJLevel, prop = input$VJProp, plot = "Heatmap")
#         hm2@column_names_param$gp$fontsize <- 10
#         hm2@row_names_param$gp$fontsize <- 10
#         ComplexHeatmap::draw(hm2)
#     } else {
#         plotVJusage(x = dataFilt(), sampleName = input$singleSample, scale = input$singleScale, level = input$VJLevel, prop = input$VJProp, plot = "Circos")    
#     }
#     
# })
# 
# output$downPlotVJUsage <- renderUI({
#     if (!is.null(input$singleSample) & !(is.null(input$singleScale)) & !(is.null(input$VJLevel)) & !(is.null(input$VJProp))) {
#         downloadButton("PlotVJUsage", "Download PDF", style="background-color:white; border-color: #022F5A;")
#     }
# }) 
# 
# output$PlotVJUsage <- downloadHandler(
#     filename =  function() {
#         paste0("VJusage_", input$VJViz, "_", input$singleSample, "_", input$singleScale, "_", input$VJLevel, "_", input$VJProp, ".pdf")
#     },
#     # content is a function with argument file. content writes the plot to the device
#     content = function(file) {
#         pdf(file, height=4, width=6)
#         if(input$VJViz == "Heatmap"){
#             hm2 <- plotVJusage(x = dataFilt(), sampleName = input$singleSample, scale = input$singleScale, level = input$VJLevel, prop = input$VJProp, plot = "Heatmap")
#             ComplexHeatmap::draw(hm2)
#         } else {
#             grid.draw(plotVJusage(x = dataFilt(), sampleName = input$singleSample, scale = input$singleScale, level = input$VJLevel, prop = input$VJProp, plot = "Circos"))
#         }
#         dev.off()
#     }
# )
# 
# output$VJUsageHelp <- renderText({
#     createHelp(?plotVJusage)
# })
# 
# observeEvent(input$vjusageHelp,
#              showModal(modalDialog(
#                  title = paste("Help"),
#                  htmlOutput("VJUsageHelp"),
#                  size = "l",
#                  easyClose = T
#              ))
# )

##### Plot stacked spectratype #####

#render UI download button for individual spectratype
# output$downSpectra <- renderUI({
#     if (!is.null(input$singleSample) & !(is.null(input$singleScale)) & !is.null(input$spectraProp)) {
#         downloadButton("Spectra", "Download PDF", style="background-color:white; border-color: #022F5A;")
#     }
# }) 
# plot overlay spectratype 
# output$spectraPlot <- plotly::renderPlotly({
#     sampleError(input$singleSample)
#     validate(need(!(is.null(input$singleScale) || input$singleScale == ""), "select a scale"))
#     validate(need(!(is.null(input$spectraProp) || input$spectraProp == ""), "select a proportion"))    
#     plotly::ggplotly(plotSpectratyping(x = dataFilt(), sampleName = input$singleSample, scale = input$singleScale, prop = input$spectraProp)+
#                        ggplot2::theme(legend.position = "none"))
# })
# 
# # download button for individual spectratype
# output$Spectra <- downloadHandler(
#     filename =  function() {
#         paste0("stacked_spectratype_", input$singleSample, "_", input$singleScale, "_", input$spectraProp, ".pdf")
#     },
#     # content is a function with argument file. content writes the plot to the device
#     content = function(file) {
#         pdf(file, height=4, width=6)
#         grid.draw(plotSpectratyping(x = dataFilt(), sampleName = input$singleSample, scale = input$singleScale, prop = input$spectraProp))
#         dev.off()
#     }
# )
# 
# output$spectraHelp <- renderText({
#     createHelp(?plotSpectratyping)
# })

# observeEvent(input$spectHelp,
#              showModal(modalDialog(
#                  title = paste("Help"),
#                  htmlOutput("spectraHelp"),
#                  size = "l",
#                  easyClose = T
#              ))
# )

##### Plot individual spectratype #####

# #render UI download button for individual spectratype
# output$downSpectrabis <- renderUI({
#     if (!is.null(input$singleSample) & !(is.null(input$singleScale)) & !is.null(input$spectraProp)) {
#         downloadButton("Spectrabis", "Download PDF", style="background-color:white; border-color: #022F5A;")
#     }
# }) 
# # render plot individual spectratype
# observeEvent(input$doSpectrabis, {
# output$spectraPlotbis <- renderPlot({
#     sampleError(input$singleSample)
#     validate(need(!(is.null(input$singleScale) || input$singleScale == ""), "select a scale"))
#     validate(need(!(is.null(input$spectraProp) || input$spectraProp == ""), "select a proportion"))
#     plotSpectratypingV(x = dataFilt(), sampleName = input$singleSample, scale = input$singleScale, prop = input$spectraProp)
#     },  width="auto", 
#         height <- function() {
#             if (is.null(input$singleSample) || input$singleSample == "") return(600)
#             else { 
#                 nrowsGrid <- ceiling(length(AnalyzAIRR::assay(dataFilt())[sample_id == input$singleSample, unique(V)])/4)
#                 return(150 * nrowsGrid) }
#         })
# })
# # download button for individual spectratype
# output$Spectrabis <- downloadHandler(
#     filename =  function() {
#         paste0("individual_spectratypeV_", input$singleSample, "_", input$singleScale, "_", input$spectraProp, ".pdf")
#     },
#     # content is a function with argument file. content writes the plot to the device
#     content = function(file) {
#         pdf(file, height=4, width=6)
#         grid.draw(plotSpectratypingV(x = dataFilt(), sampleName = input$singleSample, scale = input$singleScale, prop = input$spectraProp))
#         dev.off()  
#     }
# )
# 
# output$SpectrabisHelp <- renderText({
#     createHelp(?plotSpectratypingV)
# })

# observeEvent(input$spectbisHelp,
#              showModal(modalDialog(
#                  title = paste("Help"),
#                  htmlOutput("SpectrabisHelp"),
#                  size = "l",
#                  easyClose = T
#              ))
# )   
