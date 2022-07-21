#-------------------------------------------------------------------------------------------------------------------------------------------#
#  view RepSeqExperiment object section
#-------------------------------------------------------------------------------------------------------------------------------------------#   
# show diversity table
showDiversity <- reactive(
    RepSeq::basicIndices(RepSeqDT(), level = input$diversityLevel)
)
# get name
filenameDT <- function(fname){
    return(list(list(extend = 'csv', filename = fname), list(extend = 'excel', filename = fname)))
}
# create download button for all assay data
output$downloadAssay <- downloadHandler(
    "RepSeqAssay.csv",
    content = function(file) {
        write.table(RepSeq::assay(RepSeqDT()), file, row.names = F, sep = '\t')
    }, contentType = "text/csv"
) 
# output infoTable
output$infoTable <- renderDataTable(RepSeq::sData(RepSeqDT()), 
    server = F, 
    style="bootstrap", 
    extensions = 'Buttons', 
    options = list(scrollX=TRUE, dom = 'Bfrtip', buttons = filenameDT("RepSeqInfo"))
)
# output AssayTable
output$assayTable <- renderDataTable(RepSeq::assay(RepSeqDT()), 
    options=list(scrollX=TRUE)
)
# get information of slot metadata
output$metadataTable <- renderPrint({
    out <- mData(RepSeqDT())
    if (length(out)==0) print("Nothing to display") else names(out)
})
# output history
output$historyTable <- renderDataTable(History(RepSeqDT()), 
    server = F, style="bootstrap", extensions = 'Buttons', 
    options = list(scrollX=TRUE, dom = 'Bfrtip', buttons = filenameDT("RepSeqHistory"))
)
# output diversity 
output$diversityTable <- renderDataTable({
    validate(need(!(is.null(input$diversityLevel) ||  input$diversityLevel == ""), "Choose a level"))
    DT::datatable(showDiversity(), style="bootstrap", extensions = 'Buttons', options = list(scrollX=TRUE, dom = 'Bfrtip', buttons = filenameDT("RepSeqDiversity")))
})
    
