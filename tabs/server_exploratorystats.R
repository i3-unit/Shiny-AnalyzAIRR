#--------------------------------------------------------------------------------#
#  statistical analysis - diffferential analysis section
#--------------------------------------------------------------------------------#  
#### Basic Statistics ####

output$statGroup <- renderUI({
    validate(need(!(is.null(input$plotStats) || input$plotStats ==""), " "))
    selectGroup(ID = "statGroup", x = RepSeqDT())
})

output$plotStats <- renderUI({
    selectGroupStat("plotStats", RepSeqDT())
})
output$plotStatistic <- renderPlot({
        validate(need(!(is.null(input$plotStats) || input$plotStats == ""), "select stat"))
        validate(need(!(is.null(input$statGroup) || input$statGroup == ""), "select group"))
        plotStatistics(x=RepSeqDT(), stat = input$plotStats, groupBy = input$statGroup, label_colors = NULL)
    })

output$dataCountFeatures <- renderDataTable({
    validate(need(!(is.null(input$countLevel) || input$countLevel == ""), "select level"))
    validate(need(!(is.null(input$countScale) || input$countScale == ""), "select scale"))
    countFeatures(x=RepSeqDT(), level = input$countLevel, scale = input$countScale, group = NULL)
})

#### Diversity estimation ####

# render rarefaction selection UI
output$rareChoiceGroup <- renderUI(
    selectGroupDE("rareGroup", RepSeqDT())
)
# compute rarefaction table if not existing
#raretable <- reactiveValues(raretab = NULL)
# create reactive
raretabreactive <- reactive({
    if (is.na(match("raretab", names(mData(RepSeqDT()))))) {
        raretab <- rarefactionTab(RepSeqDT())
    } else {
        raretab <- mData(RepSeqDT())$raretab
    }
    return(raretab)
})
#observeEvent(is.RepSeqExperiment(RepSeqDT()), {
#    raretable$raretab <- raretabreactive()
#})

# plot rarefaction curves
output$rarecurves <- renderPlot({
    validate(need(!(is.null(input$rareGroup) || input$rareGroup == ""), ""))
    sdata <- copy(mData(RepSeqDT()))
    setDT(sdata, keep.rownames=TRUE)
    names(sdata)[1] <- "sample_id"
    #raretab <- raretable$raretab[sdata, on = "sample_id"]
    raretab <- raretabreactive()[sdata, on = "sample_id"]
    
    mycolors <- colorRampPalette(rev(RColorBrewer::brewer.pal(8, "Set2")))(as.vector(as.matrix(mData(RepSeqDT())[, unlist(lapply(mData(RepSeqDT()), is.factor)), drop = FALSE])) %>% unique() %>% length())
    names=as.vector(mData(RepSeqDT())[, unlist(lapply(mData(RepSeqDT()), is.factor)), drop = FALSE]) %>% colnames()
    ann_colors<-vector("list")
    for(i in unique(names)){
        
        l<- length(unique(mData(RepSeqDT())[,i]))
        name<- unique(colnames(mData(RepSeqDT())[i]))
        mycolors_b<- mycolors[1:l]
        names(mycolors_b) <- levels(mData(RepSeqDT())[i][[i]])
        
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
    sdata <- mData(RepSeqDT())
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
    sdata <- mData(RepSeqDT())
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
        cts1 <- RepSeq::assay(RepSeqDT()) 
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
        return(RepSeqDT())
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


output$divGroup <- renderUI({
    selectGroup(ID = "divGroup", x = RepSeqDT())
})

output$plotDiv <- renderPlot({
    validate(need(!(is.null(input$divIndex) || input$divIndex == ""), "select index"))
    validate(need(!(is.null(input$divLevel) || input$divLevel == ""), "select level"))
    validate(need(!(is.null(input$divGroup) || input$divGroup == ""), "select group"))
    plotDiversity(x=RepSeqDT(), index = input$divIndex, level = input$divLevel, groupBy = input$divGroup, label_colors = NULL)
})

output$dataDiv <- renderDataTable({
    validate(need(!(is.null(input$divLevel) || input$divLevel == ""), "select level"))
    diversityIndices(x=RepSeqDT(), level = input$divLevel)
})


output$renyiGroup <- renderUI({
    selectGroup(ID = "renyiGroup", x = RepSeqDT())
})

output$plotRenyi <- renderPlot({
    validate(need(!(is.null(input$renyiLevel) || input$renyiLevel == ""), "select level"))
    validate(need(!(is.null(input$renyiGroup) || input$renyiGroup == ""), "select group"))
    plotRenyiIndex(x=RepSeqDT(), level = input$renyiLevel, colorBy = input$renyiGroup, grouped = FALSE, label_colors = NULL)
})

output$dataRenyi <- renderDataTable({
    validate(need(!(is.null(input$renyiLevel) || input$renyiLevel == ""), "select level"))
    renyiIndex(x=RepSeqDT(), level = input$renyiLevel)
})

output$countIntGroup <- renderUI({
    selectGroup(ID = "countIntGroup", x = RepSeqDT())
})

output$CountIntervals <- renderPlot({
    validate(need(!(is.null(input$countIntLevel) || input$countIntLevel == ""), "select level"))
    validate(need(!(is.null(input$countIntGroup) || input$countIntGroup == ""), "select group"))
    plotCountIntervals(x=RepSeqDT(), level = input$countIntLevel, groupBy = input$countIntGroup, label_colors = NULL)
})

# render rank distribution
output$rankDistribGroup <- renderUI(
    selectGroup("rankDistribGroup", RepSeqDT())
)
# plot VJ distribution
output$rankDistrib <- renderPlot({
    validate(need(!(is.null(input$rankDistribGroupMeth) || input$rankDistribGroupMeth == ""), "select scale"))
    validate(need(!(is.null(input$rankDistribLevel) || input$rankDistribLevel == ""), "select level"))
    validate(need(!(is.null(input$rankDistribGroup) || input$rankDistribGroup == ""), "select group"))
    plotRankDistrib(x = dat(), level = input$rankDistribLevel, scale = input$rankDistribGroupMeth, colorBy = input$rankDistribGroup, grouped = FALSE, label_colors = NULL)
})

