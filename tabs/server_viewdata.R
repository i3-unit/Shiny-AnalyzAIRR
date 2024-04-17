#-------------------------------------------------------------------------------------------------------------------------------------------#
#  view RepSeqExperiment object section
#-------------------------------------------------------------------------------------------------------------------------------------------#   

# get name
filenameDT <- function(fname){
    return(list(list(extend = 'csv', filename = fname), list(extend = 'excel', filename = fname)))
}

# output AssayTable
output$assayTable <- renderDataTable(AnalyzAIRR::assay(dataFilt()),
                                     options = list(scrollX=TRUE)
)
output$downloadAssay <- downloadHandler(
    "RepSeqAssay.csv",
    content = function(file) {
        write.table(AnalyzAIRR::assay(dataFilt()), file, row.names = F, sep = '\t')
    }, contentType = "text/csv"
) 
# output infoTable
output$infoTable <- renderDataTable(AnalyzAIRR::mData(dataFilt()), 
                                    options = list(scrollX=TRUE))

output$downloadMetadata <- downloadHandler(
    "RepSeqMetadata.csv",
    content = function(file) {
        write.table(AnalyzAIRR::mData(dataFilt()), file, row.names = F, sep = '\t')
    }, contentType = "text/csv"
) 
# get information of slot metadata
output$otherDataList <- renderUI({
    selectList("otherDataList", dataFilt())
})

output$metadataTable <- renderDataTable(
    if(!(is.null(input$otherDataList)))
        AnalyzAIRR::oData(dataFilt())[[input$otherDataList]], 
        options = list(scrollX=TRUE )
)

output$downloadOtherdata <- downloadHandler(
    paste0("RepSeqOtherdata", eval(input$otherDataList), ".csv"),
    content = function(file) {
        if(!(is.null(input$otherDataList)))
            write.table(AnalyzAIRR::oData(dataFilt())[[input$otherDataList]], file, row.names = F, sep = '\t')
    }, contentType = "text/csv"
) 
# output history
output$historyTable <- renderDataTable(AnalyzAIRR::History(dataFilt()), 
                                       # server = FALSE, 
                                       # style="bootstrap", 
                                       # extensions = 'Buttons', 
                                       options = list(scrollX=TRUE)#, dom = 'Bfrtip', buttons = filenameDT("RepSeqHistory"))
)
output$downloadHistory <- downloadHandler(
    "RepSeqHistory.csv",
    content = function(file) {
        write.table(AnalyzAIRR::History(dataFilt()), file, row.names = F, sep = '\t')
    }, contentType = "text/csv"
) 

output$dataExtractionHelp <- renderText({
    createHelp(?AnalyzAIRR::assay)
})

observeEvent(input$dataextractionHelp,
             showModal(modalDialog(
                 title = paste("Help"),
                 htmlOutput("dataExtractionHelp"),
                 size = "s",
                 easyClose = T
             ))
)

#### Filtering ####
output$filterCountGroup <- renderUI({
    sdata <- mData(RepSeqDT())[,unlist(lapply(mData(RepSeqDT()), function(y) { is.character(y) | is.factor(y)} )), drop = FALSE]
    to_keep <- sapply(sdata, function(i) nlevels(i)/length(i))
    to_keep <- names(to_keep)[which(to_keep < 1)]
    idx <- sapply(sdata, function(i) unique(i))[to_keep]
    
    choices <- list()
    for(i in 1:length(idx)){
        choices[[names(idx)[i]]] <- c(names(idx)[i], as.character(idx[[i]]))
    }
    selectizeInput("filterCountGroup",
                   "Select a group and a subgroup <i>(optional)</i>",  
                   choices = choices,
                   selected = NULL,
                   options = list(maxItems = 2, minItems = 2, onInitialize = I('function() { this.setValue(""); }')),
                   multiple = T)
})



