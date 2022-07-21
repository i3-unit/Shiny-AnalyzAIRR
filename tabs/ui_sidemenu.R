#-------------------------------------------------------------------------------------------------------------------------------------------#
#  Generate side menu section
#-------------------------------------------------------------------------------------------------------------------------------------------#
sideMenu <- sidebarMenu(id = "sideTabs",
    menuItem(
        selected = T,
        text = "About",
        icon = icon("info"),
        tabName = "aboutTab"
    ),
    convertMenuItem(
        menuItem(
            text = "Upload RDS file",
            icon = icon("upload"),
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
            icon = icon("upload"),
            selectizeInput(
                "source",
                'Source ?',
                choices = list("Adaptive", "ClonotypeR", "MiXCR"),
                options = list(onInitialize = I('function() { this.setValue(""); }'))
            ),
            checkboxGroupInput(
                "chain",
                "chain ?",
                choiceNames = c("alpha", "beta"),
                choiceValues = c("A", "B")
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
  menuItemOutput("singleSampleTab"),
  menuItemOutput("multipleSampleTab"),
  menuItemOutput("statisticTab"),
  shinyjs::useShinyjs(),
  menuItemOutput("downloadRDS")
)