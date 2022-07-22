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
            icon = icon("table", verify_fa = FALSE),
            menuSubItem("show assay data",
                tabName = "showAssayTab", icon = icon("angle-double-right", verify = FALSE)),
            menuSubItem("show metadata",
                tabName = "showInfoTab", icon = icon("angle-double-right", verify = FALSE)),
            menuSubItem("show other data",
                tabName = "showMetaTab", icon = icon("angle-double-right", verify = FALSE)),
            menuSubItem("show history",
                tabName = "showHistoryTab", icon = icon("angle-double-right", verify = FALSE))
        ), tabName = "showDataTab"
    )
    })
    # render statistic menu       
    output$statisticTab <- renderMenu({
      convertMenuItem(
        menuItem(tabName = "statisticTab",
               text = "Exploratory statistics",
               icon = icon("square-root-alt", lib="font-awesome", verify_fa = FALSE),
               menuSubItem("Basic statistics",
                           tabName = "showBasicTab", icon = icon("angle-double-right", verify = FALSE)),
               menuSubItem("Diversity estimation",
                           tabName = "showDivTab", icon = icon("angle-double-right", verify = FALSE)),
               menuSubItem("Clonal distribution",
                           tabName = "showClonalTab", icon = icon("angle-double-right", verify = FALSE))
        ), tabName = "statisticTab"
      )
    })
    # render single sample menu
    output$singleSampleTab <- renderMenu({
        convertMenuItem(
            menuItem(tabName = "singleSampleTab",
                text = "One-sample analysis",
                icon = icon("user", verify_fa = FALSE),
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
                icon = icon("users", lib = "font-awesome", verify_fa = FALSE),
                tabName = "multipleSampleTab"
            ), 
            "multipleSampleTab"
        )
    })

    # down load RDS freshly created 
    output$downloadRDS <- renderMenu({
        menuItem("Download RDS file",
            icon = icon("download", verify_fa = FALSE),
            tabName = "DownloadRDS")
    })
    # show summary of the RepSeqExperiment object  
    output$summaryRDS <- output$summaryTXT <- renderUI({
        #flush.console()
        printHtml(RepSeqDT())
    })

    # library sizes
    output$histlibsizes <- renderPlot({
        # p1 <- histSums(cts[, sum(count), by=sample_id][,V1], xlab="Read count", ylab="Number of samples") + ggtitle("Read count in data")+theme_light()+theme( panel.grid.minor = element_blank(),legend.position ="top",
        #                                                                                                                                                         panel.grid.major = element_line(colour = "gray89",linetype="dashed",size=0.1)) #modified by VMH
        # 
        p1 <- summary_hist(x=RepSeqDT(), level="VJ")
        validate(need(!(is.null(input$summaryLevel) || input$summaryLevel == ""), "select level"))
        p2 <- summary_hist2(x=RepSeqDT(), level=input$summaryLevel)
        
        gridExtra::grid.arrange(p1, p2, ncol=2)
    })        
}) # end observeEvent RepSeqDT() is loaded
  