dataFilterCount <- eventReactive(input$doFilterCount, {
    validate(need(!(is.null(input$filterCountLevel) || input$filterCountLevel == ""), "select a level"))
    validate(need(!(is.null(input$filterCountN) || input$filterCountN == ""), "select a number of count")) 
    if(input$putInfofile == "Yes" || !is.null(input$RDSfile)){
        filterCountGroup <- input$filterCountGroup
    } else {
        filterCountGroup <- NULL
    }
    filtercounts <- filterCount(x = RepSeqDT(), level = input$filterCountLevel, n = input$filterCountN, group = filterCountGroup)
    return(filtercounts)
})

observeEvent(input$doFilterCount,
    output$filtercounts <- renderDataTable({
        validate(need(!(is.null(input$filterCountLevel) || input$filterCountLevel == ""), "select a level"))
        validate(need(!(is.null(input$filterCountN) || input$filterCountN == ""), "select a number of count")) 
        return(datatable(AnalyzAIRR::History(dataFilterCount()), 
                         options = list(scrollX=TRUE, dom = 'Bfrtip', pageLength = 10)))
    })
)

output$downloaddataFilterCount <- downloadHandler(
    "RepSeqData_filteredcount.rds",
    content = function(file) {
        saveRDS(dataFilterCount(), file)
    }, 
) 

output$FilterCountHelp <- renderText({
    createHelp(?filterCount)
})

observeEvent(input$filtercountHelp,
             showModal(modalDialog(
                 title = paste("Help"),
                 htmlOutput("FilterCountHelp"),
                 size = "s",
                 easyClose = T
             ))
)

output$publicGroup <- renderUI({
    sdata <- mData(RepSeqDT())[,unlist(lapply(mData(RepSeqDT()), function(y) { is.character(y) | is.factor(y)} )), drop = FALSE]
    to_keep <- sapply(sdata, function(i) nlevels(i)/length(i))
    to_keep <- names(to_keep)[which(to_keep < 1)]
    idx <- sapply(sdata, function(i) unique(i))[to_keep]
    
    choices <- list()
    for(i in 1:length(idx)){
        choices[[names(idx)[i]]] <- c(names(idx)[i], as.character(idx[[i]]))
    }
    selectizeInput("publicGroup",
                   "Select a group and a subgroup <i>(optional)</i>",  
                   choices = choices,
                   selected = NULL,
                   options = list(maxItems = 2, minItems = 2, onInitialize = I('function() { this.setValue(""); }')),
                   multiple = T)
})

dataPublic <- eventReactive(input$doPublic,{
    validate(need(!(is.null(input$publicLevel) || input$publicLevel == ""), "select a level"))
    # validate(need(!(is.null(input$publicGroup) || input$publicGroup == ""), "select a group and a subgroup")) 
    # validate(need(length(input$publicGroup)==2, "Need at least one group and one subgroup")) 
    publicdata <- getPublic(x = RepSeqDT(), level = input$publicLevel, group = input$publicGroup)
    return(publicdata)
})

observeEvent(input$doPublic,
    output$publicdata <- renderDataTable({
        validate(need(!(is.null(input$publicLevel) || input$publicLevel == ""), "select a level"))
        # validate(need(!(is.null(input$publicGroup) || input$publicGroup == ""), "select a group and a subgroup"))
        # validate(need(length(input$publicGroup)==2, "Need at least one group and one subgroup")) 
        return(datatable(AnalyzAIRR::History(dataPublic()), 
                         options = list(scrollX=TRUE, dom = 'Bfrtip', pageLength = 10)))
    })
)

output$downloaddataPublic <- downloadHandler(
    "RepSeqData_publicdata.rds",
    content = function(file) {
        saveRDS(dataPublic(), file)
    }, 
) 

output$PublicHelp <- renderText({
    createHelp(?getPublic)
})

observeEvent(input$publicHelp,
             showModal(modalDialog(
                 title = paste("Help"),
                 htmlOutput("PublicHelp"),
                 size = "l",
                 easyClose = T
             ))
)

