#-------------------------------------------------------------------------------------------------------------------------------------------#
#  view RepSeqExperiment object section
#-------------------------------------------------------------------------------------------------------------------------------------------#   

# get name
filenameDT <- function(fname){
    return(list(list(extend = 'csv', filename = fname), list(extend = 'excel', filename = fname)))
}

# output AssayTable
output$assayTable <- renderDataTable(RepSeq::assay(dataFilt()),
                                     options = list(scrollX=TRUE)
)
output$downloadAssay <- downloadHandler(
    "RepSeqAssay.csv",
    content = function(file) {
        write.table(RepSeq::assay(dataFilt()), file, row.names = F, sep = '\t')
    }, contentType = "text/csv"
) 
# output infoTable
output$infoTable <- renderDataTable(RepSeq::mData(dataFilt()), 
                                    options = list(scrollX=TRUE))

output$downloadMetadata <- downloadHandler(
    "RepSeqMetadata.csv",
    content = function(file) {
        write.table(RepSeq::assay(dataFilt()), file, row.names = F, sep = '\t')
    }, contentType = "text/csv"
) 
# get information of slot metadata
output$metadataTable <- renderDataTable(RepSeq::oData(dataFilt())$filtered, 
                                        # server = FALSE, 
                                        # style="bootstrap", 
                                        # extensions = 'Buttons', 
                                        options = list(scrollX=TRUE)#, dom = 'Bfrtip', buttons = filenameDT("RepSeqOtherInfo"))
)
output$downloadOtherdata <- downloadHandler(
    "RepSeqOtherdata.csv",
    content = function(file) {
        write.table(RepSeq::assay(dataFilt()), file, row.names = F, sep = '\t')
    }, contentType = "text/csv"
) 
# output history
output$historyTable <- renderDataTable(RepSeq::History(dataFilt()), 
                                       # server = FALSE, 
                                       # style="bootstrap", 
                                       # extensions = 'Buttons', 
                                       options = list(scrollX=TRUE)#, dom = 'Bfrtip', buttons = filenameDT("RepSeqHistory"))
)
output$downloadHistory <- downloadHandler(
    "RepSeqHistory.csv",
    content = function(file) {
        write.table(RepSeq::assay(dataFilt()), file, row.names = F, sep = '\t')
    }, contentType = "text/csv"
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
                   "Select a group and a feature",  
                   choices = choices,
                   options = list(maxItems = 2, minItems = 2, onInitialize = I('function() { this.setValue(""); }')),
                   multiple = T)
})

dataFilterCount <- reactive({
    validate(need(!(is.null(input$filterCountLevel) || input$filterCountLevel == ""), "select level"))
    validate(need(!(is.null(input$filterCountN) || input$filterCountN == ""), "select a number of count")) 
    validate(need(!(is.null(input$filterCountGroup) || input$filterCountGroup == ""), "select a group and a feature")) 
    filtercounts <- filterCount(x = RepSeqDT(), level = input$filterCountLevel, n = input$filterCountN, group = input$filterCountGroup)
    return(filtercounts)
})

output$filtercounts <- renderDataTable({
    validate(need(!(is.null(input$filterCountLevel) || input$filterCountLevel == ""), "select level"))
    validate(need(!(is.null(input$filterCountN) || input$filterCountN == ""), "select a number of count")) 
    validate(need(!(is.null(input$filterCountGroup) || input$filterCountGroup == ""), "select a group and a feature")) 
    return(datatable(RepSeq::History(dataFilterCount()), 
                     options = list(scrollX=TRUE, dom = 'Bfrtip', pageLength = 10)))
})

output$downloaddataFilterCount <- downloadHandler(
    "RepSeqData_filteredcount.rds",
    content = function(file) {
        saveRDS(dataFilterCount(), file)
    }, 
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
                   "Select a group and a feature",  
                   choices = choices,
                   options = list(maxItems = 2, minItems = 2, onInitialize = I('function() { this.setValue(""); }')),
                   multiple = T)
})

dataPublic <- reactive({
    validate(need(!(is.null(input$publicLevel) || input$publicLevel == ""), "select level"))
    validate(need(!(is.null(input$publicProp) || input$publicProp == ""), "select a number of count")) 
    validate(need(!(is.null(input$publicGroup) || input$publicGroup == ""), "select group and a feature")) 
    publicdata <- getPublic(x = RepSeqDT(), level = input$publicLevel, group = input$publicGroup, prop = input$publicProp)
    return(publicdata)
})

