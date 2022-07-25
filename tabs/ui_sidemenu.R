#-------------------------------------------------------------------------------------------------------------------------------------------#
#  Generate side menu section
#-------------------------------------------------------------------------------------------------------------------------------------------#
sideMenu <- sidebarMenu(id = "sideTabs",
    menuItem(
        selected = T,
        text = "About",
        icon = icon("info", verify_fa = FALSE),
        tabName = "aboutTab"
    ),
    convertMenuItem(
        menuItem(
            text = "Upload RDS file",
            icon = icon("upload", verify_fa = FALSE),
            fileInput(
                "RDSfile",
                NULL,
                multiple = T,
                accept = c("rds",
                           ".rds"),
                buttonLabel = "Choose RDS",
                placeholder = "No file selected"
            ), tabName = "uploadRDStab"
        ), tabName = "uploadRDStab"
    ),
    convertMenuItem(
        menuItem(
            text = "Upload text files",
            icon = icon("folder-open", verify_fa = FALSE),
            selectizeInput(
                "source",
                'Source ?',
                choices = list("MiXCR", "immunoseq", "rTCR", "AIRR"),
                options = list(onInitialize = I('function() { this.setValue(""); }'))
            ),
            checkboxGroupInput(
                "chain",
                "chain ?",
                choiceNames = c("alpha", "beta", "gamma", "delta", "IGH", "IGK", "IGL"),
                choiceValues = c("TRA", "TRB", "TRG", "TRD", "IGH", "IGK", "IGL")
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
                buttonLabel = "Choose sample info File(s)",
                placeholder = "No file(s) selected"
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
                    buttonLabel = "Choose sample File(s)",
                    placeholder = "No file(s) selected"
                )
            ), tabName = "uploadTXTtab"
        ), tabName = "uploadTXTtab"
  ),
  menuItemOutput("showDataTab"),
  menuItemOutput("statisticTab"),
  menuItemOutput("singleSampleTab"),
  menuItemOutput("multipleSampleTab"),
  shinyjs::useShinyjs(),
  menuItemOutput("downloadRDS"),
    menuItem(
    selected = F,
    text = "Session Info",
    icon = icon('info-circle', verify_fa = FALSE), tabName = "sessionTab")
)