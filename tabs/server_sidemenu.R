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
            menuSubItem("Data extraction",
                tabName = "showInfoTab", icon = icon("angle-double-right", verify_fa = FALSE)),
            menuSubItem("Filtering",
                tabName = "showFiltTab", icon = icon("angle-double-right", verify_fa = FALSE)),
            menuSubItem("Normalization",
                tabName = "showNormTab", icon = icon("angle-double-right", verify_fa = FALSE))
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
                           tabName = "showBasicTab", icon = icon("angle-double-right", verify_fa = FALSE)),
               menuSubItem("Diversity estimation",
                           tabName = "showDivTab", icon = icon("angle-double-right", verify_fa = FALSE)),
               menuSubItem("Clonal distribution",
                           tabName = "showClonalTab", icon = icon("angle-double-right", verify_fa = FALSE))
        ), tabName = "statisticTab"
      )
    })
    # render single sample menu
    output$singleSampleTab <- renderMenu({
        convertMenuItem(
            menuItem(tabName = "singleSampleTab",
                text = "One-sample analysis",
                icon = icon("user", verify_fa = FALSE),
                selectSample("singleSample", rownames(RepSeq::mData(dataFilt()))),
                radioButtons("singleScale", "Choose a scale",
                    choices = c("count", "frequency"), 
                    selected = character(0),
                    inline = T)
            ), "singleSampleTab")
    })
    # render multiple samples comparison menu
    output$multipleSampleTab <- renderMenu({
        convertMenuItem(
            menuItem(tabName = "multipleSampleTab",
                text = "Multi-sample analysis",
                icon = icon("users", lib = "font-awesome", verify_fa = FALSE),
                menuSubItem("Comparison of basic statistics",
                            tabName = "showCompBasicTab", icon = icon("angle-double-right", verify_fa = FALSE)),
                menuSubItem("Similarity analysis",
                            tabName = "showSimTab", icon = icon("angle-double-right", verify_fa = FALSE)),
                menuSubItem("Differential analysis",
                            tabName = "showDiffTab", icon = icon("angle-double-right", verify_fa = FALSE)),
                menuSubItem("Pertubation score",
                            tabName = "showPertTab", icon = icon("angle-double-right", verify_fa = FALSE))
            ), tabName = "multipleSampleTab"
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
        printHtml(dataFilt())
    })
    
    output$downloadNewRepSeq <- downloadHandler(
      "RepSeqData.rds",
      
      content = function(file) {
        saveRDS(RepSeqDT(), file)
      }, 
    ) 
    
    # library sizes
    output$histlibsizesp1 <- renderPlot({
        cts<- RepSeq::assay(dataFilt())
        p1<-histSums(cts[,sum(count), by="sample_id"][,V1], xlab="Number of sequences",ylab="Number of samples")
        
        p1
        
    }) 
    
    output$downPlothistlibsizesp1 <- renderUI({
        downloadButton("Plothistlibsizesp1", "Download PDF")
    }) 
    
    output$Plothistlibsizesp1 <- downloadHandler(
      filename =  function() {
        paste0("histlibsizes_summary.pdf")
      },
      # content is a function with argument file. content writes the plot to the device
      content = function(file) {
        pdf(file, height=4, width=6)
        cts<- RepSeq::assay(dataFilt())
        grid.draw(histSums(cts[,sum(count), by="sample_id"][,V1], xlab="Number of sequences",ylab="Number of samples"))
        dev.off()
      }
    )
    
    output$histlibsizesp2 <- renderPlot({
      validate(need(!(is.null(input$summaryLevel) || input$summaryLevel == ""), "select a level"))
      
      cts<- RepSeq::assay(dataFilt())
      p2<-histSums(cts[,sum(count), by=eval(input$summaryLevel)][,V1], xlab="count",ylab=paste("Number of", input$summaryLevel))
      
      p2
    })
    
    output$downPlothistlibsizesp2 <- renderUI({
      if (!is.null(input$summaryLevel)) {
        downloadButton("Plothistlibsizesp2", "Download PDF")
      }
    }) 
    
    output$Plothistlibsizesp2 <- downloadHandler(
      filename =  function() {
        paste0("histlibsizes_summary_", eval(input$summaryLevel),".pdf")
      },
      # content is a function with argument file. content writes the plot to the device
      content = function(file) {
        pdf(file, height=4, width=6)
        cts<- RepSeq::assay(dataFilt())
        grid.draw(histSums(cts[,sum(count), by=eval(input$summaryLevel)][,V1], xlab="count",ylab=paste("Number of", input$summaryLevel)))
        dev.off()
      }
    )
    
    output$histtxtlibsizesp1 <- renderPlot({
      cts<- RepSeq::assay(dataFilt())
      p1<-histSums(cts[,sum(count), by="sample_id"][,V1], xlab="Number of sequences",ylab="Number of samples")
      
      p1
    }) 
    output$downPlothisttxtlibsizesp1 <- renderUI({
      downloadButton("Plothisttxtlibsizesp1", "Download PDF")
    }) 
    
    output$Plothisttxtlibsizesp1 <- downloadHandler(
      filename =  function() {
        paste0("histlibsizes_summary.pdf")
      },
      # content is a function with argument file. content writes the plot to the device
      content = function(file) {
        pdf(file, height=4, width=6)
        cts<- RepSeq::assay(dataFilt())
        grid.draw(histSums(cts[,sum(count), by="sample_id"][,V1], xlab="Number of sequences",ylab="Number of samples"))
        dev.off()
      }
    )
    output$histtxtlibsizesp2 <- renderPlot({
      validate(need(!(is.null(input$summaryTXTLevel) || input$summaryTXTLevel == ""), "select a level"))
      cts<- RepSeq::assay(dataFilt())
      p2<-histSums(cts[,sum(count), by=eval(input$summaryTXTLevel)][,V1], xlab="count",ylab=paste("Number of", input$summaryTXTLevel))
      
      p2
    }) 
    
    output$downPlothisttxtlibsizesp2 <- renderUI({
      if (!is.null(input$summaryLevel)) {
        downloadButton("Plothisttxtlibsizesp2", "Download PDF")
      }
    }) 
    
    output$Plothisttxtlibsizesp2 <- downloadHandler(
      filename =  function() {
        paste0("histlibsizes_summary_", eval(input$summaryTXTLevel),".pdf")
      },
      # content is a function with argument file. content writes the plot to the device
      content = function(file) {
        pdf(file, height=4, width=6)
        cts<- RepSeq::assay(dataFilt())
        grid.draw(histSums(cts[,sum(count), by=eval(input$summaryTXTLevel)][,V1], xlab="count",ylab=paste("Number of", input$summaryTXTLevel)))
        dev.off()
      }
    )
}) # end observeEvent RepSeqDT() is loaded
  