dataPrivate <- eventReactive(input$doPrivate,{
    validate(need(!(is.null(input$privateLevel) || input$privateLevel == ""), "select a level"))
    validate(need(!(is.null(input$privateSingletons) || input$privateSingletons == ""), "select a number of count")) 
    privatedata <- getPrivate(x = RepSeqDT(), level = input$privateLevel, singletons = input$privateSingletons)
    return(privatedata)
})
observeEvent(input$doPrivate,
output$privatedata <- renderDataTable({
    validate(need(!(is.null(input$privateLevel) || input$privateLevel == ""), "select a level"))
    validate(need(!(is.null(input$privateSingletons) || input$privateSingletons == ""), "select a number of count")) 
    return(datatable(AnalyzAIRR::History(dataPrivate()), 
                     options = list(scrollX=TRUE, dom = 'Bfrtip', pageLength = 10)))
})
)

output$downloaddataPrivate <- downloadHandler(
    "RepSeqData_privatedata.rds",
    content = function(file) {
        saveRDS(dataPrivate(), file)
    }, 
) 

output$PrivateHelp <- renderText({
    createHelp(?getPrivate)
})

observeEvent(input$privateHelp,
             showModal(modalDialog(
                 title = paste("Help"),
                 htmlOutput("PrivateHelp"),
                 size = "l",
                 easyClose = T
             ))
)

dataProductiveOrUnproductive <- eventReactive(input$doProductive, {
    productivedata <- getProductive(x = RepSeqDT())
    return(productivedata)
})

observeEvent(input$doProductive,
    output$productivedata <- renderDataTable({
        return(datatable(AnalyzAIRR::History(dataProductiveOrUnproductive()), 
                         options = list(scrollX=TRUE, dom = 'Bfrtip', pageLength = 10)))
    })
)

output$downloaddataProductiveOrUnproductive <- downloadHandler(
    "RepSeqData_productive.rds",
    content = function(file) {
        saveRDS(dataProductiveOrUnproductive(), file)
    }, 
) 

output$ProdHelp <- renderText({
    createHelp(?getProductive)
})

observeEvent(input$prodHelp,
             showModal(modalDialog(
                 title = paste("Help"),
                 htmlOutput("ProdHelp"),
                 size = "l",
                 easyClose = T
             ))
)

output$dropSampleNames <- renderUI({
    choices <- rownames(mData(RepSeqDT()))
    selectizeInput("dropSampleNames",
                   "Select sample",  
                   choices = choices,
                   options = list(maxItems = 1, onInitialize = I('function() { this.setValue(""); }')),
                   multiple = T)
})

dataDropedSamples <- reactive({
    validate(need(!(is.null(input$dropSampleNames) || input$dropSampleNames == ""), "select a sample"))
    dropeddata <- dropSamples(x = RepSeqDT(), sampleNames = input$dropSampleNames)

    return(dropeddata)
})

output$dropeddata <- renderDataTable({
    validate(need(!(is.null(input$dropSampleNames) || input$dropSampleNames == ""), "select a sample"))
    return(datatable(AnalyzAIRR::History(dataDropedSamples()), 
                     options = list(scrollX=TRUE, dom = 'Bfrtip', pageLength = 10)))
})

output$downloaddataDropedSamples <- downloadHandler(
        "RepSeqData_dropedsamples.rds",
    
    content = function(file) {
        saveRDS(dataDropedSamples(), file)
    }, 
) 

output$DropSamplesHelp <- renderText({
    createHelp(?dropSamples)
    
})

observeEvent(input$dropHelp,
             showModal(modalDialog(
                 title = paste("Help"),
                 htmlOutput("DropSamplesHelp"),
                 size = "l",
                 easyClose = T
             ))
)

output$topSeqGroup <- renderUI({
    sdata <- mData(RepSeqDT())[,unlist(lapply(mData(RepSeqDT()), function(y) { is.character(y) | is.factor(y)} )), drop = FALSE]
    to_keep <- sapply(sdata, function(i) nlevels(i)/length(i))
    to_keep <- names(to_keep)[which(to_keep < 1)]
    idx <- sapply(sdata, function(i) unique(i))[to_keep]
    
    choices <- list()
    for(i in 1:length(idx)){
        choices[[names(idx)[i]]] <- c(names(idx)[i], as.character(idx[[i]]))
    }
    selectizeInput("topSeqGroup",
                   "Select a group and a subgroup <i>(optional)</i>",  
                   choices = choices,
                   selected = NULL,
                   options = list(maxItems = 2, minItems = 2, onInitialize = I('function() { this.setValue(""); }')),
                   multiple = T)
})

