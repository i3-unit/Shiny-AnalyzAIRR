#--------------------------------------------------------------------------------#
#  statistical analysis - diffferential analysis section
#--------------------------------------------------------------------------------#  
#### Basic Statistics ####

output$plotStats <- renderUI({
    selectGroupStat("plotStats", dataFilt())
})
output$plotStatistic <- renderPlot({
        validate(need(!(is.null(input$plotStats) || input$plotStats == ""), "select stat"))
        plotStatistics(x=dataFilt(), stat = input$plotStats, groupBy = NULL, label_colors = NULL)
    })

output$dataCountFeatures <- renderDataTable({
    validate(need(!(is.null(input$countLevel) || input$countLevel == ""), "select level"))
    validate(need(!(is.null(input$countScale) || input$countScale == ""), "select scale"))
    countFeatures(x=dataFilt(), level = input$countLevel, scale = input$countScale, group = NULL)
})

#### Diversity estimation ####

# render rarefaction selection UI
output$rareChoiceGroup <- renderUI(
    selectGroup("rareGroup", dataFilt())
)
# compute rarefaction table if not existing
#raretable <- reactiveValues(raretab = NULL)
# create reactive
raretabreactive <- reactive({
    if (is.na(match("raretab", names(mData(dataFilt()))))) {
        raretab <- rarefactionTab(dataFilt())
    } else {
        raretab <- mData(dataFilt())$raretab
    }
    return(raretab)
})
#observeEvent(is.RepSeqExperiment(dataFilt()), {
#    raretable$raretab <- raretabreactive()
#})

# plot rarefaction curves
output$rarecurves <- renderPlot({
    validate(need(!(is.null(input$rareGroup) || input$rareGroup == ""), ""))
    sdata <- copy(mData(dataFilt()))
    setDT(sdata, keep.rownames=TRUE)
    names(sdata)[1] <- "sample_id"
    #raretab <- raretable$raretab[sdata, on = "sample_id"]
    raretab <- raretabreactive()[sdata, on = "sample_id"]
    
    mycolors <- colorRampPalette(rev(RColorBrewer::brewer.pal(8, "Set2")))(as.vector(as.matrix(mData(dataFilt())[, unlist(lapply(mData(dataFilt()), is.factor)), drop = FALSE])) %>% unique() %>% length())
    names=as.vector(mData(dataFilt())[, unlist(lapply(mData(dataFilt()), is.factor)), drop = FALSE]) %>% colnames()
    ann_colors<-vector("list")
    for(i in unique(names)){
        
        l<- length(unique(mData(dataFilt())[,i]))
        name<- unique(colnames(mData(dataFilt())[i]))
        mycolors_b<- mycolors[1:l]
        names(mycolors_b) <- levels(mData(dataFilt())[i][[i]])
        
        ann_colors[[name]] <- mycolors_b
        mycolors<- mycolors[!mycolors %in% mycolors_b]
        
    }
    
    
    color_palette<- do.call(rbind, lapply(ann_colors, data.frame))
    color_palette$Group<- rownames(color_palette)
    color_palette<- color_palette %>% filter(grepl(paste(input$rareGroup), Group))
    
    p <- ggplot(data = raretab, aes(x = x, y = y, fill = sample_id, color = get(input$rareGroup))) +
        geom_line() + 
        guides(fill = FALSE) + 
        labs(title = "Rarefaction curves", 
             x = "Number of reads", 
             y = "Number of clonotypes", 
             color = input$rareGroup) +
        scale_x_continuous(breaks = pretty(1:max(raretab$x), n = 13),expand=expansion(mult = c(0.02, .2)))  + #modified by VMH
        
        directlabels::geom_dl(aes(label = sample_id), method = list(directlabels::dl.trans(x = x), "last.bumpup")) +#modified by VMH so the text fits in the plot
        # scale_color_manual(values= colorRampPalette(RColorBrewer::brewer.pal(8, "Set2"))(length(unique(input$rareGroup)))) #added by VMH  
        # scale_color_brewer(palette="Set2")+ #added by VMH
        scale_color_manual(values=color_palette[,1])+ #added by VMH
        theme_light()+ #added by VMH
        theme(axis.text.x = element_text(angle = 45, vjust = 0.5, hjust=.4),  #modified by VMH 
              legend.position = "top",
              aspect.ratio = 0.5, panel.grid.minor = ggplot2::element_blank(),
              panel.grid.major = ggplot2::element_line(colour = "gray89",linetype="dashed",size=0.1)) 
    
    
    return(p)
})
# barplot library
output$libsizes <- plotly::renderPlotly({
    validate(need(!(is.null(input$rareGroup) || input$rareGroup == ""), ""))
    sdata <- mData(dataFilt())
    sdata <- data.frame(libName=rownames(sdata), sdata, check.names = FALSE)
    p <- ggplot(sdata, aes(x = libName, y = nSequences)) +
        geom_bar(stat = "identity", color="gray", alpha=.8) +  #modified by VMH
        xlab("samples") + ylab("Total number of reads") + #modified by VMH
        theme_light()+ #added by VMH
        theme( panel.grid.minor = ggplot2::element_blank(),
               axis.title.x=ggplot2::element_text(size=10),
               axis.text.x = ggplot2::element_text(size=9, angle = 45, hjust=1),
               axis.text.y = ggplot2::element_text(size=9),
               panel.grid.major = ggplot2::element_line(colour = "gray89",linetype="dashed",size=0.1))  #added by VMH
    #scale_x_log10(labels = scales::comma)
    p <- plotly::ggplotly(p)    
    return(p) 
})