output$publicdata <- renderDataTable({
    validate(need(!(is.null(input$publicLevel) || input$publicLevel == ""), "select level"))
    validate(need(!(is.null(input$publicProp) || input$publicProp == ""), "select a number of count")) 
    validate(need(!(is.null(input$publicGroup) || input$publicGroup == ""), "select group and a feature")) 
    return(datatable(RepSeq::History(dataPublic()), 
                     options = list(scrollX=TRUE, dom = 'Bfrtip', pageLength = 10)))
})

output$downloaddataPublic <- downloadHandler(
    "RepSeqData_publicdata.rds",
    content = function(file) {
        saveRDS(dataPublic(), file)
    }, 
) 

dataPrivate <- reactive({
    validate(need(!(is.null(input$privateLevel) || input$privateLevel == ""), "select level"))
    validate(need(!(is.null(input$privateSingletons) || input$privateSingletons == ""), "select a number of count")) 
    privatedata <- getPrivate(x = RepSeqDT(), level = input$privateLevel, singletons = input$privateSingletons)
    return(privatedata)
})

output$privatedata <- renderDataTable({
    validate(need(!(is.null(input$privateLevel) || input$privateLevel == ""), "select level"))
    validate(need(!(is.null(input$privateSingletons) || input$privateSingletons == ""), "select a number of count")) 
    return(datatable(RepSeq::History(dataPrivate()), 
                     options = list(scrollX=TRUE, dom = 'Bfrtip', pageLength = 10)))
})

output$downloaddataPrivate <- downloadHandler(
    "RepSeqData_privatedata.rds",
    content = function(file) {
        saveRDS(dataPrivate(), file)
    }, 
) 

dataProductiveOrUnproductive <- reactive({
    validate(need(!(is.null(input$productive) || input$productive == ""), "select if productive"))
    
    if(input$productive==TRUE){
        productivedata <- getProductive(x = RepSeqDT())
    } else {
        productivedata <- getUnproductive(x = RepSeqDT())
    }
   
    return(productivedata)
})

output$productivedata <- renderDataTable({
    validate(need(!(is.null(input$productive) || input$productive == ""), "select if productive"))
    return(datatable(RepSeq::History(dataProductiveOrUnproductive()), 
                     options = list(scrollX=TRUE, dom = 'Bfrtip', pageLength = 10)))
})

output$downloaddataProductiveOrUnproductive <- downloadHandler(
    if(input$productive==TRUE){
        "RepSeqData_productive.rds"
    } else{
        "RepSeqData_unproductive.rds"
    }
    
    ,content = function(file) {
        saveRDS(dataProductiveOrUnproductive(), file)
    }, 
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
    return(datatable(RepSeq::History(dataDropedSamples()), 
                     options = list(scrollX=TRUE, dom = 'Bfrtip', pageLength = 10)))
})

output$downloaddataDropedSamples <- downloadHandler(
        "RepSeqData_dropedsamples.rds",
    
    content = function(file) {
        saveRDS(dataDropedSamples(), file)
    }, 
) 

#### Normalization ####


downSampling <- reactive({
    validate(need(!(is.null(input$doDown) || input$doDown == ""), "Perform down-sampling normalization ?"))
    validate(need(!(is.null(input$downSampleSize) || input$downSampleSize == ""), "select a sample size"))
    if(input$doDown==TRUE){
        downsampleddata <- sampleRepSeqExp(x = RepSeqDT(), sample.size = input$downSampleSize, rngseed = isolate(input$downseed), replace = TRUE, verbose = FALSE)
    }
    return(downsampleddata)
})

output$downsampleddata <- renderDataTable({
    validate(need(!(is.null(input$doDown) || input$doDown == ""), "Perform down-sampling normalization ?"))
    validate(need(!(is.null(input$downSampleSize) || input$downSampleSize == ""), "select a sample size"))
    return(datatable(RepSeq::History(downSampling()),
                     options = list(scrollX=TRUE, dom = 'Bfrtip', pageLength = 10)))
})

output$downloaddownSampling <- downloadHandler(
    "RepSeqData_downsampling.rds",
    
    content = function(file) {
        saveRDS(downSampling(), file)
    }, 
) 

