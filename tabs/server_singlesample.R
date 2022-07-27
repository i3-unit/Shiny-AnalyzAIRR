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
        downloadButton("PlotIndCountIntervals", "Download PNG")
    }
}) 

output$PlotIndCountIntervals <- downloadHandler(
    filename =  function() {
        paste0("individualCountsIntervals_", input$singleSample, "_", input$indLevel, ".png")
    },
    # content is a function with argument file. content writes the plot to the device
    content = function(file) {
        png(file, height=2400, width=4800, res=300)
        grid.newpage()
        grid.draw(plotIndCountIntervals(x = dataFilt(), sampleName = input$singleSample, level = input$indLevel))
        dev.off()
    }
)


# plot V and J gene usages
output$geneUsage <- renderPlot({
    sampleError(input$singleSample)
    validate(need(!(is.null(input$singleScale) ||  input$singleScale == ""), "Choose a scale"))
    validate(need(!(is.null(input$geneUsageLevel) ||  input$geneUsageLevel == ""), "Select a level"))
    plotGeneUsage(x = dataFilt(), sampleName = input$singleSample, level = input$geneUsageLevel, scale = input$singleScale)
})
output$downPlotgeneUsage <- renderUI({
    if (!is.null(input$singleSample) & !(is.null(input$geneUsageLevel)) & !(is.null(input$singleScale))) {
        downloadButton("PlotgeneUsage", "Download PNG")
    }
}) 

output$PlotgeneUsage <- downloadHandler(
    filename =  function() {
        paste0("geneUsage_", input$singleSample, "_", input$geneUsageLevel, "_", input$singleScale, ".png")
    },
    # content is a function with argument file. content writes the plot to the device
    content = function(file) {
        png(file, height=2400, width=4800, res=300)
        grid.newpage()
        grid.draw(plotGeneUsage(x = dataFilt(), sampleName = input$singleSample, level = input$geneUsageLevel, scale = input$singleScale))
        dev.off()
    }
)

# plot V and J gene usages
output$VJUsage <- renderPlot({
    sampleError(input$singleSample)
    validate(need(!(is.null(input$singleScale) ||  input$singleScale == ""), "Choose a scale"))
    validate(need(!(is.null(input$VJLevel) ||  input$VJLevel == ""), "Select a level"))
    validate(need(!(is.null(input$VJProp) ||  input$VJProp == ""), "Select a level"))
    plotVJusage(x = dataFilt(), sampleName = input$singleSample, scale = input$singleScale, level = input$VJLevel, prop = input$VJProp)
})

output$downPlotVJUsage <- renderUI({
    if (!is.null(input$singleSample) & !(is.null(input$singleScale)) & !(is.null(input$VJLevel)) & !(is.null(input$VJProp))) {
        downloadButton("PlotVJUsage", "Download PNG")
    }
}) 

output$PlotVJUsage <- downloadHandler(
    filename =  function() {
        paste0("VJusage_", input$singleSample, "_", input$singleScale, "_", input$VJLevel, "_", input$VJProp, ".png")
    },
    # content is a function with argument file. content writes the plot to the device
    content = function(file) {
        png(file, height=2400, width=4800, res=300)
        grid.newpage()
        grid.draw(plotVJusage(x = dataFilt(), sampleName = input$singleSample, scale = input$singleScale, level = input$VJLevel, prop = input$VJProp))
        dev.off()
    }
)

##### Plot stacked spectratype #####

#render UI download button for individual spectratype
output$downSpectra <- renderUI({
    if (!is.null(input$singleSample) & !(is.null(input$singleScale)) & !is.null(input$spectraProp)) {
        downloadButton("Spectra", "Download PNG")
    }
}) 
# plot overlay spectratype 
output$spectraPlot <- renderPlot({
    sampleError(input$singleSample)
    validate(need(!(is.null(input$singleScale) || input$singleScale == ""), "Choose a scale"))
    validate(need(!(is.null(input$singleProp) || input$singleProp == ""), "Choose a proportion"))    
    plotSpectratyping(x = dataFilt(), sampleName = input$singleSample, scale = input$singleScale, prop = input$singleProp)
})
# download button for individual spectratype
output$Spectra <- downloadHandler(
    filename =  function() {
        paste0("stacked_spectratype_", input$singleSample, "_", input$singleScale, "_", input$singleProp, ".png")
    },
    # content is a function with argument file. content writes the plot to the device
    content = function(file) {
        png(file, height=2400, width=4800, res=300)
        grid.newpage()
        grid.draw(plotSpectratyping(x = dataFilt(), sampleName = input$singleSample, scale = input$singleScale, prop = input$singleProp))
        dev.off()
    }
)
##### Plot individual spectratype #####

#render UI download button for individual spectratype
output$downSpectrabis <- renderUI({
    if (!is.null(input$singleSample) & !(is.null(input$singleScale)) & !is.null(input$spectraProp)) {
        downloadButton("Spectrabis", "Download PNG")
    }
}) 
# render plot individual spectratype
output$spectraPlotbis <- renderPlot({
    sampleError(input$singleSample)
    validate(need(!(is.null(input$singleScale) || input$singleScale == ""), "Choose a scale"))
    validate(need(!(is.null(input$spectraProp) || input$spectraProp == ""), "Choose a proportion"))
    plotSpectratypingV(x = dataFilt(), sampleName = input$singleSample, scale = input$singleScale, prop = input$spectraProp)
    },  width="auto", 
        height <- function() {
            if (is.null(input$singleSample) || input$singleSample == "") return(600)
            else { 
                nrowsGrid <- ceiling(length(RepSeq::assay(dataFilt())[sample_id == input$singleSample, unique(V)])/4)
                return(150 * nrowsGrid)
            }
        }
)
# download button for individual spectratype
output$Spectrabis <- downloadHandler(
    filename =  function() {
        paste0("individual_spectratypeV_", input$singleSample, "_", input$singleScale, "_", input$spectraProp, ".png")
    },
    # content is a function with argument file. content writes the plot to the device
    content = function(file) {
        png(file, height=4800, width=2400, res=300)
        grid.newpage()
        grid.draw(plotSpectratypingV(x = dataFilt(), sampleName = input$singleSample, scale = input$singleScale, prop = input$spectraProp))
        dev.off()  
    }
)

    