dataTopSeq <- eventReactive(input$doTopSeq,{
    validate(need(!(is.null(input$topSeqLevel) || input$topSeqLevel == ""), "select a level"))
    validate(need(!(is.null(input$topSeqProp) || input$topSeqProp == ""), "select a prop"))
    # validate(need(!(is.null(input$topSeqGroup) || input$topSeqGroup == ""), "select a group and a subgroup")) 
    # validate(need(length(input$topSeqGroup)==2, "Need at least one group and one subgroup")) 
    topseqdata <- getTopSequences(x=RepSeqDT(), level = input$topSeqLevel, group = input$topSeqGroup, prop = input$topSeqProp)
    return(topseqdata)
})

observeEvent(input$doTopSeq,
    output$topseqdata <- renderDataTable({
        validate(need(!(is.null(input$topSeqLevel) || input$topSeqLevel == ""), "select a level"))
        validate(need(!(is.null(input$topSeqProp) || input$topSeqProp == ""), "select a prop"))
        # validate(need(!(is.null(input$topSeqGroup) || input$topSeqGroup == ""), "select a group and a subgroup")) 
        # validate(need(length(input$topSeqGroup)==2, "Need at least one group and one subgroup")) 
        return(datatable(AnalyzAIRR::History(dataTopSeq()), 
                         options = list(scrollX=TRUE, dom = 'Bfrtip', pageLength = 10)))
    })
)

output$downloaddataTopSeq <- downloadHandler(
    "RepSeqData_topseq.rds",
    content = function(file) {
        saveRDS(dataTopSeq(), file)
    }, 
) 

output$TopSeqHelp <- renderText({
    createHelp(?getTopSequences)
})

observeEvent(input$topseqHelp,
             showModal(modalDialog(
                 title = paste("Help"),
                 htmlOutput("TopSeqHelp"),
                 size = "l",
                 easyClose = T
             ))
)

output$filterSeqGroup <- renderUI({
  sdata <- mData(RepSeqDT())[,unlist(lapply(mData(RepSeqDT()), function(y) { is.character(y) | is.factor(y)} )), drop = FALSE]
  to_keep <- sapply(sdata, function(i) nlevels(i)/length(i))
  to_keep <- names(to_keep)[which(to_keep < 1)]
  idx <- sapply(sdata, function(i) unique(i))[to_keep]
  
  choices <- list()
  for(i in 1:length(idx)){
    choices[[names(idx)[i]]] <- c(names(idx)[i], as.character(idx[[i]]))
  }
  selectizeInput("filterSeqGroup",
                 "Select a group and a subgroup",  
                 choices = choices,
                 selected = NULL,
                 options = list(maxItems = 2, minItems = 2, onInitialize = I('function() { this.setValue(""); }')),
                 multiple = T)
})

dataFilterSeq <- eventReactive(input$doFilterSeq, {
  validate(need(!(is.null(input$filterSeqLevel) || input$filterSeqLevel == ""), "select a level"))
  validate(need(!(is.null(input$filterSeqName) || input$filterSeqName == ""), "enter a sequence")) 
  if(input$putInfofile == "Yes" || !is.null(input$RDSfile)){
    filterSeqGroup <- input$filterSeqGroup
  } else {
    filterSeqGroup <- NULL
  }
  filterseqs <- filterSequence(x = RepSeqDT(), level = input$filterSeqLevel, name = input$filterSeqName, group = filterSeqGroup)
  return(filterseqs)
})

observeEvent(input$doFilterSeq,
             output$filterseqs <- renderDataTable({
               validate(need(!(is.null(input$filterSeqLevel) || input$filterSeqLevel == ""), "select a level"))
               validate(need(!(is.null(input$filterSeqName) || input$filterSeqName == ""), "enter a sequence")) 
               return(datatable(AnalyzAIRR::History(dataFilterSeq()), 
                                options = list(scrollX=TRUE, dom = 'Bfrtip', pageLength = 10)))
             })
)

