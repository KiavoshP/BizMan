library(shiny)
library(DT)
library(shinyBS)
source("Back.R")
source("pipe.r")
shinyServer(function(input, output, session) {
  
  # ItemPage----
  itemList <- reactiveValues(ItemTab = loadModule("onlineBusiness","inventory_items"))
  observe({
    invalidateLater(100,session)
    if (!identical(itemList$ItemTab, loadModule("onlineBusiness","inventory_items"))) { 
      itemList$ItemTab <- loadModule("onlineBusiness","inventory_items")
    }
  })
  output$itemTables = renderDataTable(
    datatable(itemList$ItemTab)
  )
  output$itemForm <- renderUI ({
    box(width = "full",
        verticalLayout(
          fluidRow(
            column(3,textInput("ItemName","Item Name")),
            column(3,textInput("ItemWeight", "Item Weight")),
            column(3,numericInput("ItemPVn", "Item Price VN", value = 0)),
            column(3,numericInput("ItemPUs", "Item Price US", value = 0))
          ),
          fluidRow(
            column(12, textAreaInput("ItemSpec", "Specification"))
          ),
          hr(),
          fluidRow(
            column(3, offset = 4, align = "center", actionButton("addItem", "Add Item"))
          ),
          br(),
          box(
            title = "My ScoreBoard",
            width = NULL,
            status = "primary", 
            solidHeader = TRUE,
            collapsible = TRUE,
            div(style = 'overflow-x: scroll',dataTableOutput("itemTables"))
          )
        )
        
    )
  })
  fieldsAll <- c("ItemName","ItemWeight","ItemPVn","ItemPUs", "ItemSpec")
  ItemformData <- reactive({
    data <- sapply(fieldsAll, function(x) input[[x]])
    data <- t(data)
    data
  })
  observeEvent(input$addItem, {
    addItem(DataCollector("NewItem"))
    updateTextInput(session,"ItemName", value="")
    updateNumericInput(session,"ItemWeight", value="")
    updateNumericInput(session,"ItemPVn", value="")
    updateNumericInput(session,"ItemPUs", value="")
    updateTextAreaInput(session,"ItemSpec", value="")
  })
  
  # ----# ItemPage----
  ordersList <- reactiveValues(orderTab = loadModule("onlineBusiness","orders_list"))
  observe({
    invalidateLater(100,session)
    if (!identical(ordersList$orderTab, loadModule("onlineBusiness","orders_list"))) { 
      ordersList$orderTab <- loadModule("onlineBusiness","orders_list")
    }
  })
  output$orderTab = renderDataTable(
    datatable(ordersList$orderTab)
  )
  output$orderForms <- renderUI ({
    box(width = "full",
        verticalLayout(
          fluidRow(
            column(3,textInput("OrderNumber","Order Num.", value = idCreator(ordersList$orderTab, "SnackOrder"))),
            column(3,textInput("CustName", "Customer Name")),
            column(3,textInput("CustLast", "Customer LastN")),
            column(3,numericInput("CustPhone", "Customer Phone Number", value = 0))
          ),
          hr(),
          fluidRow(
            column(4, textInput("FaceBookId", "FaceBook ID")),
            column(2, numericInput("NumberOfOrders", "Total Items Ordered", value = 1, max = 6, min = 1)),
            column(1, radioButtons("OrderLocation", "Location", choices = c("VN" = "VNd", "US" = "USD"))),
            column(2, numericInput("ShippingCost", "Shipping Cost", value = 0)),
            column(3, textInput("orederMemo", "Addr & Memo"))
          ),
          verticalLayout(
            box( width = "full",
                 fluidPage(
                   column(2,uiOutput("dynamicOrderGen")),
                   column(6,uiOutput("dynamicOrderGen1")),
                   column(2,uiOutput("dynamicOrderGen2")),
                   column(2,uiOutput("dynamicOrderGen3"))
                 )
            ),
            fluidRow(
              column(3, offset = 3, actionButton("SaveOrder", "Save Order")),
              column(3, offset = 3, downloadButton("dlRecipt", "Download Recipt"))
            )
          )
        )
    )
  })
  fieldGen <- function(i) {
    column(2,numericInput(paste0("orderQuantity", i), label = "Quantity", value = 0))
    column(6,selectInput(paste0("itemType", i), "Item", choices = itemList$ItemTab["name"], multiple = FALSE))
    column(2,textInput(paste0("itemId", i), "PLI", value = itemList$ItemTab$name[input$paste0("itemType",i)]))
    column(2,numericInput(paste0("ttlItemPrice", i), value = itemList$ItemTab$paste0(input$OrderLocation)[input$paste0("itemType",i)]))
  }
  output$dynamicOrderGen <- renderUI({
    lapply(1:(input$NumberOfOrders), function(i) {
      numericInput(paste0("orderQuantity", i), label = "Quantity", value = 1, min = 1)
    })
  })
  
  output$dynamicOrderGen1 <- renderUI({
    lapply(1:(input$NumberOfOrders), function(i) {
      selectInput(paste0("itemType", i), "Item", choices = itemList$ItemTab["name"], multiple = FALSE)
    })
  })
  
  output$dynamicOrderGen2 <- renderUI({
    lapply(1:(input$NumberOfOrders), function(i) {
      numericInput(paste0("netP", i), paste("Net Price", input$OrderLocation), value = priceFinder(input[[paste0("itemType", i)]], input$OrderLocation))
    })
  })
  
  output$dynamicOrderGen3 <- renderUI({
    lapply(1:(input$NumberOfOrders), function(i) {
      numericInput(paste0("ttlItemPrice", i), "Total Price", value = (input[[paste0("orderQuantity", i)]] * input[[paste0("netP", i)]]))
    })
  })
  fieldsAll <- c("ItemName","ItemWeight","ItemPVn","ItemPUs", "ItemSpec")
  genOrderFields <- c( "OrderNumber", "CustName", "CustLast", "CustPhone", "FaceBookId", "NumberOfOrders", "OrderLocation", "ShippingCost", "orederMemo")
  
  dynamicOrderFields <- reactive({
    fields <- list()
    for(i in 1:input$NumberOfOrders) {
      fields[[i]] <- c(input[[paste0("orderQuantity", i)]], input[[paste0("itemType", i)]], input[[paste0("netP", i)]], input[[paste0("ttlItemPrice", i)]])
    }
    return(fields)
  })
  
  ItemformData <- reactive({
    data <- sapply(fieldsAll, function(x) input[[x]])
    data <- t(data)
    data
  }) 
  
  OrderformData <- reactive({
    data <- sapply(genOrderFields, function(x) input[[x]])
    data <- t(data)
    data
  })
  
  observeEvent(input$addItem, {
    addItem(DataCollector("NewItem"))
    updateTextInput(session,"ItemName", value="")
    updateNumericInput(session,"ItemWeight", value="")
    updateNumericInput(session,"ItemPVn", value="")
    updateNumericInput(session,"ItemPUs", value="")
    updateTextAreaInput(session,"ItemSpec", value="")
  })
  observeEvent(input$SaveOrder, {
    addOrder(DataCollector("NewOrder"))
    
  })
  # ----
  
  # DataCollector ----
  DataCollector <- function(wrapperFrom){
    if (wrapperFrom == "NewItem") {
      enteryVector <- ItemformData()
    } else if (wrapperFrom == "NewOrder") {
      inps <- unlist(dynamicOrderFields())
      enteryVector <- list(a = OrderformData(), b = inps)
    }
    return(enteryVector)
  }
  
})

