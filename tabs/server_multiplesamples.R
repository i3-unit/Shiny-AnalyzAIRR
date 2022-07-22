#-------------------------------------------------------------------------------------------------------------------------------------------#
#  multiple comparison section
#-------------------------------------------------------------------------------------------------------------------------------------------#    

    # render plot Renyi profile
    output$renyiGroup <- renderUI({
        validate(need(!(is.null(input$renyiLevel) || input$renyiLevel ==""), "select level"))
        selectGroup("renyiGroup", dat())
    })
    # render checkbox input
    output$renyiGroupChoice <- renderUI({
        validate(need(!(is.null(input$renyiLevel) || input$renyiLevel ==""), "select level"))
        validate(need(!(is.null(input$renyiGroup) || input$renyiGroup == ""), "select group"))
        choice <- unique(mData(dat())[, input$renyiGroup])
        checkboxGroupInput("renyiGroupChoice", 
            label = input$renyiGroup,
            choices = choice,
            selected = choice[1],
            inline = TRUE)
    })
    # plot Renyi profile
    output$plotRenyi <- renderPlot({
        validate(need(!(is.null(input$renyiLevel) || input$renyiLevel ==""), " "))
        validate(need(!(is.null(input$renyiGroup) || input$renyiGroup == ""), " "))  
        #group <- switch((input$renyiGroup == "Sample") + 1, input$renyiGroup, NULL)
        plotRenyiIndex(x = dat(), alpha=c(0, 0.25, 0.5, 1, 2, 4, 8, 16, 32, 64, Inf), level=input$renyiLevel, colorBy=input$renyiGroup) +
            ggplot2::theme(aspect.ratio = 1) ##modified by VMH
    })  
    # create Group selector
    output$GrpColMDS <- renderUI({
        validate(need(!(is.null(input$dissimilarityLevel) || input$dissimilarityLevel == ""), " "))
        validate(need(!(is.null(input$dissimilarityIndex) || input$dissimilarityIndex == ""), " "))
        validate(need(!(is.null(input$dissimilarityClustering) || input$dissimilarityClustering == ""), " "))
        validate(need(!(is.null(input$dissimilarityMethod) || input$dissimilarityMethod == ""), " "))
        selectGroup("grpCol4MDS", dat())
    })
    # plot dissimilarity
    output$plotDissimilarityHM <- renderPlot({
        validate(need(!(is.null(input$dissimilarityLevel) || input$dissimilarityLevel == ""), "select level"))
        validate(need(!(is.null(input$dissimilarityIndex) || input$dissimilarityIndex == ""), "select dissimilarity index"))
        validate(need(!(is.null(input$dissimilarityClustering) || input$dissimilarityClustering == ""), "select dissimilarity clustering"))
        plotDissimilarityMatrix(x = dat(), level = input$dissimilarityLevel, method = input$dissimilarityIndex, binary = FALSE, clustering = input$dissimilarityClustering, label_colors = NULL)    
    })    
    # plot MDS
    output$plotMDS <- renderPlot({
        validate(need(!(is.null(input$dissimilarityLevel) || input$dissimilarityLevel == ""), " "))
        validate(need(!(is.null(input$dissimilarityIndex) || input$dissimilarityIndex == ""), " "))
        validate(need(!(is.null(input$dissimilarityClustering) || input$dissimilarityClustering == ""), "select dissimilarity clustering"))
        validate(need(!(is.null(input$dissimilarityMethod) || input$dissimilarityMethod == ""), "select dissimilarity method"))
        validate(need(!(is.null(input$grpCol4MDS) || input$grpCol4MDS == ""), "select group"))
        group <- switch((input$grpCol4MDS == "Sample") + 1, input$grpCol4MDS, NULL)
        plotDimReduction(x = dat(), level = input$dissimilarityLevel, method = input$dissimilarityIndex, colorBy = group, label_colors = NULL, dim_method = input$dissimilarityMethod)
    })
    # include md formula distance function
    output$distFuncsMD <- renderUI({
        shiny::withMathJax(includeMarkdown("markdown/distanceFuncs.md"))
    })
    # include md formula Reyni
    output$renyiMD <- renderUI({
        shiny::withMathJax(includeMarkdown("markdown/Renyi.md"))
    })
    # include md diversity index computation
    output$diversityMD <- renderUI({
        shiny::withMathJax(includeMarkdown("markdown/DiversityIndex.md"))
    })
    # render VJ distribution
    output$distribVpJGroup <- renderUI(
        selectGroup("distribVpJGroup", RepSeqDT())
    )
    # plot VJ distribution
    output$plotDistribVpJ <- renderPlot({
        validate(need(!(is.null(input$distribVpJGroup) || input$distribVpJGroup == ""), "select group"))
        validate(need(!(is.null(input$distribVpJGroupMeth) || input$distribVpJGroupMeth == ""), "select scale"))
        validate(need(!(is.null(input$distribVpJLevel) || input$distribVpJLevel == ""), "select level"))
      
        group <- input$distribVpJGroup
        plotRankDistrib(dat(), colorBy = group, scale = input$distribVpJGroupMeth, level = input$distribVpJLevel, grouped = FALSE, label_colors = NULL)
    })
    # render VennUI for selecting type of Venn Diagram
    output$vennUISample <- renderUI({
    #    validate(need(!(is.null(input$vennLevel) || input$vennLevel ==""), message=" ", label=" "))
    #    validate(need(!(is.null(input$venntype) || input$venntype ==""), message=" ", label=" "))
        # render Venn samples
    #    if (input$venntype == "Samples") {
            choices <- rownames(mData(dat()))
            selectizeInput("vennSamples",
                "Select samples (maximum 4)",  #modified by VMH
                choices = choices,
                options = list(maxItems = 4, onInitialize = I('function() { this.setValue(""); }')),
                multiple = T)  #VMH changed 3 to 4
    })
    
    #output$vennUIGroup <- renderUI({
    #    selectGroupDE("vennGroupSelected", dat())
    #})
    # render Venn
    #output$vennSubGroup <- renderUI({
    #    validate(need(!(is.null(input$vennGroupSelected) || input$vennGroupSelected == ""), "select group"))
    #    choices <- levels(mData(dat())[, input$vennGroupSelected])
    #    selectizeInput("vennSubGroup",
    #        "Select groups (3 max)",
    #        choices = choices,
    #        options = list(maxItems = 3, onInitialize = I('function() { this.setValue(""); }')),
    #        multiple = T)
    #})
    # render Venn samples
    #output$VennSamplesUI <- renderUI({
    #    validate(need(!(is.null(input$vennLevel) || input$vennLevel ==""), message=" ", label=" "))
    #    validate(need(input$vennGroupSelected == "Sample", message=" ", label=" "))
    #    choices <- rownames(mData(dat()))
    #    selectizeInput("vennSamples",
    #        "Select samples (3 max)",
    #        choices = choices,
    #        options = list(maxItems = 3, onInitialize = I('function() { this.setValue(""); }')),
    #        multiple = T
    #    )
    #})
    # plot Venn
    #output$plotVenn <- renderPlot({
    #    validate(need(!(is.null(input$vennLevel) || input$vennLevel == ""), "select level"))
    #    validate(need(!(is.null(input$venntype) || input$venntype ==""), "select type"))
    #    if( input$vennGroupSelected == "Sample") {
    #        validate(need(!(is.null(input$vennSamples) || input$vennSamples == ""), "select samples"))
    #        validate(need(length(input$vennSamples)>1, "select a second sample"))
    #        grp <- input$vennSamples 
    #    } else grp <- input$vennGroupSelected
    #        plotVenn(dat(), level = input$vennLevel, colorBy = grp)
    #})
    output$plotEulerr <- renderPlot({
        validate(need(!(is.null(input$vennLevel) || input$vennLevel == ""), "select level"))
        validate(need(!(is.null(input$vennSamples) || input$vennSamples ==""), "select samples"))
        validate(need(length(input$vennSamples)>1, "select a second sample"))
        plotEulerr(dat(), level = input$vennLevel, sampleNames = input$vennSamples)
    })
    # # render mu Score 
    # output$plotmuScore <- renderPlot({
    #     validate(need(!(is.null(input$muLevel) || input$muLevel == ""), "select level"))
    #     validate(need(!(is.null(input$muType) || input$muType == ""), "select type"))
    #     print(session$clientData)
    #     plotmuScore(dat(), input$muLevel, input$muType)
    #     },  height = function() {    
    #             if(is.null(input$muLevel) || input$muLevel == "" || is.null(input$muType) || input$muType == "") return(20)
    #             else {
    #                 level <- input$muLevel
    #                 sdata <- mData(dat())
    #                 nrowsGrid <- max(sdata[, level])
    #                 slengthMax <- max(nchar(rownames(sdata)))
    #                 return(20 * nrowsGrid + 5 * slengthMax)
    #             }
    #         }, 
    #         width = function() {
    #             if (is.null(input$muLevel) || input$muLevel == "" || is.null(input$muType) || input$muType == "") return(20)
    #             else {
    #                 level <- input$muLevel
    #                 levelLengthMax <- assay(dat())[, max(nchar(as.character(get(level))))]
    #                 nsamples <- nrow(mData(dat()))
    #                 return(20*nsamples + 5*levelLengthMax)
    #             }
    #         }
    # )
    # render 2by2 comparison
    output$count2v2Libs <- renderUI({
        selectizeInput("count2v2Libs",
            "Select two samples", #modified by VMH
            choices = rownames(mData(dat())),
            options = list(maxItems = 2, onInitialize = I('function() { this.setValue(""); }')),
            multiple = T
        )
    })
    # plot 2by2 comparison
    output$plot2v2count <- renderPlot({
        print(input$count2v2Libs)
        validate(need(!(is.null(input$count2v2Level) || input$count2v2Level == ""), "select level"))
        validate(need(!(is.null(input$count2v2Libs) || input$count2v2Libs == ""), "select a first sample"))
        validate(need(length(input$count2v2Libs)==2, "select a second sample"))
        plotScatter(x = dat(), level = input$count2v2Level, sampleNames = input$count2v2Libs, scale = input$count2v2scale) + 
            ggplot2::theme(aspect.ratio = 1)
    })
    # selected region
    selected2v2count <- eventReactive(input$plot2v2count_brush,{
        brush2v2count(dat(), input$count2v2Level, input$count2v2Libs, input$plot2v2count_brush)
    })
    # render selected region DT
    output$brush2v2countDT <- DT::renderDataTable({
        validate(need(!(is.null(input$count2v2Level) || input$count2v2Level == ""), "select level"))
        validate(need(!(is.null(input$count2v2Libs) || input$count2v2Libs == ""), "select the first sample")) #modified by VMH
        validate(need(length(input$count2v2Libs)==2, "select a second sample"))
        datatable(selected2v2count(), options=list(scrollX=TRUE))
    }) 
    # dowload button for the selected data set   
    output$downloadSelected <- renderUI({
        if (!is.null(input$plot2v2count_brush)) {
            downloadButton('OutputFile', 'Download Output File')
        }
    })
    # make the download button 
    output$OutputFile <- downloadHandler(
        filename = function() {
            paste("data-", Sys.Date(), ".csv", sep="")
        },
        content = function(file) {
            write.csv(selected2v2count(), file, row.names=TRUE)
        }
    )