#--------------- shiny server ---------------#
shinyServer(function(input, output, session) {
    # render about
    output$about<- renderUI({ includeHTML("www/new_about.html") })
    
    # render session information
    output$session <- renderPrint({ sessionInfo() })
    
    # upload aligned & annotated CSV data 
    output$canUpload <- reactive(
        return(!(is.null(input$chain) || input$source == ""))
    )
    #
    outputOptions(output, "canUpload", suspendWhenHidden = FALSE) 
    
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
                           countLevel = input$countLevel, 
                           countScale = input$countScale, 
                           plotRare = input$plotRare, 
                           divIndex = input$divIndex, 
                           divLevel = input$divLevel, 
                           renyiLevel = input$renyiLevel, 
                           countIntLevel = input$countIntLevel, 
                           rankDistribLevel = input$rankDistribLevel, 
                           rankDistribGroupMeth = input$rankDistribGroupMeth, 
                           singleSample = input$singleSample, 
                           indLevel = input$indLevel, 
                           indgeneUsageLevel = input$indgeneUsageLevel, 
                           singleScale = input$singleScale, 
                           VJLevel = input$VJLevel, 
                           VJProp = input$VJProp, 
                           singleProp = input$singleProp, 
                           spectraProp = input$spectraProp, 
                           statisticsStat = input$statisticsStat,
                           statisticsGroup = input$statisticsGroup, 
                           diverLevel = input$diverLevel, 
                           diverGroup = input$diverGroup, 
                           diverIndex = input$diverIndex, 
                           multrenLevel = input$multrenLevel, 
                           multrenGroup = input$multrenGroup, 
                           countIntervalsLevel = input$countIntervalsLevel, 
                           countIntervalsGroup = input$countIntervalsGroup,
                           multRankLevel = input$multRankLevel, 
                           multRankScale = input$multRankScale, 
                           multRankGroup = input$multRankGroup, 
                           geneUsageLevel = input$geneUsageLevel, 
                           geneUsageScale = input$geneUsageScale, 
                           geneUsageGroup = input$geneUsageGroup,
                           vennLevel = input$vennLevel, 
                           vennSamples = input$vennSamples, 
                           scatterUISample = input$scatterUISample, 
                           scatterLevel = input$scatterLevel, 
                           scatterScale = input$scatterScale, 
                           dissimilarityLevel = input$dissimilarityLevel, 
                           dissimilarityIndex = input$dissimilarityIndex,
                           dissimilarityClustering = input$dissimilarityClustering, 
                           doHm1 = input$doHm1, 
                           MDSLevel = input$MDSLevel, 
                           MDSMethod = input$MDSMethod, 
                           grpCol4MDS = input$grpCol4MDS, 
                           diffLevel = input$diffLevel, 
                           diffGroup = input$diffGroup, 
                           diffFC = input$diffFC, 
                           diffPV = input$diffPV, 
                           diffPCALevel = input$diffPCALevel, 
                           PCAMethod = input$PCAMethod, 
                           diffPCAGroup = input$diffPCAGroup, 
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
                           doDiversity = input$doDiversity)
            
            render(tempReport, output_file = file,
                   params = params,
                   envir = new.env(parent = globalenv()),
                   switch(input$format,
                          PDF = pdf_document(), 
                          HTML = html_document(), 
                          Word = word_document(), 
                          PPT = powerpoint_presentation())
                   )
        }
    )
    
    # load RDS 
    RepSeqDT <- eventReactive(c(input$samplefiles, input$RDSfile, input$putInfofile, input$sInfofile), {
        validate(need(!(is.null(input$sInfofile) && input$putInfofile == "Yes") || 
                          (is.null(input$sInfofile) && input$putInfofile == "No") ||
                          !(is.null(input$RDSfile)), ""))
        if (!is.null(input$RDSfile)) {
        RepSeqDT <- readRDS(input$RDSfile$datapath)
        } else if(input$source != "Other"){
            sInfo <- NULL
            if (!is.null(input$sInfofile)) { 
              sInfo <- read.table(input$sInfofile$datapath, 
                         header=T,
                         row.names = 1)
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
                                                raretab = FALSE,
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
                                            raretab = FALSE,
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
    output$singleInfoDT <- renderDataTable(mData(dataFilt())[input$singleSample,], options=list(scrollX=TRUE))
    # count assay render 
    output$singleAssayDT <- renderDataTable(assay(dataFilt())[sample_id == input$singleSample], options=list(scrollX=TRUE))
    # 
    observeEvent(input$showsampleInfo,
        showModal(modalDialog(
            title = paste(input$singleSample," info"),
            dataTableOutput("singleInfoDT"),
            dataTableOutput("singleAssayDT"),
            size = "l",
            easyClose = T
        ))
    )
    
    # reset analysis
    observeEvent(input$resetApp, {
        session$reload()
        return()
    })
}) 


