library(shiny)
library(DT)
library(shinyBS)
library(gridExtra)
library(rmarkdown)
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
            column(10, textAreaInput("ItemSpec", "Specification")),
            column(2, textAreaInput("ItemQuantity", "Item Quantity"))
          ),
          hr(),
          fluidRow(
            column(3, offset = 4, align = "center", actionButton("addItem", "Add Item"))
          ),
          br(),
          box(
            title = "Item Legend",
            width = NULL,
            status = "primary", 
            solidHeader = TRUE,
            collapsible = TRUE,
            div(style = 'overflow-x: scroll',dataTableOutput("itemTables"))
          )
        )
    )
  })
  fieldsAll <- c("ItemName","ItemWeight","ItemPVn","ItemPUs", "ItemSpec", "ItemQuantity")
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
  
  
  # ---- Order Page ----
  ordersList <- reactiveValues(orderTab = loadModule("onlineBusiness","orders_list"))
  PendingOrder <- reactiveValues(table = loadModule("onlineBusiness","pending_orders"))
  
  observe({
    invalidateLater(100,session)
    if (!identical(ordersList$orderTab, loadModule("onlineBusiness","orders_list"))) { 
      ordersList$orderTab <- loadModule("onlineBusiness","orders_list")
    }
  })
  observe({
    invalidateLater(100,session)
    if (!identical(PendingOrder$table, loadModule("onlineBusiness","pending_orders"))) { 
      PendingOrder$table <- loadModule("onlineBusiness","pending_orders")
    }
  })
  
  output$PendingOrderTable = renderDataTable(
    datatable(PendingOrder$table)
  )
  
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
            column(3,textInput("CustPhone", "Customer Phone Number", value = 0))
          ),
          hr(),
          fluidRow(
            column(4, textInput("FaceBookId", "FaceBook ID")),
            column(3, textInput("addr", "Shipping Address")),
            column(1, radioButtons("OrderLocation", "Location", choices = c("VN" = "VNd", "US" = "USD"))),
            column(2, numericInput("ShippingCost", "Shipping Cost", value = 0)),
            column(2, textInput("orederMemo", "Memo"))
          ),
          verticalLayout(
            box( width = "full",
                 fluidPage(
                   fluidRow(
                     column(1,uiOutput("dynamicOrderGen1")),
                     column(7,uiOutput("dynamicOrderGen2")),
                     column(2,uiOutput("dynamicOrderGen3")),
                     column(2,uiOutput("dynamicOrderGen4"))
                   ),
                   hr(),
                   fluidRow(column(3, offset = 2, actionButton("addOrder", "Add Item To List")),
                            column(3, actionButton("delItemOrder", "Delete Selected Item")),
                            column(3, actionButton("clearOrder", "Clear Order List")))
                 )
            ),
            box(width = "full", height = "auto",
                verticalLayout(
                  dataTableOutput("PendingOrderTable"),
                  hr(),
                  fluidRow(
                    column(3,uiOutput("dynamicOrderGen5")),
                    column(3,uiOutput("dynamicOrderGen6")),
                    column(3,uiOutput("dynamicOrderGen7")),
                    column(3,uiOutput("dynamicOrderGen8"))
                    )
                  )
                ),
            fluidRow(
              column(3, offset = 3, actionButton("SaveOrder", "Save Order")),
              column(3, offset = 2, downloadButton("dlRecipt", "Download Recipt"))
            )
          )
        )
    )
  })
  
  output$dynamicOrderGen1 <- renderUI({
          numericInput("orderQuantity", label = "Quantity", value = 1)
  })
  output$dynamicOrderGen2 <- renderUI({
          selectInput("itemType", "Item", choices = itemList$ItemTab["name"], multiple = FALSE)
  })
  output$dynamicOrderGen3 <- renderUI({
          numericInput("netP", paste("Net Price", input$OrderLocation), value = priceFinder(input[["itemType"]], input$OrderLocation))
  })
  output$dynamicOrderGen4 <- renderUI({
          numericInput("ttlItemPrice", "Total Price", value = (input[["orderQuantity"]] * input[["netP"]]))
  })
  output$dynamicOrderGen5 <- renderUI({
    numericInput("ttalRecipt", "Total Price", value = sum((PendingOrder$table)$Item_Total_Price))
  })
  output$dynamicOrderGen6 <- renderUI({
    numericInput("pdis", "Amount Discount", value = 0)
  })
  output$dynamicOrderGen8 <- renderUI({
    numericInput("ttalWShipping", "Total Price With Shipping", value = input[["ShippingCost"]] + input[["ttAftD"]])
  })
  output$dynamicOrderGen7 <- renderUI({
    req(input$pdis)
    if(input[["pdis"]] != 0) {
      numericInput("ttAftD", "Total With Discount", value = input[["ttalRecipt"]] - (input[["ttalRecipt"]] * input[["pdis"]]))
    } else {
      numericInput("ttAftD", "Total With Discount", value = input[["ttalRecipt"]] * 1)
    }
    
  })
  
  
  genOrderFields <- c("OrderNumber", "CustName", "CustLast", "CustPhone", "FaceBookId", "addr", "OrderLocation", "ShippingCost", "orederMemo", "ttalRecipt", "pdis", "ttAftD", "ttalWShipping")
  orderRowFields <- c("orderQuantity", "itemType", "netP", "ttlItemPrice")
  OrderformData <- reactive({
    data <- sapply(genOrderFields, function(x) input[[x]])
    data <- t(data)
    data
  })
  observeEvent(input$SaveOrder, {
    addOrder(DataCollector("NewOrder"))
  })
  observeEvent(input$addOrder, {
    addRowOrder(DataCollector("OrderRow"))
  })
  # observeEvent(input$dlRecipt, {
  #   addOrder(DataCollector("NewOrder"))
  #   recipt <- render('ReciptGen.Rmd',params= list( id= input$OrderNumber )) 
  #   recipt <- render('ReciptGen.Rmd',params= list( id= "SS351542")) 
  # })
  output$dlRecipt <- downloadHandler(
    
    filename = "ReciptGen.pdf",
    content = function(file) {
      addOrder(DataCollector("NewOrder"))
      tempReport <- file.path(tempdir(), "ReciptGen.Rmd")
      file.copy("ReciptGen.Rmd", tempReport, overwrite = TRUE)
      rmarkdown::render(tempReport, output_file = file,
                        params = list(id = input$OrderNumber)
      )
    }
  )
  
  observeEvent(input$delItemOrder ,{
    delModule("onlineBusiness","pending_orders", (PendingOrder$table)$id[input$PendingOrderTable_rows_selected])
  })
  observeEvent(input$clearOrder ,{
    for(a in (PendingOrder$table)$id) {
      delModule("onlineBusiness","pending_orders", a)  
    }
  })
  # ---- Financial Managmet ----
  output$finance <- renderUI ({
    navbarPage("Finance",
      tabPanel("Manual Input",
               box(width = "full",
                   verticalLayout(
                     fluidRow(
                       column(4, selectInput("ManoperatorName", "Operator", choices = c("Phuong Nguyen"="PN", "MY TO"="MT", "Kia Peynbard"="KP"))),
                       column(4, offset = 4, dateInput("invoiceDate", "Date", value = Sys.Date()))
                     ),p("***Please Use CSV Input for Items More than 4 Accorance", style = "color:red"),
                     hr(),
                     fluidRow(column(2,numericInput("quant1", "Quantity", value = 0)),column(4,textInput("invItmName1", "Item")),column(3,numericInput("amountCost1", "Cost/Unit", value = 0)),column(3,selectInput("opType1", "Operetive", c("Income" = "1", "Cost" = "0")))),
                     fluidRow(column(2,numericInput("quant2", "Quantity", value = 0)),column(4,textInput("invItmName2", "Item")),column(3,numericInput("amountCost2", "Cost/Unit", value = 0)),column(3,selectInput("opType2", "Operetive", c("Income" = "1", "Cost" = "0")))),
                     fluidRow(column(2,numericInput("quant3", "Quantity", value = 0)),column(4,textInput("invItmName3", "Item")),column(3,numericInput("amountCost3", "Cost/Unit", value = 0)),column(3,selectInput("opType3", "Operetive", c("Income" = "1", "Cost" = "0")))),
                     fluidRow(column(2,numericInput("quant4", "Quantity", value = 0)),column(4,textInput("invItmName4", "Item")),column(3,numericInput("amountCost4", "Cost/Unit", value = 0)),column(3,selectInput("opType4", "Operetive", c("Income" = "1", "Cost" = "0")))),
                     fluidRow(
                       column(2, numericInput("ManItmins", "Ins", value = 0)),
                       column(2, numericInput("ManItmouts", "Outs", value = 0)),
                       column(2, numericInput("Manins", "Ins", value = 0)),
                       column(2, numericInput("Manouts", "Outs", value = 0)),
                       column(4, numericInput("ManttlInvoiceAmount", "Total Amount", value = sum(invoiceDF()$TotalItemPrice)))
                     ),
                     hr(),
                     fluidRow(column(3,offset = 3 ,actionButton("cleanTheInc", "Clear")), column(3,offset = 2,actionButton("addToBook", "Add")))
                   ) 
                )
      ),
      tabPanel("Inv Reader",
               box(width = "full",
                   verticalLayout(
                     fluidRow(
                       column(4, selectInput("operatorName", "Operator", choices = c("Phuong Nguyen"="PN", "MY TO"="MT", "Kia Peynbard"="KP"))),
                       column(4, fileInput("Invoice", "Insert Invoice",
                                           accept = c(
                                             "text/csv",
                                             "text/comma-separated-values,text/plain",
                                             ".csv")
                       )),
                       column(4, dateInput("invoiceDate", "Date", value = Sys.Date()))
                     ),
                     hr(),
                     dataTableOutput("invoiceTable"),
                     hr(),
                     fluidRow(
                       column(4, numericInput("ttlItems", "Total Quantity", value = sum(invoiceDF()$ItemQuantity))),
                       column(4, ""),
                       column(4, numericInput("ttlInvoiceAmount", "Total Amount", value = sum(invoiceDF()$TotalItemPrice)))
                     )
                   )
               )
      )
    )
  })
  
  invoiceDF <- reactive({
    inFile <- input$Invoice
    if (is.null(inFile))
      return(NULL)
    read.csv(inFile$datapath)
  })
  
  output$invoiceTable <- renderDataTable({
    inFile <- input$Invoice
    if (is.null(inFile))
      return(NULL)
    datatable(read.csv(inFile$datapath))
  })
  
  
  # DataCollector ----
  DataCollector <- function(wrapperFrom){
    if (wrapperFrom == "NewItem") {
      enteryVector <- ItemformData()
    } else if (wrapperFrom == "NewOrder") {
      enteryVector <- list(a = OrderformData(), b = orderEncoder())
    } else if (wrapperFrom == "OrderRow") {
      enteryVector <- c(input[["orderQuantity"]], input[["itemType"]], input[["netP"]], input[["ttlItemPrice"]])
    }
    return(enteryVector)
  }
  
})
