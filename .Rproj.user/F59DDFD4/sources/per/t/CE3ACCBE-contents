library(RMySQL)
options(mysql = list(
  "host" = "127.0.0.1",
  "port" = 3306,
  "user" = "root",
  "password" = "2101991-393Kp2"
))

adderModule <- function(data, databaseName, table) {
  # Connect to the database
  options(stringsAsFactors = FALSE)
  db <- dbConnect(MySQL(), dbname = databaseName, host = options()$mysql$host, 
                  port = options()$mysql$port, user = options()$mysql$user, 
                  password = options()$mysql$password)
  # Construct the update query by looping over the data fields
 
    query <- sprintf(
      "INSERT INTO %s (%s) VALUES ('%s')",
      table,
      paste(names(data), collapse = ", "),
      paste(data, collapse = "', '")
    )
  # Submit the update query and disconnect
  dbGetQuery(db, query)
  dbDisconnect(db)
}

updateModule <- function(data, databaseName, table, id) {
  # Connect to the database
  options(stringsAsFactors = FALSE)
  db <- dbConnect(MySQL(), dbname = databaseName, host = options()$mysql$host, 
                  port = options()$mysql$port, user = options()$mysql$user, 
                  password = options()$mysql$password)
  
  if (table == "pending_orders"){
    query <- paste0("UPDATE ", table, " SET CustName = ","'", data["CustName"],"',", " CustLast = ", "'", data["CustLast"], "',"," CustPhone = ", "'",data["CustPhone"],"',", " FaceBookId = ", "'",data["FaceBookId"], "',", " Addr = ", "'",data["Addr"], "',", " Location = ", "'",data["Location"], "',", " ShippingCost = ", "'",data["ShippingCost"], "',", " date = ", "'",data["date"], "',", " OrederMemo = ", "'",data["OrederMemo"], "',", " ORQ = ", "'",data["ORQ"], "',", " ORN = ", "'",data["ORN"], "',", " ORNP = ", "'",data["ORNP"], "',", " ORTP = ", "'",data["ORTP"], "',", " Stat = ", "'",data["Stat"], 
                    "'"," WHERE id = ", "'",id,"';")
  } else if  (table == "orders_list") {
    query <- paste0("UPDATE ", table, " SET Item_Quantity = ","'", data["Item_Quantity"],"',", " Item_Name = ", "'", data["Item_Name"], "',"," Item_Net_Price = ", "'",data["Item_Net_Price"],"',", " Item_Total_Price = ", "'",data["Item_Total_Price"], 
                    "'"," WHERE id = ", "'",id,"';")
  }
  dbGetQuery(db, query)
  dbDisconnect(db)
}

delModule <- function(databaseName, table, id) {
  # Connect to the database
  options(stringsAsFactors = FALSE)
  db <- dbConnect(MySQL(), dbname = databaseName, host = options()$mysql$host, 
                  port = options()$mysql$port, user = options()$mysql$user, 
                  password = options()$mysql$password)
  
  query <- paste0("DELETE FROM ",table," WHERE id = '",id,"';", sep = "") 
  dbGetQuery(db, query)
  dbDisconnect(db)
}

loadModule <- function(databaseName, table) {
  # Connect to the database
  db <- dbConnect(MySQL(), dbname = databaseName, host = options()$mysql$host, 
                  port = options()$mysql$port, user = options()$mysql$user, 
                  password = options()$mysql$password)
  # Construct the fetching query
  query <- sprintf("SELECT * FROM %s", table)
  # Submit the fetch query and disconnect
  data <- dbGetQuery(db, query)
  dbDisconnect(db)
  return(data)
}