# render downsampling choice
output$downlibsize <- renderUI({
    sdata <- mData(dataFilt())
    numericInput(inputId = "libsizechoice", 
                 label = "New lib size",
                 value = min(sdata$nSequences),
                 min = min(sdata$nSequences),
                 max = max(sdata$nSequences),
                 width = NULL
    )
})

# new libsize after downsampling # library sizes
observeEvent(input$down, {
    output$histdownlibsizes <- renderPlot({
        cts1 <- RepSeq::assay(dataFilt()) 
        p1 <- histSums(cts1[, sum(count), by=clone][,V1], xlab="clonotype counts", ylab="Number of clonotypes") + 
            ggtitle("Orignial data - Clonotype count distribution")+
            theme_light()+
            theme( panel.grid.minor = ggplot2::element_blank(),
                   panel.grid.major = ggplot2::element_line(colour = "gray89",linetype="dashed",size=0.1))
        cts2 <- RepSeq::assay(RepSeqDown())
        p2 <- histSums(cts2[, sum(count), by=clone][,V1], xlab="clonotype counts", ylab="Number of clonotypes") +  
            ggtitle("Downsampled data - Clonotype count distribution") +
            theme_light()+
            theme( panel.grid.minor = ggplot2::element_blank(),
                   panel.grid.major = ggplot2::element_line(colour = "gray89",linetype="dashed",size=0.1)) 

        gridExtra::grid.arrange(p1, p2, ncol=2)
    })    
})
# select data
dat <- eventReactive(c(input$samplingchoice, input$down), {
    if (input$samplingchoice == "N") {
        return(dataFilt())
    } else {
        return(RepSeqDown())
    }
})
# information
output$dataselected <- renderText({
    if (input$samplingchoice == "Y" & input$down == 1) {
        txt <- "Results"   #modified by VMH
    } else {
        txt <- "" #modified by VMH
    }
    return(txt)
})

output$plotDiv <- renderPlot({
    validate(need(!(is.null(input$divIndex) || input$divIndex == ""), "select index"))
    validate(need(!(is.null(input$divLevel) || input$divLevel == ""), "select level"))
    plotDiversity(x=dataFilt(), index = input$divIndex, level = input$divLevel, groupBy = NULL, label_colors = NULL)
})

output$dataDiv <- renderDataTable({
    validate(need(!(is.null(input$divLevel) || input$divLevel == ""), "select level"))
    diversityIndices(x=dataFilt(), level = input$divLevel)
})


output$plotRenyi <- renderPlot({
    validate(need(!(is.null(input$renyiLevel) || input$renyiLevel == ""), "select level"))
    plotRenyiIndex(x=dataFilt(), level = input$renyiLevel, colorBy = NULL, grouped = FALSE, label_colors = NULL)
})

output$dataRenyi <- renderDataTable({
    validate(need(!(is.null(input$renyiLevel) || input$renyiLevel == ""), "select level"))
    renyiIndex(x=dataFilt(), level = input$renyiLevel)
})

output$countIntGroup <- renderUI({
    selectGroup(ID = "countIntGroup", x = dataFilt())
})

output$CountIntervals <- renderPlot({
    validate(need(!(is.null(input$countIntLevel) || input$countIntLevel == ""), "select level"))
    validate(need(!(is.null(input$countIntGroup) || input$countIntGroup == ""), "select group"))
    plotCountIntervals(x=dataFilt(), level = input$countIntLevel, groupBy = input$countIntGroup, label_colors = NULL)
})


# plot VJ distribution
output$rankDistrib <- renderPlot({
    validate(need(!(is.null(input$rankDistribGroupMeth) || input$rankDistribGroupMeth == ""), "select scale"))
    validate(need(!(is.null(input$rankDistribLevel) || input$rankDistribLevel == ""), "select level"))
    plotRankDistrib(x = dat(), level = input$rankDistribLevel, scale = input$rankDistribGroupMeth, colorBy = "sample_id", grouped = FALSE, label_colors = NULL)
})

