#-------------------------------------------------------------------------------------------------------------------------------------------#
#  Generate side menu section
#-------------------------------------------------------------------------------------------------------------------------------------------#  
# open if RepSeqDT() is loaded
observeEvent(is.RepSeqExperiment(RepSeqDT()), {
    # render menu show data
    output$showDataTab <- renderMenu({
    convertMenuItem(
        menuItem(tabName = "showDataTab",
            text = "Data manipulation",
            icon = icon("table"),
            menuSubItem("show assay data",
                tabName = "showAssayTab"),
            menuSubItem("show sample info",
                tabName = "showInfoTab"),
            menuSubItem("show metadata",
                tabName = "showMetaTab"),
            menuSubItem("show history",
                tabName = "showHistoryTab"),
            menuSubItem("compute diversity indices",
                tabName = "computeDiversity")
        ), tabName = "showDataTab"
    )
    })
    # render single sample menu
    output$singleSampleTab <- renderMenu({
        convertMenuItem(
            menuItem(tabName = "singleSampleTab",
                text = "One-sample analysis",
                icon = icon("user"),
                selectSample("singleSample", rownames(RepSeq::mData(RepSeqDT()))),
                radioButtons("singleScale", "Choose a scale",
                    choices = c("count", "frequency"), #VMH replaced "percent" with "frequency"
                    selected = character(0),
                    inline = T)
            ), "singleSampleTab")
    })
    # render multiple samples comparison menu
    output$multipleSampleTab <- renderMenu({
        convertMenuItem(
            menuItem(
                text = "Multi-sample analysis",
                icon = icon("users", lib = "font-awesome"),
                tabName = "multipleSampleTab"
            ), 
            "multipleSampleTab"
        )
    })
    # render statistic menu       
    output$statisticTab <- renderMenu({
        menuItem(tabName = "statisticTab",
            text = "Exploratory statistics",
            icon = icon("square-root-alt", lib="font-awesome")
        )
    })
    # down load RDS freshly created 
    output$downloadRDS <- renderMenu({
        menuItem("Download RDS file",
            icon = icon("download"),
            tabName = "DownloadRDS")
    })
    # show summary of the RepSeqExperiment object  
    output$summaryRDS <- output$summaryTXT <- renderUI({
        #flush.console()
        printHtml(RepSeqDT())
    })

    # library sizes
    output$histlibsizes <- renderPlot({
        cts <- RepSeq::assay(RepSeqDT()) 
        p1 <- histSums(cts[, sum(count), by=sample_id][,V1], xlab="Read count", ylab="Number of samples") + ggtitle("Read count in data")+theme_light()+theme( panel.grid.minor = element_blank(),legend.position ="top",
                                                                                                                                                                panel.grid.major = element_line(colour = "gray89",linetype="dashed",size=0.1)) #modified by VMH
        p2 <- histSums(cts[, sum(count), by=clone][,V1], xlab="clonotype count", ylab="Total number of clonotypes") + ggtitle("Clonotype count distribution across all samples") +theme_light()+theme( panel.grid.minor = element_blank(),legend.position ="top",
                                                                                                                                                                                                panel.grid.major = element_line(colour = "gray89",linetype="dashed",size=0.1)) #modified by VMH
        gridExtra::grid.arrange(p1, p2, ncol=2)
    })        
}) # end observeEvent RepSeqDT() is loaded
  
