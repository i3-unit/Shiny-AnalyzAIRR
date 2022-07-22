#--------------------------------------------------------------------------------#
#  statistical analysis - diffferential analysis section
#--------------------------------------------------------------------------------#  
    # render select group UI
    # output$DEGroupUI <- renderUI({
    #     validate(need(!(is.null(input$DERepLevel) || input$DERepLevel == ""), "select level"))
    #     selectGroupDE("DEGroup", RepSeqDT())
    # })
    # # create data DESEq2 
    # dataDESeq <- reactive({
    #     validate(need(!(is.null(input$DERepLevel) || input$DERepLevel == ""), ""))
    #     validate(need(!(is.null(input$DEGroup) || input$DEGroup == ""), ""))
    #     datatabDESeq2 <- RepSeq::toDESeq2(RepSeqDT(), conditions=input$DEGroup, level=input$DERepLevel)
    #     datatabDESeq2 <- DESeq2::estimateSizeFactors(datatabDESeq2, type="poscounts")
    #     datatabDESeq2 <- DESeq2::DESeq(datatabDESeq2, fitType="local")
    #     return(datatabDESeq2)
    # })
    # # plot normalized PCA (not run)
    # output$DEplotPCA <- renderPlot({
    #     #validate(need(!(is.null(input$DERepLevel) || input$DERepLevel == ""), ""))
    #     #validate(need(!(is.null(input$DEGroup) || input$DEGroup == ""), ""))    
    #     vsd <- DESeq2::varianceStabilizingTransformation(dataDESeq())
    #     datapca <- DESeq2::plotPCA(vsd, intgroup=input$DEGroup, returnData = TRUE)
    #     percentVar <- round(100 * attr(datapca, "percentVar"))
    #     p <- ggplot2::ggplot(datapca, ggplot2::aes_string(x="PC1", y="PC2", color=input$DEGroup)) + ggplot2::geom_point(size=4) + 
    #             ggplot2::xlab(paste0("PC1: ", percentVar[1], "% variance")) +
    #             ggplot2::ylab(paste0("PC2: ", percentVar[2], "% variance")) + 
    #             ggplot2::ggtitle("Principal Component Analysis") +
    #             ggplot2::coord_fixed(ratio=2)
    #     
    #           
    #     print(p)
    # })
    # # plotly PCA performed on normalised data (method vst).
    # output$plotlyPCA <- plotly::renderPlotly({
    #     validate(need(!(is.null(input$DERepLevel) || input$DERepLevel == ""), ""))
    #     validate(need(!(is.null(input$DEGroup) || input$DEGroup == ""), ""))    
    #     vsd <- DESeq2::varianceStabilizingTransformation(dataDESeq())
    #     datapca <- DESeq2::plotPCA(vsd, intgroup=input$DEGroup, returnData = TRUE)
    #     percentVar <- round(100 * attr(datapca, "percentVar"))
    #     
    #     mycolors <- colorRampPalette(rev(RColorBrewer::brewer.pal(8, "Set2")))(as.vector(as.matrix(mData(RepSeqDT())[, unlist(lapply(mData(RepSeqDT()), is.factor)), drop = FALSE])) %>% unique() %>% length())
    #     names=as.vector(mData(RepSeqDT())[, unlist(lapply(mData(RepSeqDT()), is.factor)), drop = FALSE]) %>% colnames()
    #     ann_colors<-vector("list")
    #     for(i in unique(names)){
    #       
    #       l<- length(unique(mData(RepSeqDT())[,i]))
    #       name<- unique(colnames(mData(RepSeqDT())[i]))
    #       mycolors_b<- mycolors[1:l]
    #       names(mycolors_b) <- levels(mData(RepSeqDT())[i][[i]])
    #       
    #       ann_colors[[name]] <- mycolors_b
    #       mycolors<- mycolors[!mycolors %in% mycolors_b]
    #       
    #     }
    #     
    #     color_palette<- do.call(rbind, lapply(ann_colors, data.frame))
    #     color_palette$Group<- rownames(color_palette)
    #     color_palette<- color_palette %>% filter(grepl(paste(input$DEGroup), Group))
    #     
    #     
    #     
    #     p <- ggplot2::ggplot(datapca, ggplot2::aes_string(x="PC1", y="PC2", color=input$DEGroup)) + 
    #             ggplot2::geom_point(aes(text=rownames(datapca)), size=1) + 
    #             ggplot2::xlab(paste0("PC1: ", percentVar[1], "% variance")) +
    #             ggplot2::ylab(paste0("PC2: ", percentVar[2], "% variance")) + 
    #             ggplot2::ggtitle("Principal Component Analysis") +
    #       # ggplot2::scale_color_manual(values= colorRampPalette(RColorBrewer::brewer.pal(8, "Set2"))(length(unique(input$DEGroup))))+
    #       # ggplot2::scale_color_brewer(palette="Set2")+        #added by VMH
    #       ggplot2::scale_color_manual(values=color_palette[,1])+
    #       
    #       ggplot2::theme_light()+   #added by VMH
    #             ggplot2::theme(
    #                 axis.text = element_text(size = 10),  #modified by VMH
    #                 axis.title = element_text(size = 12),  #modified by VMH
    #                 #legend.text = element_text(size = 12),
    #                 #legend.title = element_text(size = 16 ,face="bold"),
    #                 legend.title = element_blank(),
    #                 plot.title = element_text(size = 13, hjust = 0.5),
    #                 aspect.ratio = 1,
    #                    panel.grid.minor = element_blank(),
    #                    panel.grid.major = element_line(colour = "gray89",linetype="dashed",size=0.1))  #added by VMH        
    #     
    #     
    #     p <- plotly::ggplotly(p, type = "scatter")
    #     return(p)
    # })
    # # render 2by2 comparison
    # output$DEcontrasts <- renderUI({
    #     validate(need(!(is.null(input$DERepLevel) || input$DERepLevel == ""), ""))
    #     validate(need(!(is.null(input$DEGroup) || input$DEGroup == ""), ""))
    #     selectizeInput("GrpSelect",
    #         "Comparison",
    #         choices = levels(SummarizedExperiment::colData(dataDESeq())[, input$DEGroup]),
    #         options = list(maxItems = 2, onInitialize = I('function() { this.setValue(""); }')),
    #         multiple = T
    #     )
    # })
    # # create DESeq2 result tab
    # DESeqRes <- reactive({
    #     validate(need(!(is.null(input$DERepLevel) || input$DERepLevel == ""), ""))
    #     validate(need(!(is.null(input$DEGroup) || input$DEGroup == ""), ""))
    #     validate(need(!(is.null(input$GrpSelect) || input$GrpSelect == ""), "select first group"))
    #     validate(need(length(input$GrpSelect)==2, "select second group"))
    #     res <- DESeq2::results(dataDESeq(), contrast=c(input$DEGroup, input$GrpSelect))
    #     res <- res[order(res$padj),]    
    #     return(as.data.frame(res))
    # })
    # # create volcano plot not used
    # output$volcanoDESeq2 <- renderPlot({
    #     tmp <- DESeqRes()
    #     tmp <- tmp[!is.na(tmp$padj), ]
    #     with(tmp, plot(log2FoldChange, -log10(padj), pch=20,  cex=1.0, 
    #             xlab=bquote(~Log[2]~fold~change), 
    #             ylab=bquote(~-log[10]~adj~pvalue)), title(main=paste0("Volcano plot: ", input$DEGroup)))
    #     with(subset(tmp, padj<0.05 & abs(log2FoldChange)>2), points(log2FoldChange, -log10(padj), pch=20, col="red", cex=0.5))
    #     #Add lines for absolute FC>2 and P-value cut-off at FDR Q<0.05
    #     abline(v=0, col="black", lty=3, lwd=1.0)
    #     abline(v=-2, col="black", lty=4, lwd=2.0)
    #     abline(v=2, col="black", lty=4, lwd=2.0)
    #     if (length(tmp$pvalue[tmp$padj<0.05])>0) {
    #         abline(h=-log10(max(tmp$pvalue[tmp$padj<0.05], na.rm=TRUE)), col="black", lty=4, lwd=2.0)
    #         gn.selected <- abs(tmp$log2FoldChange) > 2.5 & tmp$padj < 0.01
    #         if (any(gn.selected)) text(tmp$log2FoldChange[gn.selected], -log10(tmp$padj)[gn.selected], lab=rownames(tmp)[gn.selected], cex=0.6, pos=2)
    #     }
    # })
    # # volcano plot plotly
    # output$volc <- plotly::renderPlotly({
    #     degTab <- DESeqRes()
    #     degTab <- degTab[!is.na(degTab$padj), ]
    #     data.table::setDT(degTab, keep.rownames=TRUE)
    #     degTab[, group := "Other"]  #modified by VMH
    #     # change the grouping for the entries with both significance and large enough fold change
    #     degTab[padj < 0.05 & abs(log2FoldChange) >= 2, group := "Significant & FoldChange"]
    #     # change the grouping for the entries with significance but not a large enough Fold change
    #     degTab[padj < 0.05 & abs(log2FoldChange) < 2, group := "Other"]    #modified by VMH
    #     # change the grouping for the entries a large enough Fold change but not a low enough p value
    #     degTab[padj > 0.05 & abs(log2FoldChange) >= 2, group := "Other"]   #modified by VMH
    #     degTab[, BHpvalue := -log10(padj)] 
    #     a <- list( title = "log2(FC)")  #modified by VMH
    #     b <- list(title = "-log10(padj)")  #modified by VMH
    #     p <- degTab[, plotly::plot_ly(x = log2FoldChange, y = BHpvalue, text = rn, mode = "markers", color = group,  colors = c("grey50", "red"),type = "scatter")] #VMH added colors
    #     p <- p %>% plotly::layout(title = list(text="Volcano Plot",
    #                                 xanchor = "right")) %>% #modified by VMH
    #       plotly::layout(legend = list(orientation = 'h',  x = .5,y = 100), yaxis = b, xaxis = a) %>% #modified by VMH
    #       plotly::toWebGL()
    #     p$elementId <- NULL
    #     print(p)
    # })
    # #
    # # render DESeq2 results 
    # output$DETab <- renderDataTable({
    #     return(datatable(DESeqRes(), options = list(scrollX=TRUE, dom = 'Bfrtip', buttons = c('copy', 'csv', 'excel'), pageLength = 10)) %>% formatRound(c(1:4), 2) %>% formatRound(c(5:6), 4))
    #     }, server=FALSE
    # )
    # # render text 
    # output$selectedLevel <- renderText({ 
    #     validate(need(!(is.null(input$GrpSelect) || input$GrpSelect == ""), ""))
    #     validate(need(length(input$GrpSelect)==2, ""))    
    #     s <- rownames(DESeqRes())[input$DETab_rows_selected]
    #     paste("Assay data for combination of level", input$DERepLevel, ":", s)
    # })
    # # get data for selected row
    # output$SelectedRow <- renderDataTable({
    #     validate(need(!(is.null(input$GrpSelect) || input$GrpSelect == ""), ""))
    #     validate(need(length(input$GrpSelect)==2, ""))
    #     validate(need(!(is.null(input$DETab_rows_selected) || input$DETab_rows_selected == ""), "select row"))
    #     s <- rownames(DESeqRes())[input$DETab_rows_selected]
    #     dcast(RepSeq::assay(RepSeqDT())[get(input$DERepLevel) %in% s], VpJ~lib, value.var="count", fun.aggregate=sum)
    #     }, style="bootstrap", extensions = 'Buttons', options=list(scrollX=TRUE, dom = 'Bfrtip', buttons = c('copy', 'csv', 'excel'))
    # )