output$downloaddataFilterSeq <- downloadHandler(
  "RepSeqData_filteredseq.rds",
  content = function(file) {
    saveRDS(dataFilterSeq(), file)
  }, 
) 

output$FilterSeqHelp <- renderText({
  createHelp(?filterSequence)
})

observeEvent(input$filterseqHelp,
             showModal(modalDialog(
               title = paste("Help"),
               htmlOutput("FilterSeqHelp"),
               size = "l",
               easyClose = T
             ))
)


#### Normalization ####


downSampling <- reactive({
    validate(need(!(input$doDown==FALSE || input$doDown == ""), "Perform a down-sampling normalization ?"))
    validate(need(!(is.null(input$downSampleSize) || input$downSampleSize == ""), "select a sample size"))
    validate(need(!(is.null(input$downReplace) || input$downReplace == ""), "Replacement"))

    if(input$doDown){
        downsampleddata <- sampleRepSeqExp(x = RepSeqDT(), sample.size = input$downSampleSize, rngseed = isolate(input$downseed), replace = input$downReplace, verbose = FALSE)
    }
    return(downsampleddata)
})

output$downsampleddata <- renderDataTable({
    validate(need(!(input$doDown==FALSE || input$doDown == ""), "Perform a down-sampling normalization ?"))
    validate(need(!(is.null(input$downSampleSize) || input$downSampleSize == ""), "select a sample size"))
    validate(need(!(is.null(input$downReplace) || input$downReplace == ""), "select if replacement"))
    return(datatable(AnalyzAIRR::History(downSampling()),
                     options = list(scrollX=TRUE, dom = 'Bfrtip', pageLength = 10)))
})

output$downloaddownSampling <- downloadHandler(
    "RepSeqData_downsampling.rds",
    
    content = function(file) {
        saveRDS(downSampling(), file)
    }, 
) 

output$DownHelp <- renderText({
    createHelp(?sampleRepSeqExp)
    
})

observeEvent(input$downHelp,
             showModal(modalDialog(
                 title = paste("Help"),
                 htmlOutput("DownHelp"),
                 size = "l",
                 easyClose = T
             ))
)

# new libsize after downsampling # library sizes
observeEvent(c(input$doDown, input$DownLevel), {
    output$histdownlibsizes <- renderPlot({
        validate(need(!(input$doDown==FALSE || input$doDown == ""), "Perform a down-sampling normalization ?"))
        validate(need(!(is.null(input$DownLevel) || input$DownLevel == ""), "select a level"))
        cts1 <- AnalyzAIRR::assay(RepSeqDT())
        p1 <- histSums(cts1[, sum(count), by=eval(input$DownLevel)][,V1], xlab="count", ylab=paste0("Number of ", input$DownLevel)) +
            ggtitle("Orignial data")+
            theme_RepSeq()+
            theme(axis.title.x = ggplot2::element_text(size=15),
                  axis.title.y = ggplot2::element_text(size=15),
                  axis.text.x = ggplot2::element_text(size=15),
                  axis.text.y = ggplot2::element_text(size=15))
        cts2 <- AnalyzAIRR::assay(downSampling())
        p2 <- histSums(cts2[, sum(count), by=eval(input$DownLevel)][,V1], xlab="count", ylab=paste0("Number of ", input$DownLevel)) +
            ggtitle("Downsampled data") +
            theme_RepSeq()+
            theme(axis.title.x = ggplot2::element_text(size=15),
                  axis.title.y = ggplot2::element_text(size=15),
                  axis.text.x = ggplot2::element_text(size=15),
                  axis.text.y = ggplot2::element_text(size=15))

        gridExtra::grid.arrange(p1, p2, ncol=2)
    })
})

output$downhistdownlibsizes <- renderUI({
    if (!is.null(input$doDown) & !is.null(input$DownLevel)) {
        downloadButton("Plothistdownlibsizes", "Download PDF", style="background-color:white; border-color: #022F5A;")
    }
}) 