# 
# 
# library(shiny)
# library(DT)
# library(shinyBS)
# source("Back.R")
# source("pipe.r")
# shinyServer(function(input, output, session) {
#   
#   # ItemPage----
#   itemList <- reactiveValues(ItemTab = loadModule("onlineBusiness","inventory_items"))
#   observe({
#     invalidateLater(100,session)
#     if (!identical(itemList$ItemTab, loadModule("onlineBusiness","inventory_items"))) { 
#       itemList$ItemTab <- loadModule("onlineBusiness","inventory_items")
#     }
#   })
#   output$itemTables = renderDataTable(
#     datatable(itemList$ItemTab)
#   )
#   output$itemForm <- renderUI ({
#     box(width = "full",
#         verticalLayout(
#           fluidRow(
#             column(3,textInput("ItemName","Item Name")),
#             column(3,textInput("ItemWeight", "Item Weight")),
#             column(3,numericInput("ItemPVn", "Item Price VN", value = 0)),
#             column(3,numericInput("ItemPUs", "Item Price US", value = 0))
#           ),
#           fluidRow(
#             column(12, textAreaInput("ItemSpec", "Specification"))
#           ),
#           hr(),
#           fluidRow(
#             column(3, offset = 4, align = "center", actionButton("addItem", "Add Item"))
#           ),
#           br(),
#           box(
#             title = "My ScoreBoard",
#             width = NULL,
#             status = "primary", 
#             solidHeader = TRUE,
#             collapsible = TRUE,
#             div(style = 'overflow-x: scroll',dataTableOutput("itemTables"))
#           )
#         )
#         
#     )
#   })
#   fieldsAll <- c("ItemName","ItemWeight","ItemPVn","ItemPUs", "ItemSpec")
#   ItemformData <- reactive({
#     data <- sapply(fieldsAll, function(x) input[[x]])
#     data <- t(data)
#     data
#   })
#   observeEvent(input$addItem, {
#     addItem(DataCollector("NewItem"))
#     updateTextInput(session,"ItemName", value="")
#     updateNumericInput(session,"ItemWeight", value="")
#     updateNumericInput(session,"ItemPVn", value="")
#     updateNumericInput(session,"ItemPUs", value="")
#     updateTextAreaInput(session,"ItemSpec", value="")
#   })
#   
#   # ----# ItemPage----
#   ordersList <- reactiveValues(orderTab = loadModule("onlineBusiness","orders_list"))
#   observe({
#     invalidateLater(100,session)
#     if (!identical(ordersList$orderTab, loadModule("onlineBusiness","orders_list"))) { 
#       ordersList$orderTab <- loadModule("onlineBusiness","orders_list")
#     }
#   })
#   output$orderTab = renderDataTable(
#     datatable(ordersList$orderTab)
#   )
#   output$orderForms <- renderUI ({
#     box(width = "full",
#         verticalLayout(
#           fluidRow(
#             column(3,textInput("OrderNumber","Order Num.", value = idCreator(ordersList$orderTab, "SnackOrder"))),
#             column(3,textInput("CustName", "Customer Name")),
#             column(3,textInput("CustLast", "Customer LastN")),
#             column(3,numericInput("CustPhone", "Customer Phone Number", value = 0))
#           ),
#           hr(),
#           fluidRow(
#             column(4, textInput("FaceBookId", "FaceBook ID")),
#             column(2, numericInput("NumberOfOrders", "Total Items Ordered", value = 1, max = 6, min = 1)),
#             column(1, radioButtons("OrderLocation", "Location", choices = c("VN" = "VNd", "US" = "USD"))),
#             column(2, numericInput("ShippingCost", "Shipping Cost", value = 0)),
#             column(3, textInput("orederMemo", "Addr & Memo"))
#           ),
#           verticalLayout(
#             box( width = "full",
#                  fluidPage(
#                    uiOutput("dynamicOrderGen1"),
#                    uiOutput("dynamicOrderGen2"),
#                    uiOutput("dynamicOrderGen3"),
#                    uiOutput("dynamicOrderGen4"),
#                    uiOutput("dynamicOrderGen5"),
#                    uiOutput("dynamicOrderGen6")
#                  )
#             ),
#             fluidRow(
#               column(3, offset = 3, actionButton("SaveOrder", "Save Order")),
#               column(3, offset = 3, downloadButton("dlRecipt", "Download Recipt"))
#             )
#           )
#         )
#     )
#   })
#   output$dynamicOrderGen1 <- renderUI({
#     fluidRow(
#       column(1,numericInput(paste0("orderQuantity", 1), label = "Quantity", value = NA)),
#       column(7,selectInput(paste0("itemType", 1), "Item", choices = itemList$ItemTab["name"], multiple = FALSE)),
#       column(2,numericInput(paste0("netP", 1), paste("Net Price", input$OrderLocation), value = priceFinder(input[[paste0("itemType", 1)]], input$OrderLocation))),
#       column(2,numericInput(paste0("ttlItemPrice", 1), "Total Price", value = (input[[paste0("orderQuantity", 1)]] * input[[paste0("netP", 1)]])))
#     )
#   })
#   output$dynamicOrderGen2 <- renderUI({
#     lapply(1:(input$NumberOfOrders), function(i) {
#       fluidRow(
#         column(1,numericInput(paste0("orderQuantity", 2), label = "Quantity", value = NA)),
#         column(7,selectInput(paste0("itemType", 2), "Item", choices = itemList$ItemTab["name"], multiple = FALSE)),
#         column(2,numericInput(paste0("netP", 2), paste("Net Price", input$OrderLocation), value = priceFinder(input[[paste0("itemType", 2)]], input$OrderLocation))),
#         column(2,numericInput(paste0("ttlItemPrice", 2), "Total Price", value = (input[[paste0("orderQuantity", 2)]] * input[[paste0("netP", 2)]])))
#       )
#     })
#   })
#   output$dynamicOrderGen3 <- renderUI({
#     lapply(1:(input$NumberOfOrders), function(i) {
#       fluidRow(
#         column(1,numericInput(paste0("orderQuantity", 3), label = "Quantity", value = NA)),
#         column(7,selectInput(paste0("itemType", 3), "Item", choices = itemList$ItemTab["name"], multiple = FALSE)),
#         column(2,numericInput(paste0("netP", 3), paste("Net Price", input$OrderLocation), value = priceFinder(input[[paste0("itemType", 3)]], input$OrderLocation))),
#         column(2,numericInput(paste0("ttlItemPrice", 3), "Total Price", value = (input[[paste0("orderQuantity", 3)]] * input[[paste0("netP", 3)]])))
#       )
#     })
#   })
#   output$dynamicOrderGen4 <- renderUI({
#     lapply(1:(input$NumberOfOrders), function(i) {
#       fluidRow(
#         column(1,numericInput(paste0("orderQuantity", 4), label = "Quantity", value = NA)),
#         column(7,selectInput(paste0("itemType", 4), "Item", choices = itemList$ItemTab["name"], multiple = FALSE)),
#         column(2,numericInput(paste0("netP", 4), paste("Net Price", input$OrderLocation), value = priceFinder(input[[paste0("itemType", 4)]], input$OrderLocation))),
#         column(2,numericInput(paste0("ttlItemPrice", 4), "Total Price", value = (input[[paste0("orderQuantity", 4)]] * input[[paste0("netP", 4)]])))
#       )
#     })
#   })
#   output$dynamicOrderGen5 <- renderUI({
#     lapply(1:(input$NumberOfOrders), function(i) {
#       fluidRow(
#         column(1,numericInput(paste0("orderQuantity", 5), label = "Quantity", value = NA)),
#         column(7,selectInput(paste0("itemType", 5), "Item", choices = itemList$ItemTab["name"], multiple = FALSE)),
#         column(2,numericInput(paste0("netP", 5), paste("Net Price", input$OrderLocation), value = priceFinder(input[[paste0("itemType", 5)]], input$OrderLocation))),
#         column(2,numericInput(paste0("ttlItemPrice", 5), "Total Price", value = (input[[paste0("orderQuantity", 5)]] * input[[paste0("netP", 5)]])))
#       )
#     })
#   })
#   output$dynamicOrderGen6 <- renderUI({
#     lapply(1:(input$NumberOfOrders), function(i) {
#       fluidRow(
#         column(1,numericInput(paste0("orderQuantity", 6), label = "Quantity", value = NA)),
#         column(7,selectInput(paste0("itemType", 6), "Item", choices = itemList$ItemTab["name"], multiple = FALSE)),
#         column(2,numericInput(paste0("netP", 6), paste("Net Price", input$OrderLocation), value = priceFinder(input[[paste0("itemType", 6)]], input$OrderLocation))),
#         column(2,numericInput(paste0("ttlItemPrice", 6), "Total Price", value = (input[[paste0("orderQuantity", 6)]] * input[[paste0("netP", 6)]])))
#       )
#     })
#   })
#   fieldsAll <- c("ItemName","ItemWeight","ItemPVn","ItemPUs", "ItemSpec")
#   genOrderFields <- c( "OrderNumber", "CustName", "CustLast", "CustPhone", "FaceBookId", "NumberOfOrders", "OrderLocation", "ShippingCost", "orederMemo")
#   
#   dynamicOrderFields <- reactive({
#     fields <- list()
#     for(i in 1:input$NumberOfOrders) {
#       fields[[i]] <- c(input[[paste0("orderQuantity", 1)]], input[[paste0("itemType", 1)]], input[[paste0("netP", 1)]], input[[paste0("ttlItemPrice", 1)]])
#     }
#     return(fields)
#   })
#   
#   ItemformData <- reactive({
#     data <- sapply(fieldsAll, function(x) input[[x]])
#     data <- t(data)
#     data
#   }) 
#   
#   OrderformData <- reactive({
#     data <- sapply(genOrderFields, function(x) input[[x]])
#     data <- t(data)
#     data
#   })
#   
#   observeEvent(input$addItem, {
#     addItem(DataCollector("NewItem"))
#     updateTextInput(session,"ItemName", value="")
#     updateNumericInput(session,"ItemWeight", value="")
#     updateNumericInput(session,"ItemPVn", value="")
#     updateNumericInput(session,"ItemPUs", value="")
#     updateTextAreaInput(session,"ItemSpec", value="")
#   })
#   observeEvent(input$SaveOrder, {
#     addOrder(DataCollector("NewOrder"))
#     
#   })
#   # ----
#   
#   # DataCollector ----
#   DataCollector <- function(wrapperFrom){
#     if (wrapperFrom == "NewItem") {
#       enteryVector <- ItemformData()
#     } else if (wrapperFrom == "NewOrder") {
#       inps <- unlist(dynamicOrderFields())
#       enteryVector <- list(a = OrderformData(), b = inps)
#     }
#     return(enteryVector)
#   }
#   
# })
