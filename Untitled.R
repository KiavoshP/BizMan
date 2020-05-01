name <- "Mãng cầu ớt dẻo"

id <- paste0(substr(name, 1, 1), substr(name, length(name)-1, length(name)) ,round(runif(1, min = 10,max = 1000) * 10000))
id

inp <- read.csv(file = "TestInp.csv")
sum(inp$TotalItemPrice)
o <- loadModule("onlineBusiness","pending_orders")

aList <- list()
for (aCols in colnames(o)) {
  container <- NULL
  for (a in o[[aCols]]) {
    if(is.null(container)) {
      container <- paste(a)
    } else {
      container <- paste(container, a, sep = ";")
    }
  }
  aList[aCols] <- container
}


a <- names(o)
for (i in 1:length(a)) {
  print(a[i],sep = ",")
}
paste(a, sep = ",")
a[2]#
# box( width = "full",
#      fluidRow(
#        column(1,uiOutput("dynamicOrderGen")),
#        column(7,uiOutput("dynamicOrderGen1")),
#        column(2,uiOutput("dynamicOrderGen2")),
#        column(2,uiOutput("dynamicOrderGen3"))
#      )
# )
# )
# )
# })
# fieldGen <- function(i) {
#   column(2,numericInput(paste0("orderQuantity", i), label = "Quantity", value = 0))
#   column(6,selectInput(paste0("itemType", i), "Item", choices = itemList$ItemTab["name"], multiple = FALSE))
#   column(2,textInput(paste0("itemId", i), "PLI", value = itemList$ItemTab$name[input$paste0("itemType",i)]))
#   column(2,numericInput(paste0("ttlItemPrice", i), value = itemList$ItemTab$paste0(input$OrderLocation)[input$paste0("itemType",i)]))
# }
# output$dynamicOrderGen <- renderUI({
#   lapply(1:(input$NumberOfOrders), function(i) {
#     numericInput(paste0("orderQuantity", i), label = "Quantity", value = 1)
#   })
# })
# 
# output$dynamicOrderGen1 <- renderUI({
#   lapply(1:(input$NumberOfOrders), function(i) {
#     selectInput(paste0("itemType", i), "Item", choices = itemList$ItemTab["name"], multiple = FALSE)
#   })
# })
# 
# output$dynamicOrderGen2 <- renderUI({
#   lapply(1:(input$NumberOfOrders), function(i) {
#     numericInput(paste0("netP", i), paste("Net Price", input$OrderLocation), value = priceFinder(input[[paste0("itemType", i)]], input$OrderLocation))
#   })
# })
# 
# output$dynamicOrderGen3 <- renderUI({
#   lapply(1:(input$NumberOfOrders), function(i) {
#     numericInput(paste0("ttlItemPrice", i), "Total Price", value = 0)
#   })
# })

install.packages("rmarkdown")
a<- seq(0, 1000000,)

# 
# output$dynamicOrderGen <- renderUI({
#   lapply(1:(input$NumberOfOrders), function(i) {
#     fluidRow(
#       column(1,numericInput(paste0("orderQuantity", i), label = "Quantity", value = 1)),
#       column(7,selectInput(paste0("itemType", i), "Item", choices = itemList$ItemTab["name"], multiple = FALSE)),
#       column(2,numericInput(paste0("netP", i), paste("Net Price", input$OrderLocation), value = priceFinder(input[[paste0("itemType", i)]], input$OrderLocation))),
#       column(2,numericInput(paste0("ttlItemPrice", i), "Total Price", value = (input[[paste0("orderQuantity", i)]] * input[[paste0("netP", i)]])))
#     )
#   })
# })
