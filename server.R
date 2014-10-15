library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
        # Preload word recognition functions
        Sys.setlocale('LC_ALL','C')
        ptable <- read.table("data/ptable1.txt",header=TRUE,stringsAsFactors=FALSE)
        wordrec <- function(x,dict=ptable,n=5){ 
                # dict is dictionary
                # x is search string
                # n is number to return
                library(stringr)
                for(i in -5:-1){
                        result <- try(word(x,i,-1),silent=TRUE)
                        if(class(result) != "try-error") stub <- c(stub,result)
                }
                stub <- unique(stub)
                for(i in 1:length(stub)){
                        result <- ptable[grep(paste0("^",stub[i]),ptable$term,ignore.case = TRUE),]
                        if(nrow(result) !=0) result
                }
                result <- result[with(result, order(-p)), ]
                result <- result[1:n,]
                result <- result[complete.cases(result),]
                ifelse(nrow(result)==0,result,"Sorry! No suggestions")
                result
        }
        # Predict next word
        output$predictedText <- renderTable({
                result <- wordrec(input$searchTerm,dict,input$termNumber)
                result[,1:2]
        })
})