output$Plothistdownlibsizes <- downloadHandler(
    filename =  function() {
        paste0("histdownlibsizes_", eval(input$DownLevel), ".pdf")
    },
    # content is a function with argument file. content writes the plot to the device
    content = function(file) {
        pdf(file, height=3.5, width=7)
        cts1 <- AnalyzAIRR::assay(RepSeqDT())
        p1 <- histSums(cts1[, sum(count), by=eval(input$DownLevel)][,V1], xlab="count", ylab=paste0("Number of ", input$DownLevel)) +
            ggtitle("Orignial data")+
            theme_RepSeq()+
            theme( axis.title.x = ggplot2::element_text(size=15),
                   axis.title.y = ggplot2::element_text(size=15),
                   axis.text.x = ggplot2::element_text(size=15),
                   axis.text.y = ggplot2::element_text(size=15))
        cts2 <- AnalyzAIRR::assay(downSampling())
        p2 <- histSums(cts2[, sum(count), by=eval(input$DownLevel)][,V1], xlab="count", ylab=paste0("Number of ", input$DownLevel)) +
            ggtitle("Downsampled data") +
            theme_RepSeq()+
            theme(axis.title.x = ggplot2::element_text(size=15),
                  axis.title.y = ggplot2::element_text(size=15),
                  axis.text.x = ggplot2::element_text(size=15),
                  axis.text.y = ggplot2::element_text(size=15))
        grid.draw(gridExtra::grid.arrange(p1, p2, ncol=2))
        dev.off()
    }
)

shannonNormed <- reactive({
    validate(need(!(input$doNorm == FALSE || input$doNorm == ""), "Perform a shannon normalization ?"))

    if(input$doNorm){
        shannonsampleddata <- ShannonNorm(x = RepSeqDT())
    }

    return(shannonsampleddata)
})


output$shannonsampleddata <- renderDataTable({
    validate(need(!(input$doNorm == FALSE || input$doNorm == ""), "Perform a shannon normalization ?"))
    return(datatable(AnalyzAIRR::History(shannonNormed()),
                     options = list(scrollX=TRUE, dom = 'Bfrtip', pageLength = 10)))
})

output$downloadshannonNormed <- downloadHandler(
    "RepSeqData_shannonNormed.rds",
    
    content = function(file) {
        saveRDS(shannonNormed(), file)
    }, 
) 

output$ShannonHelp <- renderText({
    createHelp(?ShannonNorm)
    
})

observeEvent(input$shannonHelp,
             showModal(modalDialog(
                 title = paste("Help"),
                 htmlOutput("ShannonHelp"),
                 size = "l",
                 easyClose = T
             ))
)

observeEvent(c(input$doNorm, input$NormLevel), {
    output$histshannonlibsizes <- renderPlot({
        validate(need(!(input$doNorm == FALSE || input$doNorm == ""), "Perform a shannon normalization ?"))
        validate(need(!(is.null(input$NormLevel) || input$NormLevel == ""), "select a level"))
        cts1 <- AnalyzAIRR::assay(RepSeqDT())
        p1 <- histSums(cts1[, sum(count), by=eval(input$NormLevel)][,V1], xlab="count", ylab=paste0("Number of ", input$NormLevel)) +
            ggtitle("Orignial data")+
            theme_RepSeq()+
            theme(axis.title.x = ggplot2::element_text(size=15),
                  axis.title.y = ggplot2::element_text(size=15),
                  axis.text.x = ggplot2::element_text(size=15),
                  axis.text.y = ggplot2::element_text(size=15))
        cts2 <- AnalyzAIRR::assay(shannonNormed())
        p2 <- histSums(cts2[, sum(count), by=eval(input$NormLevel)][,V1], xlab="count", ylab=paste0("Number of ", input$NormLevel)) +
            ggtitle("Shannon normalized data") +
            theme_RepSeq()+
            theme(axis.title.x = ggplot2::element_text(size=15),
                  axis.title.y = ggplot2::element_text(size=15),
                  axis.text.x = ggplot2::element_text(size=15),
                  axis.text.y = ggplot2::element_text(size=15))
        
        gridExtra::grid.arrange(p1, p2, ncol=2)
    })
})

