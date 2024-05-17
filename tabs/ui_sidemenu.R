#-------------------------------------------------------------------------------------------------------------------------------------------#
#  Generate side menu section
#-------------------------------------------------------------------------------------------------------------------------------------------#
sideMenu <- sidebarMenu(id = "sideTabs",
    menuItem(
        selected = T,
        text = "Getting started",
        icon = icon("info", verify_fa = FALSE, style="margin-left: 5px;"),
        tabName = "aboutTab"
    ),
    convertMenuItem(
        menuItem(
            text = "Upload RepSeqExperiment",
            icon = icon("upload", verify_fa = FALSE),
            # fileInput(
            #   inputId= "RDSfile",
            #    label= "Use your RepSeqExperiment file",
            #     multiple =F,
            #     accept = c("rds",
            #                ".rds"),
            #     buttonLabel = "Browse",
            #     placeholder = "No file selected"
            # ),
            checkboxInput(
              "userdata",
              "Use my RepSeqExperiment data", 
              value = FALSE
            ),
            conditionalPanel(
              condition = "output.canUploadrds",
              fileInput(
                inputId= "RDSfile",
                 label= "",
                  multiple =F,
                  accept = c("rds",
                             ".rds"),
                  buttonLabel = "Browse",
                  placeholder = "No file selected"
              ),
            ),
            # selectizeInput(inputId = "loadExample",
            #                'Or use example data',
            #                choices = list("Yes", "No"),
            #                options = list(onInitialize = I('function() { this.setValue("No"); }'))
            # ),
            checkboxInput(
              "loadExample",
              "Use example data", 
              value = FALSE
            ),
            # actionButton(inputId="loadExample",label="Use example data" , icon = icon("redo")),
            tabName = "uploadRDStab"), 
        tabName = "uploadRDStab"
    ),
    convertMenuItem(
        menuItem(
            text = "Upload alignment files",
            icon = icon("folder-open", verify_fa = FALSE),
            selectizeInput(inputId = "source", 
                           'Source',
                           choices = list("MiXCR", "immunoseq", "AIRR", "Other"),
                           options = list(onInitialize = I('function() { this.setValue(""); }'))
            ),
            radioButtons(inputId = "chain", 
                         label = "Chain", 
                         choiceNames = c("TRA", "TRB", "TRG", "TRD", "IGH", "IGK", "IGL"),
                         choiceValues = c("TRA", "TRB", "TRG", "TRD", "IGH", "IGK", "IGL")
            ),
            conditionalPanel(
              condition = "output.canUpload",
              fileInput(
                "samplefiles",
                NULL,
                multiple = T,
                accept = c(
                  "txt/tsv",        
                  "text/tabulation-separated-values,text/plain",
                  ".txt",
                  ".tsv"
                ),
                buttonLabel = "Choose alignment file(s)",
                placeholder = "No file selected"
              ),
              radioButtons(
                "putInfofile",
                "Metadata file ?", 
                choiceNames = c("Yes", "No"),
                choiceValues = c("Yes", "No")
              ),
              fileInput(
                "sInfofile",
                NULL,
                multiple = T,
                accept = c(
                  "txt/tsv",        
                  "text/tabulation-separated-values,text/plain",
                  ".txt",
                  ".tsv"
                ),
                buttonLabel = "Choose metadata file",
                placeholder = "No file selected"
              ),
              div(style="display:inline-block;margin-left: 25%;padding-bottom: 10px;",
                  downloadButton("downloadNewRepSeq", "Download RDS", style="color: #333333; background-color: light-grey; border-color: #022F5A;"))
            ), tabName = "uploadTXTtab"
        ), tabName = "uploadTXTtab"
  ),
  menuItemOutput("showDataTab"),
  menuItemOutput("statisticTab"),
  menuItemOutput("singleSampleTab"),
  menuItemOutput("multipleSampleTab"),
  shinyjs::useShinyjs(),
  menuItem(
  selected = F,
  text = "Session Info",
  icon = icon('info-circle', verify_fa = FALSE), tabName = "sessionTab"), 
  menuItemOutput("sessionReportTab")
)



