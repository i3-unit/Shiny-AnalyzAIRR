#--------------- shiny server ---------------#
shinyServer(function(input, output, session) {
    # render about
    output$about<- renderUI({ includeHTML("www/new_about.html") })
    
    # render session information
    output$session <- renderPrint({ sessionInfo() })
    
    #load example data
    # data <- reactive({
    #   url <- "https://github.com/vanessajmh/Shiny-AnalyzAIRR/tree/master/data/RepSeqData.rds"
    #   readRDS(url)
    # })
    
    # upload aligned & annotated CSV data 
    output$canUpload <- reactive(
        return(!(is.null(input$chain) || input$source == ""))
    )
    #
  
    #
    outputOptions(output, "canUpload", suspendWhenHidden = FALSE) 
    
    # upload rds 
    output$canUploadrds <- reactive(
      return(input$userdata==TRUE) 
    )
    
    outputOptions(output, "canUploadrds", suspendWhenHidden = FALSE) 
    
    #
    
    output$renderedReport <- renderUI({
        includeMarkdown(knitr::knit("markdown/report_template.Rmd"))         
    })
    
    output$report <- downloadHandler(
        filename = function() {
            paste('report', sep = '.', switch(
                input$format, PDF = 'pdf', HTML = 'html', Word = 'docx', PPT = "pptx"
            ))},
        content = function(file) {
            tempReport <- file.path("markdown/report_todownload.Rmd")
            file.copy("markdown/report.Rmd", tempReport, overwrite = TRUE)
            
            params <- list(otherDataList = input$otherDataList, 
                           filterCountLevel = input$filterCountLevel, 
                           filterCountN = input$filterCountN,
                           filterCountGroup = input$filterCountGroup,
                           doFilterCount = input$doFilterCount,
                           doProductive = input$doProductive, 
                           dropSampleNames = input$dropSampleNames, 
                           publicLevel = input$publicLevel, 
                           publicGroup = input$publicGroup, 
                           doPublic = input$doPublic, 
                           privateLevel = input$privateLevel, 
                           privateSingletons = input$privateSingletons, 
                           doPrivate = input$doPrivate, 
                           topSeqLevel = input$topSeqLevel, 
                           topSeqGroup = input$topSeqGroup,
                           topSeqProp = input$topSeqProp, 
                           doTopSeq = input$doTopSeq, 
                           downSampleSize = input$downSampleSize, 
                           downseed = input$downseed, 
                           downReplace = input$downReplace, 
                           doDown = input$doDown, 
                           DownLevel = input$DownLevel, 
                           doNorm = input$doNorm, 
                           NormLevel = input$NormLevel, 
                           plotStats = input$plotStats, 
                           plotStats1 = input$plotStats1,
                           plotStats2 = input$plotStats2,
                           plotcolorgrouppair = input$plotcolorgrouppair,
                           chaoIndex = input$chaoIndex,
                           chaocolor = input$chaocolor,
                           plotcolorgroup = input$plotcolorgroup,
                           plotfacetgroup = input$plotfacetgroup,
                           countLevel = input$countLevel, 
                           countScale = input$countScale, 
                           plotRare = input$plotRare, 
                           divIndex = input$divIndex, 
                           divLevel = input$divLevel, 
                           divcolor = input$divcolor,
                           divfacet = input$divfacet,
                           renyiLevel = input$renyiLevel, 
                           renyicolor = input$renyicolor, 
                           renyifacet = input$renyifacet, 
                           countIntLevel = input$countIntLevel, 
                           countIntGroupMeth = input$countIntGroupMeth,
                           countIntfacet = input$countIntfacet,
                           rankDistribLevel = input$rankDistribLevel, 
                           rankDistribGroupMeth = input$rankDistribGroupMeth, 
                           rankDistribSize = input$rankDistribSize, 
                           rankDistribcolor = input$rankDistribcolor, 
                           rankDistribfacet = input$rankDistribfacet, 
                           singleSample = input$singleSample, 
                           indStat = input$indStat,
                           indLevel = input$indLevel, 
                           indgeneUsageLevel = input$indgeneUsageLevel, 
                           indMeth = input$indMeth, 
                           indProp = input$indProp,
                           indTreeLevel = input$indTreeLevel,
                           indIntLevel = input$indIntLevel,
                           singleScale = input$singleScale, 
                           VJLevel = input$VJLevel, 
                           VJProp = input$VJProp, 
                           VJViz = input$VJViz, 
                           singleProp = input$singleProp, 
                           spectraProp = input$spectraProp, 
                           statisticsStat = input$statisticsStat,
                           statisticsGroup = input$statisticsGroup, 
                           statisticsFacet = input$statisticsFacet, 
                           diverLevel = input$diverLevel, 
                           diverfacet = input$diverfacet, 
                           diverGroup = input$diverGroup, 
                           divshowstats = input$divshowstats, 
                           diverIndex = input$diverIndex, 
                           statisticsshowstats = input$statisticsshowstats,
                           diverLevel = input$diverLevel,
                           diverGroup = input$diverGroup, 
                           diverIndex = input$diverIndex,
                           multrenLevel = input$multrenLevel, 
                           multrenGroup = input$multrenGroup, 
                           multrenfacet = input$multrenfacet, 
                           countIntervalsLevel = input$countIntervalsLevel, 
                           countIntervalsGroup = input$countIntervalsGroup,
                           countIntervalsscale = input$countIntervalsscale, 
                           countIntervalsFacet = input$countIntervalsFacet,
                           countIntervalsshowstats = input$countIntervalsshowstats,
                           multRankLevel = input$multRankLevel, 
                           multRankScale = input$multRankScale, 
                           multRankGroup = input$multRankGroup, 
                           multRankFacet = input$multRankFacet, 
                           geneUsageLevel = input$geneUsageLevel, 
                           geneUsageScale = input$geneUsageScale, 
                           geneUsageGroup = input$geneUsageGroup,
                           geneUsagefacet = input$geneUsagefacet,
                           geneUsageshowstats = input$geneUsageshowstats,
                           vennLevel = input$vennLevel, 
                           vennSamples = input$vennSamples, 
                           scatterUISample = input$scatterUISample, 
                           scatterLevel = input$scatterLevel, 
                           scatterScale = input$scatterScale, 
                           dissimilarityLevel = input$dissimilarityLevel, 
                           dissimilarityIndex = input$dissimilarityIndex,
                           dissimilarityClustering = input$dissimilarityClustering, 
                           multdissGroup=input$multdissGroup,
                           doHm1 = input$doHm1, 
                           MDSLevel = input$MDSLevel, 
                           MDSMethod = input$MDSMethod, 
                           multMDSGroup=input$multMDSGroup,
                           diffLevel = input$diffLevel, 
                           diffGroup = input$diffGroup, 
                           diffFC = input$diffFC, 
                           diffPV = input$diffPV, 
                           PertGroupSelected = input$PertGroupSelected, 
                           CtrlGroup = input$CtrlGroup, 
                           pertDist = input$pertDist, 
                           pertOrder = input$pertOrder, 
                           pertPower = input$pertPower, 
                           doHm = input$doHm,
                           dataFiltered = dataFilt(), 
                           repseqdt = RepSeqDT(), 
                           downText = input$downText, 
                           shannonText = input$shannonText,
                           metadatastatsText = input$metadatastatsText,
                           countfeaturesText = input$countfeaturesText,
                           rarefactionText = input$rarefactionText,
                           divindText = input$divindText,
                           renyiindText = input$renyiindText,
                           countindexpText = input$countindexpText,
                           rankdistribexpText = input$rankdistribexpText,
                           IndCountIntText = input$IndCountIntText,
                           VJUsageText = input$VJUsageText,
                           VJGeneUsageText = input$VJGeneUsageText,
                           cd3spectraText = input$cd3spectraText,
                           cd3spectraindText = input$cd3spectraindText,
                           statsText = input$statsText, 
                           divText = input$divText,
                           renyiText = input$renyiText,
                           countIntText = input$countIntText,
                           rankDistribText = input$rankDistribText,
                           geneUsageText = input$geneUsageText,
                           eulerrText = input$eulerrText,
                           scatterText = input$scatterText,
                           disHMText = input$disHMText,
                           MDSText = input$MDSText,
                           volcanoText = input$volcanoText,
                           PCAText = input$PCAText,
                           spectratypingcomparisonHMText = input$spectratypingcomparisonHMText, 
                           authors = input$authors, 
                           title = input$title,
                           doStats = input$doStats,
                           dogeneUsage = input$dogeneUsage,
                           doCountInt = input$doCountInt,
                           doDiversity = input$doDiversity,
                           plotvj=input$VJViz)
            
            render(tempReport, output_file = file,
                   params = params,
                   envir = new.env(parent = globalenv()),
                   switch(input$format,
                          HTML = rmarkdown::html_document(theme="yeti",
                                                           toc= TRUE,
                                                           toc_depth= 4,
                                                           highlight= "tango",
                                                          number_sections=TRUE), 

                          Word = rmarkdown::word_document(toc = TRUE, toc_depth = 4, number_sections = TRUE), 
                          PPT = rmarkdown::powerpoint_presentation(toc = TRUE, toc_depth = 4, number_sections = TRUE))
                   )
        }
    )
    
    # load RDS 
    RepSeqDT <- eventReactive(c(input$samplefiles, input$RDSfile, input$putInfofile, input$sInfofile, input$loadExample), {
        validate(need(!(is.null(input$sInfofile) && input$putInfofile == "Yes") || 
                          (is.null(input$sInfofile) && input$putInfofile == "No") ||
                        !is.null(input$RDSfile) && input$loadExample==FALSE ||
                        is.null(input$RDSfile) && input$loadExample==TRUE , ""))
                     
        if (!is.null(input$RDSfile)) {
        RepSeqDT <- readRDS(input$RDSfile$datapath)
        } else if( input$loadExample== TRUE){
          RepSeqDT<-  readRDS("data/RepSeqData.rds")
        } else if(input$source != "Other"){
            sInfo <- NULL
            if (!is.null(input$sInfofile)) { 
              sInfo <- readr::read_delim(input$sInfofile$datapath)
              sInfo <- sInfo %>% 
                        tibble::column_to_rownames("sample_id") %>%
                         dplyr::mutate_if(., is.character, as.factor)
            }
            tempFile <- input$samplefiles$datapath
            inFiles <- unlist(sapply(input$samplefiles$name, renameFiles, x = dirname(tempFile[1])), recursive = F)
            file.rename(tempFile, inFiles)
            
            RepSeqDT <- AnalyzAIRR::readAIRRSet(fileList = inFiles, 
                                                fileFormat = input$source, 
                                                chain = input$chain, 
                                                sampleinfo = sInfo,
                                                keep.ambiguous = TRUE,
                                                keep.unproductive = TRUE,
                                                filter.singletons = FALSE,
                                                aa.th = 8,
                                                outFiltered = TRUE,
                                                cores = 1L)
                file.remove(inFiles)
        } else if(input$source == "Other"){
          sInfo <- NULL
          if (!is.null(input$sInfofile)) { 
            sInfo <- read.table(input$sInfofile$datapath, 
                                header=T,
                                row.names = 1)
          }
          tempFile <- input$samplefiles$datapath
          inFiles <- unlist(sapply(input$samplefiles$name, renameFiles, x = dirname(tempFile[1])), recursive = F)
          file.rename(tempFile, inFiles)
          RepSeqDT <- AnalyzAIRR::readFormatSet(fileList = inFiles, 
                                            chain = input$chain, 
                                            sampleinfo = sInfo, 
                                            keep.ambiguous = TRUE,
                                            keep.unproductive = TRUE,
                                            filter.singletons = FALSE,
                                            aa.th = 8,
                                            outFiltered = TRUE,
                                            cores = 1L)
          file.remove(inFiles)
          
        }
        return(RepSeqDT)
    })
    # output reactive
    output$isUploaded <- reactive({
        return(AnalyzAIRR::is.RepSeqExperiment(RepSeqDT()))
    })
    outputOptions(output, "isUploaded", suspendWhenHidden = FALSE)
    
#-------------------------------------------------------------------------------------------------------------------------------------------#
#  Generate side menu section
#-------------------------------------------------------------------------------------------------------------------------------------------#     
source("tabs/server_sidemenu.R", local = TRUE)
    # download RDS
    observeEvent(input$sideTabs, {
        if (input$sideTabs == "DownloadRDS") {
            dir.create(paste0(getwd(), "/", "RepSeqFiles"), showWarnings = FALSE)
            saveRDS(RepSeqDT(),
            file = paste0(getwd(), "/", "RepSeqFiles/RepSeqExperiment.rds"))
            shinyjs::info(paste0("Downloaded to ", getwd(), "/", "RepSeqFiles/RepSeqExperiment.rds"))
        }
    }, ignoreInit = T)
    
#-------------------------------------------------------------------------------------------------------------------------------------------#
#  view RepSeqExperiment object section
#-------------------------------------------------------------------------------------------------------------------------------------------#    
source("tabs/server_viewdata.R", local = TRUE)
#-------------------------------------------------------------------------------------------------------------------------------------------#
#  single sample section
#-------------------------------------------------------------------------------------------------------------------------------------------#      
source("tabs/server_singlesample.R", local = TRUE)
#-------------------------------------------------------------------------------------------------------------------------------------------#
#  multiple comparison section
#-------------------------------------------------------------------------------------------------------------------------------------------#
source("tabs/server_multiplesamples.R", local = TRUE)
    # RepSeqDown <- eventReactive(input$doDown, {
    # 
    # out <- sampleRepSeqExp(x = RepSeqDT(), sample.size = isolate(input$downSampleSize), rngseed = isolate(input$downseed), replace = TRUE, verbose = FALSE)
    # return(out)
    # })
#-------------------------------------------------------------------------------------------------------------------------------------------#
#  statististical analysis section
#-------------------------------------------------------------------------------------------------------------------------------------------#
#--------------------------------------------------------------------------------#
#  diffferential analysis section
#--------------------------------------------------------------------------------#  
source("tabs/server_exploratorystats.R", local = TRUE)
#-------------------------------------------------------------------------------------------------------------------------------------------#
#  download RDS section
#-------------------------------------------------------------------------------------------------------------------------------------------#    
    # sample info render
    output$singleInfoDT <- renderReactable({
     meta<- mData(dataFilt())[input$singleSample,]
     rownames(meta) <- NULL
      reactable( meta,  columns = list( 
                            sample_id =colDef(
                            sticky = "left",
                            maxWidth = 120,
                            # Add a right border style to visually distinguish the sticky column
                            style = list(borderRight = "1px solid #eee", backgroundColor = "#f7f7f7"),
                            headerStyle = list(borderRight = "1px solid #eee", backgroundColor = "#f7f7f7"))),
                 # showSortable = TRUE,
                 # showPageSizeOptions = TRUE,
                 # pageSizeOptions = c(5,10),
                 # defaultPageSize = 5,
                 pagination = FALSE,
                 bordered = TRUE
                 
      ) 
      })
    # count assay render 
    output$singleAssayDT <- renderReactable({
      ass<-assay(dataFilt())[sample_id == input$singleSample]
      reactable( ass, 
                 filterable = TRUE,
                 bordered = TRUE, 
                columns = list( sample_id =colDef(
                sticky = "left",
                maxWidth = 120,
                # Add a right border style to visually distinguish the sticky column
                style = list(borderRight = "1px solid #eee", backgroundColor = "#f7f7f7"),
                headerStyle = list(borderRight = "1px solid #eee", backgroundColor = "#f7f7f7"))),
                showSortable = TRUE,
                showPageSizeOptions = TRUE,
                pageSizeOptions = c(5,10, 15),
                defaultPageSize = 5,

      ) 
    })
    # 
    observeEvent(input$showsampleInfo,
        showModal(modalDialog(
          htmltools::div(htmltools::h2("MetaData"), 
          reactableOutput("singleInfoDT")),
          htmltools::div(htmltools::h2("AssayData"), 
                         reactableOutput("singleAssayDT")),
            size = "l",
            easyClose = T
        ))
    )
    
    # reset analysis
    observeEvent(input$resetApp, {
        session$reload()
        return()
    })
    
    #load example data
    # observeEvent(input$loadExample, {
    #   reactive({
    #     url <- "https://github.com/vanessajmh/Shiny-AnalyzAIRR/tree/master/data/RepSeqData.rds"
    #     readRDS(url)
    #   })
    #  # showNotification(paste("Message", "Data Has been loaded"), duration = NULL)
    #   
    # })
    
}) 