output$downhistshannonlibsizes <- renderUI({
    if (!is.null(input$doNorm) & !is.null(input$NormLevel)) {
        downloadButton("Plothistshannonlibsizes", "Download PDF", style="background-color:white; border-color: #022F5A;")
    }
}) 

output$Plothistshannonlibsizes <- downloadHandler(
    filename =  function() {
        paste0("histshannonlibsizes_", eval(input$NormLevel), ".pdf")
    },
    # content is a function with argument file. content writes the plot to the device
    content = function(file) {
        pdf(file, height=3.5, width=7)
        cts1 <- AnalyzAIRR::assay(RepSeqDT())
        p1 <- histSums(cts1[, sum(count), by=eval(input$NormLevel)][,V1], xlab="count", ylab=paste0("Number of ", input$NormLevel)) +
            ggtitle("Orignial data")+
            theme_RepSeq()+
            theme(axis.title.x = ggplot2::element_text(size=15),
                  axis.title.y = ggplot2::element_text(size=15),
                  axis.text.x = ggplot2::element_text(size=15),
                  axis.text.y = ggplot2::element_text(size=15))
        cts2 <- AnalyzAIRR::assay(shannonNormed())
        p2 <- histSums(cts2[, sum(count), by=eval(input$NormLevel)][,V1], xlab="count", ylab=paste0("Number of ", input$NormLevel)) +
            ggtitle("Shannon normalized data") +
            theme_RepSeq()+
            theme(axis.title.x = ggplot2::element_text(size=15),
                  axis.title.y = ggplot2::element_text(size=15),
                  axis.text.x = ggplot2::element_text(size=15),
                  axis.text.y = ggplot2::element_text(size=15))
        
        grid.draw(gridExtra::grid.arrange(p1, p2, ncol=2))
        dev.off()
    }
)


dataFilt <- eventReactive(c(input$doFilterCount,input$filterCountLevel, input$filterCountN,
                            input$doFilterSeq,input$filterSeqLevel, input$filterSeqName,
                            input$doPublic, input$publicLevel, input$publicProp,
                            input$doPrivate, input$privateLevel, input$privateSingletons, 
                            input$doProductive, 
                            input$dropSampleNames,
                            input$doTopSeq, input$topSeqLevel, input$topSeqProp,
                            input$doNorm,
                            input$doDown, input$downReplace), {
    if(input$doFilterCount==1 && 
       !(is.null(input$filterCountLevel) || input$filterCountLevel == "") && 
       !(is.null(input$filterCountN) || input$filterCountN == "")){
        return(dataFilterCount())
    } else if(input$doFilterSeq==1 && 
              !(is.null(input$filterSeqLevel) || input$filterSeqLevel == "") && 
              !(is.null(input$filterSeqName) || input$filterSeqName == "")){
      return(dataFilterSeq())
    } else if(input$doPublic==1 &&
              !(is.null(input$publicLevel) || input$publicLevel == "") &&
              !(is.null(input$publicProp) || input$publicProp == "")){
        return(dataPublic())
    } else if(input$doPrivate==1 &&
              !(is.null(input$privateLevel) || input$privateLevel == "") &&
              !(is.null(input$privateSingletons) || input$privateSingletons == "")){
        return(dataPrivate())
    }else if(input$doProductive == 1){
        return(dataProductiveOrUnproductive())
    } else if(!(is.null(input$dropSampleNames) || input$dropSampleNames == "")){
        return(dataDropedSamples())
    } else if(input$doTopSeq==1 &&
              !(is.null(input$topSeqLevel) || input$topSeqLevel == "") && 
              !(is.null(input$topSeqProp) || input$topSeqProp == "")){
        return(dataTopSeq())
    } else if(input$doNorm){
        return(shannonNormed())
    } else if(input$doDown && input$downReplace){
        return(downSampling())
    } else {
        return(RepSeqDT())
    }
})














