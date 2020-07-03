idCreator <- function(db, name){
  ValidID <- T
  id <- paste0(chr(round(runif(1, min =65,max = 90))), chr(round(runif(1, min =65,max = 90))) ,round(runif(1, min = 10,max = 1000) * 100), substring(name, 1, 1), substring(name, 2, 2))
  if (length(which(db$id %in% id))!= 0) {
    ValidID <- F
  }
  repeat {
    if (ValidID) {
      return(id)
      break
    }
  }
}

addItem <- function(entaryVec) {
  db  <- loadModule("onlineBusiness","inventory_items")
  id <- idCreator(db, entaryVec[1])
  name <- entaryVec[1]
  weight <- entaryVec[2]
  priceVN <- entaryVec[3]
  priceUS <- entaryVec[4]
  specifications <- entaryVec[5]
  quantity <- entaryVec[6]
  entary <- data.frame(list(id,name,weight,priceVN,priceUS,specifications,quantity))
  colnames(entary) <- names(db)
  adderModule(entary, "onlineBusiness", "inventory_items")
}

addOrder <- function(entaryVec) {
  db  <- loadModule("onlineBusiness","orders_list")
  generalInfo <- entaryVec$a
  orderItems <-  entaryVec$b

  for (i in 1:24) {
    if(is.null(orderItems[i])) {
      orderItems[i] <- NULL
    }
  }
  id <- generalInfo[1]
  CustName <- generalInfo[2]
  CustLast <- generalInfo[3]
  CustPhone <- generalInfo[4]
  FaceBookId <- generalInfo[5]
  Addr <- generalInfo[6]
  Location <- generalInfo[7]
  Date <- paste(as.Date(Sys.Date()))
  ShippingCost <- generalInfo[8]
  AddrOrederMemo <- generalInfo[9]
  Stat <- paste(generalInfo[10], generalInfo[11], generalInfo[12], generalInfo[13], sep = ";")
  ORQ <- orderItems[1]
  ORN <- orderItems[2]
  ORNP  <- orderItems[3]
  ORTP  <- orderItems[4]
  
  entary <- data.frame(list(id, CustName, CustLast, CustPhone, FaceBookId, Addr, Location, ShippingCost, Date, AddrOrederMemo, ORN, ORQ, ORNP, ORTP, Stat))
  colnames(entary) <- names(db)
  
  if (id %in% db[["id"]]) {
    updateModule(entary, "onlineBusiness", "orders_list", id)
  } else {
    adderModule(entary, "onlineBusiness", "orders_list")
  }
}

addRowOrder <- function(enteryVector) {
  db  <- loadModule("onlineBusiness","pending_orders")
  nameDb  <- loadModule("onlineBusiness","inventory_items")
  
  id <- nameDb[which(nameDb$name %in% enteryVector[2]),]$id
  ItemQuantity <- enteryVector[1]
  ItemName <- enteryVector[2]
  ItemNetPrice <- enteryVector[3]
  ItemTotalPrice <- enteryVector[4]
  
  if(id %in% db$id) {
    ItemQuantity <- as.numeric(ItemQuantity) + as.numeric(db[which(db$id %in% id),]$Item_Quantity)
    ItemTotalPrice <- as.numeric(ItemTotalPrice) + as.numeric(db[which(db$id %in% id),]$Item_Total_Price)
    entary <- data.frame(list(id, ItemName, ItemQuantity, ItemNetPrice, ItemTotalPrice))
    colnames(entary) <- names(db)
    updateModule(entary, "onlineBusiness", "pending_orders", id)
  } else {
    entary <- data.frame(list(id, ItemName, ItemQuantity, ItemNetPrice, ItemTotalPrice))
    colnames(entary) <- names(db)
    adderModule(entary, "onlineBusiness", "pending_orders")
  }
}
# Price Finder Base On Product Name
priceFinder <- function(nameOfP, location = "USD") {
  items <- loadModule("onlineBusiness","inventory_items")
  if(!is.null(nameOfP)&&!is.null(location)){
    if (location=="USD") {
      price <- items[which(items$name %in% nameOfP),]$priceUS
    } else {
      price <- items[which(items$name %in% nameOfP),]$priceVN
    }
  } else {
    price <- 0
  }
  
  return(price)
}

orderEncoder <- function() {
  o <- loadModule("onlineBusiness","pending_orders")
  o <- o[2:ncol(o)]
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
  return(aList)
}

orderMaker <- function(id) {
  orders <- loadModule("onlineBusiness","orders_list")
  orders <- orders[which(orders$id %in% id), ]
  ordersInit <- orders[c("CustName", "CustLast","FaceBookId", "date")]
  orderAddr <- orders[["Addr"]]
  shippingCost <- orders[["ShippingCost"]]
  info <- unlist(strsplit(orders[["Stat"]], ";"))
  return(list(ordersInit = ordersInit, orderAddr = orderAddr, stat = info, shippingCost = shippingCost))
}
# RMarkDown
tableMaker <- function() {
  table <- loadModule("onlineBusiness","pending_orders")
  a <- names(table)
  colnames(table) <- c("Id", "Item Name", "Item Quantity", "Item Net Price", "Item Total Price")
  return(table)
}