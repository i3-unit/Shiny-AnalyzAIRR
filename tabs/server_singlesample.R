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
# plot overlay spectratype 
output$spectraPlot <- renderPlot({
    sampleError(input$singleSample)
    validate(need(!(is.null(input$singleScale) || input$singleScale == ""), "Choose a scale"))
    plotSpectratype(RepSeqDT(), input$singleSample, input$singleScale)
})
# plot individual spectratype 
output$spectraPlotbis <- renderPlot({
    sampleError(input$singleSample)
    validate(need(!(is.null(input$singleScale) || input$singleScale == ""), "Choose a scale"))
    plotSpectratypeV(RepSeqDT(), input$singleSample, input$singleScale, input$spectraCDR3)
    },  width="auto", 
        height <- function() {
            if (is.null(input$singleSample) || input$singleSample == "") return(600)
            else { 
                nrowsGrid <- ceiling(length(RepSeq::assay(RepSeqDT())[lib == input$singleSample, unique(V)])/4)
                return(150 * nrowsGrid)
            }
        }
)
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
                VlengthMax <- RepSeq::assay(RepSeqDT())[lib == input$singleSample, max(nchar(V))]
                nrowsGrid <- max(sData(RepSeqDT())$J)     
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
    
