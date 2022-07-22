#-------------------------------------------------------------------------------------------------------------------------------------------#
#  single sample section
#-------------------------------------------------------------------------------------------------------------------------------------------#
# plot proportion V
output$propV <- renderPlot({
    sampleError(input$singleSample)
    validate(need(!(is.null(input$singleScale) ||  input$singleScale == ""), "Choose a scale"))
    plotPropVJ(RepSeqDT(), "V", input$singleSample, input$singleScale)
}, height = 500)
# plot proportion J
output$propJ <- renderPlot({
    sampleError(input$singleSample)
    validate(need(!(is.null(input$singleScale) ||  input$singleScale == ""), "Choose a scale"))
    plotPropVJ(RepSeqDT(), "J", input$singleSample, input$singleScale)
}, height = 500)
# plot proportion VJ
output$freqVpJ <- renderPlot({
    sampleError(input$singleSample)
    plotFreqVpJ(RepSeqDT(), input$singleSample)
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
    plotSpectratyping(x = RepSeqDT(), sampleName = input$singleSample, scale = input$singleScale, prop = input$singleProp)
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
        grid.draw(plotSpectratyping(x = RepSeqDT(), sampleName = input$singleSample, scale = input$singleScale, prop = input$singleProp))
        dev.off()  # turn the device off
    }#, contentType = "image/svg"
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
    plotSpectratypingV(x = RepSeqDT(), sampleName = input$singleSample, scale = input$singleScale, prop = input$spectraProp)
    },  width="auto", 
        height <- function() {
            if (is.null(input$singleSample) || input$singleSample == "") return(600)
            else { 
                nrowsGrid <- ceiling(length(RepSeq::assay(RepSeqDT())[sample_id == input$singleSample, unique(V)])/4)
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
        grid.draw(plotSpectratypingV(x = RepSeqDT(), sampleName = input$singleSample, scale = input$singleScale, prop = input$spectraProp))
        dev.off()  # turn the device off
    }#, contentType = "image/svg"
)

##### Plot VJ distribution #####

# render UI download button countheatmap
output$downVJheatmap <- renderUI({
    if (!is.null(input$singleSample) & !(is.null(input$singleScale))) {
        downloadButton("countVJheatmap", "Download SVG")
    }
}) 
# plot count heatmap
output$plotCountHeatmap <- renderPlot({
    sampleError(input$singleSample)
    validate(need(!(is.null(input$singleScale) || input$singleScale == ""), "Choose a scale"))
    plotCountVJ(x=RepSeqDT(), sampleName=input$singleSample, scale=input$singleScale)
    },  height = function() {
            if (is.null(input$singleSample) || input$singleSample == "") return(20)
            else {
                VlengthMax <- RepSeq::assay(RepSeqDT())[sample_id == input$singleSample, max(nchar(V))]
                nrowsGrid <- max(mData(RepSeqDT())$J)     
                return(30*nrowsGrid + 5*VlengthMax)
            }
        }
)
# download button for count heatmap
output$countVJheatmap <- downloadHandler(
    filename =  function() {
        paste("heatmap_VJcount_", input$singleSample, ".svg", sep="")
    },
    # content is a function with argument file. content writes the plot to the device
    content = function(file) {
        svg(file, height=10, width=10)
        print(plotCountVJ(x=RepSeqDT(), sampleName=input$singleSample, scale=input$singleScale)) # draw the plot
        dev.off()  # turn the device off
    }, contentType = "image/svg"
)
    
