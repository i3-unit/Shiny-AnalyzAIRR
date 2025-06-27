#-------------------------------------------------------------------------------------------------------------------------------------------#
#  Generate side menu section
#-------------------------------------------------------------------------------------------------------------------------------------------#  
# open if RepSeqDT() is loaded
observeEvent(is.RepSeqExperiment(RepSeqDT()), {
    # render statistic menu       
    output$statisticTab <- renderMenu({
      convertMenuItem(
        menuItem(tabName = "statisticTab",
               text = "Exploratory analysis",
               icon = icon("square-root-alt", lib="font-awesome", verify_fa = FALSE),
               startExpanded = TRUE,
               menuSubItem("Basic statistics",
                           tabName = "showBasicTab", icon = icon("angle-double-right", verify_fa = FALSE)),
               menuSubItem("Repertoire Diversity",
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
                text = "Single sample analysis",
                icon = icon("user", verify_fa = FALSE),
                selectSample("singleSample", rownames(AnalyzAIRR::mData(dataFilt())))
                # radioButtons("singleScale", "Choose a scale",
                #     choices = c("count", "frequency"), 
                #     selected = character(0),
                #     inline = T)
            ), "singleSampleTab")
    })
    # render menu manipulation
    output$showDataTab <- renderMenu({
      convertMenuItem(
        menuItem(tabName = "showDataTab",
                 text = "Data manipulation",
                 icon = icon("table", verify_fa = FALSE),
                 startExpanded = TRUE,
                 menuSubItem("Data extraction",
                             tabName = "showInfoTab", icon = icon("angle-double-right", verify_fa = FALSE)),
                 menuSubItem("Filtering",
                             tabName = "showFiltTab", icon = icon("angle-double-right", verify_fa = FALSE)),
                 menuSubItem("Normalization",
                             tabName = "showNormTab", icon = icon("angle-double-right", verify_fa = FALSE))
        ),
        tabName = "showDataTab"
      )
    })
    # render multiple samples comparison menu
    output$multipleSampleTab <- renderMenu({
      if(input$putInfofile == "Yes" || !is.null(input$RDSfile)){
        convertMenuItem(
            menuItem(tabName = "multipleSampleTab",
                text = "Multi-sample analysis",
                icon = icon("users", lib = "font-awesome", verify_fa = FALSE),
                startExpanded = TRUE,
                menuSubItem("Comparison of basic statistics",
                            tabName = "showCompBasicTab", icon = icon("angle-double-right", verify_fa = FALSE)),
                menuSubItem("Similarity analysis",
                            tabName = "showSimTab", icon = icon("angle-double-right", verify_fa = FALSE)),
                menuSubItem("Differential analysis",
                            tabName = "showDiffTab", icon = icon("angle-double-right", verify_fa = FALSE))                #menuSubItem("Spectratyping comparison",
                           # tabName = "showPertTab", icon = icon("angle-double-right", verify_fa = FALSE))
            ), tabName = "multipleSampleTab"
        )} else shinyjs::hide(selector = "a[data-value='multipleSampleTab']")
    })
    output$sessionReportTab <- renderMenu({
      convertMenuItem(
        menuItem(tabName = "sessionReportTab",
          selected = F,
          text = "Session Report",
          icon = icon('list', verify_fa = FALSE)
          ), tabName = "sessionReportTab"
      )
    })
    # down load RDS freshly created 
    output$downloadRDS <- renderMenu({
        menuItem("Download RepSeqexperiment",
            icon = icon("download", verify_fa = FALSE),
            tabName = "DownloadRDS")
    })
    # show summary of the RepSeqExperiment object  
    # output$summaryRDS <- output$summaryTXT <- renderUI({
    #     #flush.console()
    #     printHtml(dataFilt())
    # })
    
    # number of samples
    output$summaryNb <- renderValueBox({
     
        metadata <- AnalyzAIRR::mData(dataFilt())
        p<- nrow(metadata)
        
        valueBox(p, "Samples", icon = icon("vial"),
          color = "purple",width = 2
        )
      
    }) 
    
    output$summaryNb3 <- renderValueBox({
      
      metadata <- AnalyzAIRR::mData(dataFilt())
      p<- nrow(metadata)
      
      valueBox(p, "Samples", icon = icon("vial"),
               color = "purple",width = 2
      )
      
    }) 
    
    # number of group
    output$summaryGrp <- renderValueBox({
      
      metadata <- AnalyzAIRR::mData(dataFilt())
      cols<- c("sample_id","nSequences","V","J","VJ","ntCDR3","aaCDR3","ntClone", "aaClone")
      p<- length(as.factor(colnames(metadata)[!colnames(metadata) %in% cols]))
      
      valueBox(p, "Biological groups", icon = icon("people-group"),
               color = "yellow",width = 2
      )
      
    }) 
    
    output$summaryGrp3 <- renderValueBox({
      
      metadata <- AnalyzAIRR::mData(dataFilt())
      cols<- c("sample_id","nSequences","V","J","VJ","ntCDR3","aaCDR3","ntClone", "aaClone")
      p<- length(as.factor(colnames(metadata)[!colnames(metadata) %in% cols]))
      
      valueBox(p, "Biological groups", icon = icon("people-group"),
               color = "yellow",width = 2
      )
      
    }) 
    
    
    # number of sequences
    output$summarySeq <- renderValueBox({
      
      metadata <- AnalyzAIRR::assay(dataFilt())
      p<- scales::comma(sum(metadata$count))
      
      valueBox(p, "Total sequences", icon = icon("rectangle-list"),
               color = "blue",width = 2
      )
      
    }) 
    
    output$summarySeq3 <- renderValueBox({
      
      metadata <- AnalyzAIRR::assay(dataFilt())
      p<- scales::comma(sum(metadata$count))
      
      valueBox(p, "Total sequences", icon = icon("rectangle-list"),
               color = "blue",width = 2
      )
      
    }) 
    
    output$downloadNewRepSeq <- downloadHandler(
      "RepSeqData.rds",
      
      content = function(file) {
        saveRDS(RepSeqDT(), file)
      }, 
    ) 
    
    # library sizes
    output$selectGrp1 <- renderUI({
      selectGrp("selectGrp1", dataFilt())
      })
    
    output$selectGrp3 <- renderUI({
      selectGrp("selectGrp3", dataFilt())
    })
    
    output$plotGrp1 <-  plotly::renderPlotly({
      
      validate(need(!(is.null(input$selectGrp1) || input$selectGrp1 == ""), ""))
      
      metadata<- AnalyzAIRR::mData(dataFilt())
      # grp <- input$selectGrp1
        data<-metadata %>% 
        dplyr::select(nSequences, !!rlang::sym(input$selectGrp1)) %>%
        dplyr::group_by(!!rlang::sym(input$selectGrp1)) %>%
        dplyr::summarise(count=sum(nSequences)) 
      colnames(data)<- c("group","value")
      
      # p1<-treemap::treemap(data, index="value", vSize="value", type="categorical", vColor = "group",
      #                      palette=AnalyzAIRR::oData(dataFilt())$label_colors$sex, title="")
      p1<-plotly::plot_ly(
          type='treemap',
          textinfo="label",
          parents="",
          labels=as.character(data$group),
          values=as.numeric(data$value),
          domain=list(column=0))
      
      p2<- p1 %>% plotly::layout(
        margin=list(l=0, r=0, b=0, t=0))

      p1
    }) 
    
    output$plotGrp3 <-  plotly::renderPlotly({
      
      validate(need(!(is.null(input$selectGrp3) || input$selectGrp3 == ""), ""))
      
      metadata<- AnalyzAIRR::mData(dataFilt())
      # grp <- input$selectGrp1
      data<-metadata %>% 
        dplyr::select(nSequences, !!rlang::sym(input$selectGrp3)) %>%
        dplyr::group_by(!!rlang::sym(input$selectGrp3)) %>%
        dplyr::summarise(count=sum(nSequences)) 
      colnames(data)<- c("group","value")
      
      # p1<-treemap::treemap(data, index="value", vSize="value", type="categorical", vColor = "group",
      #                      palette=AnalyzAIRR::oData(dataFilt())$label_colors$sex, title="")
      p1<-plotly::plot_ly(
        type='treemap',
        textinfo="label",
        parents="",
        labels=as.character(data$group),
        values=as.numeric(data$value),
        domain=list(column=0))
      
      p2<- p1 %>% plotly::layout(
        margin=list(l=0, r=0, b=0, t=0))
      
      p1
    }) 
    

    # output$downPlothistlibsizesp1 <- renderUI({
    #     downloadButton("Plothistlibsizesp1", "Download PDF", style="background-color:white; border-color: #022F5A;")
    # }) 
    
    # output$Plothistlibsizesp1 <- downloadHandler(
    #   filename =  function() {
    #     paste0("histlibsizes_summary.pdf")
    #   },
    #   # content is a function with argument file. content writes the plot to the device
    #   content = function(file) {
    #     pdf(file, height=4, width=6)
    #     cts<- AnalyzAIRR::assay(dataFilt())
    #     grid.draw(histSums(cts[,sum(count), by="sample_id"][,V1], xlab="Number of sequences",ylab="Number of samples"))
    #     dev.off()
    #   }
    # )
    ##rdsupload
    output$histlibsizesp1 <- renderUI({
      selectID("histlibsizesp1", dataFilt())
    })
    
    
    output$Plothistlibsizesp1 <- renderPlot({

      validate(need(!(is.null(input$histlibsizesp1) || input$histlibsizesp1 == ""), ""))
      
      cts<- AnalyzAIRR::assay(dataFilt())
      cts1<- cts %>% dplyr::filter(sample_id  %in% input$histlibsizesp1)
      
      p2<-ggplot2::ggplot(cts1, ggplot2::aes( x=count))+
        ggplot2::geom_histogram(ggplot2::aes(y=ggplot2::after_stat(density)), alpha=0.5, fill="white",color="black",
                       position="identity")+
        theme_RepSeq()+
        ggplot2::xlab("count")+
        ggplot2::scale_x_log10(labels = scales::comma)
      p2
    })
    
    #txtupload
    output$histlibsizesp3 <- renderUI({
      selectID("histlibsizesp3", dataFilt())
    })
    
    
    output$Plothistlibsizesp3 <- renderPlot({
      
      validate(need(!(is.null(input$histlibsizesp3) || input$histlibsizesp3 == ""), ""))
      
      cts<- AnalyzAIRR::assay(dataFilt())
      cts1<- cts %>% dplyr::filter(sample_id  %in% input$histlibsizesp3)
      
      p2<-ggplot2::ggplot(cts1, ggplot2::aes( x=count))+
        ggplot2::geom_histogram(ggplot2::aes(y=ggplot2::after_stat(density)), alpha=0.5, fill="white",color="black",
                                position="identity")+
        theme_RepSeq()+
        ggplot2::xlab("count")+
        ggplot2::scale_x_log10(labels = scales::comma)
      p2
    })
    
    # output$downPlothistlibsizesp2 <- renderUI({
    #  
    #     downloadButton("Plothistlibsizesp2", "Download PDF", style="background-color:white; border-color: #022F5A;")
    #   
    # }) 
    
    # output$Plothistlibsizesp2 <- downloadHandler(
    #   filename =  function() {
    #     paste0("histlibsizes_summary_", eval(input$summaryLevel),".pdf")
    #   },
    #   # content is a function with argument file. content writes the plot to the device
    #   content = function(file) {
    #     pdf(file, height=4, width=6)
    #     cts<- AnalyzAIRR::assay(dataFilt())
    #     grid.draw(histSums(cts[,sum(count), by=eval(input$summaryLevel)][,V1], xlab="count",ylab=paste("Number of", input$summaryLevel)))
    #     dev.off()
    #   }
    # )
    
    output$histtxtlibsizesp1 <- renderPlot({
      cts<- AnalyzAIRR::assay(dataFilt())
      p1<-histSums(cts[,sum(count), by="sample_id"][,V1], xlab="Number of sequences",ylab="Number of samples")
      
      p1
    }) 
    output$downPlothisttxtlibsizesp1 <- renderUI({
      downloadButton("Plothisttxtlibsizesp1", "Download PDF", style="background-color:white; border-color: #022F5A;")
    }) 
    
    output$Plothisttxtlibsizesp1 <- downloadHandler(
      filename =  function() {
        paste0("histlibsizes_summary.pdf")
      },
      # content is a function with argument file. content writes the plot to the device
      content = function(file) {
        pdf(file, height=4, width=6)
        cts<- AnalyzAIRR::assay(dataFilt())
        grid.draw(histSums(cts[,sum(count), by="sample_id"][,V1], xlab="Number of sequences",ylab="Number of samples"))
        dev.off()
      }
    )
    output$histtxtlibsizesp2 <- renderPlot({
      validate(need(!(is.null(input$summaryTXTLevel) || input$summaryTXTLevel == ""), "select a level"))
      cts<- AnalyzAIRR::assay(dataFilt())
      p2<-histSums(cts[,sum(count), by=eval(input$summaryTXTLevel)][,V1], xlab="count",ylab=paste("Number of", input$summaryTXTLevel))
      
      p2
    }) 
    
    output$downPlothisttxtlibsizesp2 <- renderUI({
      if (!is.null(input$summaryLevel)) {
        downloadButton("Plothisttxtlibsizesp2", "Download PDF", style="background-color:white; border-color: #022F5A;")
      }
    }) 
    
    output$Plothisttxtlibsizesp2 <- downloadHandler(
      filename =  function() {
        paste0("histlibsizes_summary_", eval(input$summaryTXTLevel),".pdf")
      },
      # content is a function with argument file. content writes the plot to the device
      content = function(file) {
        pdf(file, height=4, width=6)
        cts<- AnalyzAIRR::assay(dataFilt())
        grid.draw(histSums(cts[,sum(count), by=eval(input$summaryTXTLevel)][,V1], xlab="count",ylab=paste("Number of", input$summaryTXTLevel)))
        dev.off()
      }
    )
}) # end observeEvent RepSeqDT() is loaded
  