# new libsize after downsampling # library sizes
observeEvent(input$doDown, {
    validate(need(!(is.null(input$doDown) || input$doDown == ""), "Perform down-sampling normalization ?"))
    output$histdownlibsizes <- renderPlot({
        cts1 <- RepSeq::assay(RepSeqDT())
        p1 <- histSums(cts1[, sum(count), by=clone][,V1], xlab="clonotype counts", ylab="Number of clonotypes") +
            ggtitle("Orignial data - Clonotype count distribution")+
            theme_light()+
            theme( panel.grid.minor = ggplot2::element_blank(),
                   panel.grid.major = ggplot2::element_line(colour = "gray89",linetype="dashed",size=0.1))
        cts2 <- RepSeq::assay(downSampling())
        p2 <- histSums(cts2[, sum(count), by=clone][,V1], xlab="clonotype counts", ylab="Number of clonotypes") +
            ggtitle("Downsampled data - Clonotype count distribution") +
            theme_light()+
            theme( panel.grid.minor = ggplot2::element_blank(),
                   panel.grid.major = ggplot2::element_line(colour = "gray89",linetype="dashed",size=0.1))

        gridExtra::grid.arrange(p1, p2, ncol=2)
    })
})

output$downhistdownlibsizes <- renderUI({
    if (!is.null(input$doDown)) {
        downloadButton("Plothistdownlibsizes", "Download PNG")
    }
}) 

output$Plothistdownlibsizes <- downloadHandler(
    filename =  function() {
        paste0("histdownlibsizes.png")
    },
    # content is a function with argument file. content writes the plot to the device
    content = function(file) {
        png(file, height=2400, width=4800, res=300)
        cts1 <- RepSeq::assay(RepSeqDT())
        p1 <- histSums(cts1[, sum(count), by=clone][,V1], xlab="clonotype counts", ylab="Number of clonotypes") +
            ggtitle("Orignial data - Clonotype count distribution")+
            theme_light()+
            theme( panel.grid.minor = ggplot2::element_blank(),
                   panel.grid.major = ggplot2::element_line(colour = "gray89",linetype="dashed",size=0.1))
        cts2 <- RepSeq::assay(downSampling())
        p2 <- histSums(cts2[, sum(count), by=clone][,V1], xlab="clonotype counts", ylab="Number of clonotypes") +
            ggtitle("Downsampled data - Clonotype count distribution") +
            theme_light()+
            theme( panel.grid.minor = ggplot2::element_blank(),
                   panel.grid.major = ggplot2::element_line(colour = "gray89",linetype="dashed",size=0.1))
        
        grid.newpage()
        grid.draw(gridExtra::grid.arrange(p1, p2, ncol=2))
        dev.off()
    }
)

shannonNormed <- reactive({
    validate(need(!(is.null(input$doNorm) || input$doNorm == ""), "Perform shannon normalization ?"))

    if(input$doNorm==TRUE){
        shannonsampleddata <- ShannonNorm(x = RepSeqDT())
    }

    return(shannonsampleddata)
})


output$shannonsampleddata <- renderDataTable({
    validate(need(!(is.null(input$doNorm) || input$doNorm == ""), "Perform shannon normalization ?"))
    return(datatable(RepSeq::History(shannonNormed()),
                     options = list(scrollX=TRUE, dom = 'Bfrtip', pageLength = 10)))
})

output$downloadshannonNormed <- downloadHandler(
    "RepSeqData_shannonNormed.rds",
    
    content = function(file) {
        saveRDS(shannonNormed(), file)
    }, 
) 


dataFilt <- eventReactive(c(input$filterCountLevel, input$filterCountN, input$filterCountGroup, 
                            input$publicLevel, input$publicProp, input$publicGroup,
                            input$privateLevel, input$privateSingletons, 
                            input$productive, 
                            input$dropSampleNames,
                            input$doNorm,
                            input$doDown), {
    if(!(is.null(input$filterCountLevel) || input$filterCountLevel == "") && 
       !(is.null(input$filterCountN) || input$filterCountN == "") && 
       !(is.null(input$filterCountGroup) || input$filterCountGroup == "")){
        return(dataFilterCount())
    } else if(!(is.null(input$publicLevel) || input$publicLevel == "") &&
              !(is.null(input$publicProp) || input$publicProp == "") &&
              !(is.null(input$publicGroup) || input$publicGroup == "")){
        return(dataPublic())
    } else if(!(is.null(input$privateLevel) || input$privateLevel == "") &&
              !(is.null(input$privateSingletons) || input$privateSingletons == "")){
        return(dataPrivate())
    }
    else if(input$productive == TRUE){
        return(dataProductiveOrUnproductive())
    } else if(!(is.null(input$dropSampleNames) || input$dropSampleNames == "")){
        return(dataDropedSamples())
    } else if(input$doNorm == TRUE){
        return(shannonNormed())
    } else if(input$doDown == TRUE){
        return(downSampling())
    } else {
        return(RepSeqDT())
    }
})














