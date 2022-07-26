#-------------------------------------------------------------------------------------------------------------------------------------------#
#  single sample section
#-------------------------------------------------------------------------------------------------------------------------------------------#

# plot Ind Count Intervals
output$IndCountIntervals <- renderPlot({
    sampleError(input$singleSample)
    validate(need(!(is.null(input$indLevel) ||  input$indLevel == ""), "Select a level"))
    plotIndCountIntervals(x = dataFilt(), sampleName = input$singleSample, level = input$indLevel)
})


# plot V and J gene usages
output$geneUsage <- renderPlot({
    sampleError(input$singleSample)
    validate(need(!(is.null(input$singleScale) ||  input$singleScale == ""), "Choose a scale"))
    validate(need(!(is.null(input$geneUsageLevel) ||  input$geneUsageLevel == ""), "Select a level"))
    plotGeneUsage(x = dataFilt(), sampleName = input$singleSample, level = input$geneUsageLevel, scale = input$singleScale)
})

# plot V and J gene usages
output$VJUsage <- renderPlot({
    sampleError(input$singleSample)
    validate(need(!(is.null(input$singleScale) ||  input$singleScale == ""), "Choose a scale"))
    validate(need(!(is.null(input$VJLevel) ||  input$VJLevel == ""), "Select a level"))
    validate(need(!(is.null(input$VJProp) ||  input$VJProp == ""), "Select a level"))
    plotVJusage(x = dataFilt(), sampleName = input$singleSample, scale = input$singleScale, level = input$VJLevel, prop = input$VJProp)
})

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

    