#### Basic Statistics ####

output$statGroup <- renderUI({
    validate(need(!(is.null(input$plotStats) || input$plotStats ==""), " "))
    selectGroup(ID = "statGroup", x = RepSeqDT())
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
        p1 <- histSums(cts1[, sum(count), by=clone][,V1], xlab="clonotype counts", ylab="Number of clonotypes") + #modified by VMH 
            ggtitle("Orignial data - Clonotype count distribution")+ #modified by VMH
            theme_light()+ #added by VMH
            theme( panel.grid.minor = ggplot2::element_blank(),
                   panel.grid.major = ggplot2::element_line(colour = "gray89",linetype="dashed",size=0.1)) #added by VMH
        #if (is.null(RepSeqDown())) {
        #    p2 <- ggplot() +
        #            theme_void() +
        #            geom_text(aes(0,0,label='N/A')) +
        #            xlab(NULL) #optional, but safer in case another theme is applied later
        #} else {
        cts2 <- RepSeq::assay(RepSeqDown())
        p2 <- histSums(cts2[, sum(count), by=clone][,V1], xlab="clonotype counts", ylab="Number of clonotypes") + #modified by VMH 
            ggtitle("Downsampled data - Clonotype count distribution") +  #modified by VMH
            theme_light()+ #added by VMH
            theme( panel.grid.minor = ggplot2::element_blank(),
                   panel.grid.major = ggplot2::element_line(colour = "gray89",linetype="dashed",size=0.1)) #added by VMH
        
        #}
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
    validate(need(!(is.null(input$divLevel) || input$renyiLevel == ""), "select level"))
    validate(need(!(is.null(input$renyiGroup) || input$renyiGroup == ""), "select group"))
    plotRenyiIndex(x=RepSeqDT(), level = input$renyiLevel, colorBy = input$renyiGroup, grouped = FALSE, label_colors = NULL)
})

output$dataRenyi <- renderDataTable({
    validate(need(!(is.null(input$renyiLevel) || input$renyiLevel == ""), "select level"))
    renyiIndex(x=RepSeqDT(), level = input$renyiLevel)
})








