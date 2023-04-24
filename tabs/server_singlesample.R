#-------------------------------------------------------------------------------------------------------------------------------------------#
#  single sample section
#-------------------------------------------------------------------------------------------------------------------------------------------#

# plot Ind Count Intervals
output$IndCountIntervals <- renderPlot({
    sampleError(input$singleSample)
    validate(need(!(is.null(input$indLevel) ||  input$indLevel == ""), "Select a level"))
    plotIndCountIntervals(x = dataFilt(), sampleName = input$singleSample, level = input$indLevel)
})

output$downPlotIndCountIntervals <- renderUI({
    if (!is.null(input$singleSample) & !(is.null(input$indLevel))) {
        downloadButton("PlotIndCountIntervals", "Download PDF", style="background-color:white; border-color: #022F5A;")
    }
}) 

output$PlotIndCountIntervals <- downloadHandler(
    filename =  function() {
        paste0("individualCountsIntervals_", input$singleSample, "_", input$indLevel, ".pdf")
    },
    # content is a function with argument file. content writes the plot to the device
    content = function(file) {
        pdf(file, height=4, width=6)
        grid.draw(plotIndCountIntervals(x = dataFilt(), sampleName = input$singleSample, level = input$indLevel))
        dev.off()
    }
)

output$IndCountIntHelp <- renderText({
    createHelp(?plotIndCountIntervals)
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
output$indgeneUsage <- plotly::renderPlotly({
    sampleError(input$singleSample)
    validate(need(!(is.null(input$singleScale) ||  input$singleScale == ""), "select a scale"))
    validate(need(!(is.null(input$indgeneUsageLevel) ||  input$indgeneUsageLevel == ""), "select a level"))
    plotly::ggplotly(plotIndGeneUsage(x = dataFilt(), sampleName = input$singleSample, level = input$indgeneUsageLevel, scale = input$singleScale)+
                       ggplot2::theme(legend.position = "none"), 
                     tooltip = c("x", "y"))
})
output$downPlotIndgeneUsage <- renderUI({
    if (!is.null(input$singleSample) & !(is.null(input$indgeneUsageLevel)) & !(is.null(input$singleScale))) {
        downloadButton("PlotIndgeneUsage", "Download PDF", style="background-color:white; border-color: #022F5A;")
    }
}) 

output$PlotIndgeneUsage <- downloadHandler(
    filename =  function() {
        paste0("IndGeneUsage_", input$singleSample, "_", input$indgeneUsageLevel, "_", input$singleScale, ".pdf")
    },
    # content is a function with argument file. content writes the plot to the device
    content = function(file) {
        pdf(file, height=3.5, width=7)
        grid.draw(plotIndGeneUsage(x = dataFilt(), sampleName = input$singleSample, level = input$indgeneUsageLevel, scale = input$singleScale))
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

# plot V and J gene usages
output$VJUsage <- renderPlot({
    sampleError(input$singleSample)
    validate(need(!(is.null(input$singleScale) ||  input$singleScale == ""), "Select a scale"))
    validate(need(!(is.null(input$VJLevel) ||  input$VJLevel == ""), "Select a level"))
    validate(need(!(is.null(input$VJProp) ||  input$VJProp == ""), "Select a proportion"))
    validate(need(!(is.null(input$VJViz) ||  input$VJViz == ""), "Select a visualization"))
    if(input$VJViz == "Heatmap"){
        hm2 <- plotVJusage(x = dataFilt(), sampleName = input$singleSample, scale = input$singleScale, level = input$VJLevel, prop = input$VJProp, plot = "Heatmap")
        hm2@column_names_param$gp$fontsize <- 10
        hm2@row_names_param$gp$fontsize <- 10
        ComplexHeatmap::draw(hm2)
    } else {
        plotVJusage(x = dataFilt(), sampleName = input$singleSample, scale = input$singleScale, level = input$VJLevel, prop = input$VJProp, plot = "Circos")    
    }
    
})

output$downPlotVJUsage <- renderUI({
    if (!is.null(input$singleSample) & !(is.null(input$singleScale)) & !(is.null(input$VJLevel)) & !(is.null(input$VJProp))) {
        downloadButton("PlotVJUsage", "Download PDF", style="background-color:white; border-color: #022F5A;")
    }
}) 

output$PlotVJUsage <- downloadHandler(
    filename =  function() {
        paste0("VJusage_", input$VJViz, "_", input$singleSample, "_", input$singleScale, "_", input$VJLevel, "_", input$VJProp, ".pdf")
    },
    # content is a function with argument file. content writes the plot to the device
    content = function(file) {
        pdf(file, height=4, width=6)
        if(input$VJViz == "Heatmap"){
            hm2 <- plotVJusage(x = dataFilt(), sampleName = input$singleSample, scale = input$singleScale, level = input$VJLevel, prop = input$VJProp, plot = "Heatmap")
            ComplexHeatmap::draw(hm2)
        } else {
            grid.draw(plotVJusage(x = dataFilt(), sampleName = input$singleSample, scale = input$singleScale, level = input$VJLevel, prop = input$VJProp, plot = "Circos"))
        }
        dev.off()
    }
)

output$VJUsageHelp <- renderText({
    createHelp(?plotVJusage)
})

observeEvent(input$vjusageHelp,
             showModal(modalDialog(
                 title = paste("Help"),
                 htmlOutput("VJUsageHelp"),
                 size = "l",
                 easyClose = T
             ))
)

##### Plot stacked spectratype #####

#render UI download button for individual spectratype
output$downSpectra <- renderUI({
    if (!is.null(input$singleSample) & !(is.null(input$singleScale)) & !is.null(input$spectraProp)) {
        downloadButton("Spectra", "Download PDF", style="background-color:white; border-color: #022F5A;")
    }
}) 
# plot overlay spectratype 
output$spectraPlot <- plotly::renderPlotly({
    sampleError(input$singleSample)
    validate(need(!(is.null(input$singleScale) || input$singleScale == ""), "select a scale"))
    validate(need(!(is.null(input$singleProp) || input$singleProp == ""), "select a proportion"))    
    plotly::ggplotly(plotSpectratyping(x = dataFilt(), sampleName = input$singleSample, scale = input$singleScale, prop = input$singleProp)+
                       ggplot2::theme(legend.position = "none"))
})
# download button for individual spectratype
output$Spectra <- downloadHandler(
    filename =  function() {
        paste0("stacked_spectratype_", input$singleSample, "_", input$singleScale, "_", input$singleProp, ".pdf")
    },
    # content is a function with argument file. content writes the plot to the device
    content = function(file) {
        pdf(file, height=4, width=6)
        grid.draw(plotSpectratyping(x = dataFilt(), sampleName = input$singleSample, scale = input$singleScale, prop = input$singleProp))
        dev.off()
    }
)

output$spectraHelp <- renderText({
    createHelp(?plotSpectratyping)
})

observeEvent(input$spectHelp,
             showModal(modalDialog(
                 title = paste("Help"),
                 htmlOutput("spectraHelp"),
                 size = "l",
                 easyClose = T
             ))
)

##### Plot individual spectratype #####

#render UI download button for individual spectratype
output$downSpectrabis <- renderUI({
    if (!is.null(input$singleSample) & !(is.null(input$singleScale)) & !is.null(input$spectraProp)) {
        downloadButton("Spectrabis", "Download PDF", style="background-color:white; border-color: #022F5A;")
    }
}) 
# render plot individual spectratype
output$spectraPlotbis <- renderPlot({
    sampleError(input$singleSample)
    validate(need(!(is.null(input$singleScale) || input$singleScale == ""), "select a scale"))
    validate(need(!(is.null(input$spectraProp) || input$spectraProp == ""), "select a proportion"))
    plotSpectratypingV(x = dataFilt(), sampleName = input$singleSample, scale = input$singleScale, prop = input$spectraProp)
    },  width="auto", 
        height <- function() {
            if (is.null(input$singleSample) || input$singleSample == "") return(600)
            else { 
                nrowsGrid <- ceiling(length(AnalyzAIRR::assay(dataFilt())[sample_id == input$singleSample, unique(V)])/4)
                return(150 * nrowsGrid)
            }
        }
)
# download button for individual spectratype
output$Spectrabis <- downloadHandler(
    filename =  function() {
        paste0("individual_spectratypeV_", input$singleSample, "_", input$singleScale, "_", input$spectraProp, ".pdf")
    },
    # content is a function with argument file. content writes the plot to the device
    content = function(file) {
        pdf(file, height=4, width=6)
        grid.draw(plotSpectratypingV(x = dataFilt(), sampleName = input$singleSample, scale = input$singleScale, prop = input$spectraProp))
        dev.off()  
    }
)

output$SpectrabisHelp <- renderText({
    createHelp(?plotSpectratypingV)
})

observeEvent(input$spectbisHelp,
             showModal(modalDialog(
                 title = paste("Help"),
                 htmlOutput("SpectrabisHelp"),
                 size = "l",
                 easyClose = T
             ))
)   
