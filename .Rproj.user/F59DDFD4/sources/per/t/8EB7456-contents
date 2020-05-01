library(shinythemes)
library(shiny)
library(shinydashboard)
# Header elements for the visualization
header <- dashboardHeader(title = "ManagmentApp", disable = FALSE)

# Sidebar elements for the search visualizations
sidebar <- dashboardSidebar(
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "custom.css"),
    tags$script(src = "custom.js")
  ),
  sidebarMenu(
    menuItem(text = "Item Form", tabName = "Add_to_Inventory"),
    menuItem(text = "Order Creator", tabName = "Generate_Recipts"),
    menuItem(text = "Financial Managment", tabName = "Financial_Management")
    # /menuItem
    # this is where other menuItems & menuSubItems would go
  )
) # /dashboardSidebar

#Body elements for the search visualizations.
body <- dashboardBody(
  tabItems(
    tabItem(tabName = "Add_to_Inventory", uiOutput("itemForm")),
    tabItem(tabName = "Generate_Recipts", uiOutput("orderForms")),
    tabItem(tabName = "Financial_Management", uiOutput("finance")),
    tabItem(tabName = "Tst",
            p("incoming")
    )
  )
) # /tabItems) # /dashboardBody

dashboardPage(header, sidebar, body, skin = "green")

