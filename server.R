library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
        # Preload word recognition functions
        Sys.setlocale('LC_ALL','C')
        wordrec1 <- function(x,dict,n){ 
                # dict is dictionary
                # x is search string
                # n is number to return
                stub <- paste0("^",x)
                words <- dict
                result <- words[grep(stub,words$term,ignore.case = TRUE),]
                result <- result[order(-result$count),]
                res <- result$term[1:n]
                res <- res[!is.na(res)]
                res
        }
        wordrec <- function(x,dict,n=5){
                # dict is ptable
                # x is search string
                # n is number to return
                stub <- paste0("^",x)
                words <- dict
                result <- words[grep(stub,words$term,ignore.case=TRUE),]
                if(all(is.na(result$X5gram))){
                        result <- result[order(-result$X5gram),]
                }
                else if(all(is.na(result$X4gram))){
                        result <- result[order(-result$X4gram),]
                }
                else if(all(is.na(result$X3gram))){
                        result <- result[order(-result$X3gram),]
                }
                else if(all(is.na(result$X2gram))){
                        result <- result[order(-result$X2gram),]
                }
                else{
                        result <- result[order(-result$X1gram),]
                }
                res <- result$term[1:n]
                res <- res[!is.na(res)]
                res
        }
        medterms <- read.table("data/medterms.txt",header=TRUE,stringsAsFactors =FALSE)
        bauman <- read.table("data/bauman.txt",header=TRUE,stringsAsFactors=FALSE)
        ptable <- read.table("data/ptable.txt",header=TRUE,stringsAsFactors=FALSE)
        # Predict next word
        output$predictedText <- renderTable({
                if(input$radio == 1){
                        dict <- bauman
                        term <- as.data.frame(wordrec1(input$searchTerm,dict,input$termNumber))
                        term <- cbind(term)
                        colnames(term) <- "Term"
                        term
                }
                else if(input$radio == 2){
                        dict <- medterms
                        term <- as.data.frame(wordrec1(input$searchTerm,dict,input$termNumber))
                        term <- cbind(term)
                        colnames(term) <- "Term"
                        term
                }
                else {
                        dict <- ptable
                        term <- as.data.frame(wordrec(input$searchTerm,dict,input$termNumber))
                        term <- cbind(term)
                        colnames(term) <- "Term"
                        term
                }
        })
})

