library("causact")
library("lubridate")
library("dplyr")
library("readr")

data("delivDF")

shipDF <- delivDF

write_csv(shipDF, 'shipDF.csv')

shipDF$plannedShipDate <- mdy(shipDF$plannedShipDate)
shipDF$actualShipDate <- mdy(shipDF$actualShipDate)

shipDF$actualShipDate[1] - shipDF$plannedShipDate[1]

today()

thisDay = today()
year(thisDay)
month(thisDay)
wday(thisDay)
yday(thisDay)

wday(thisDay, label = TRUE)

shipDateDF <- shipDF |> 
  select(shipID, plannedShipDate, actualShipDate) |> 
  distinct() |> 
  mutate(
    lateFlag = ifelse(actualShipDate > plannedShipDate, TRUE, FALSE)
  )

shipDateDF |> 
  group_by(lateFlag) |> 
  summarise(countLate = n()) |> 
  mutate(proportion = countLate / sum(countLate))

data(prodLineDF)
prodLineDF

write_csv(prodLineDF, 'prodLineDF.csv')

catDF <- shipDF |> 
  left_join((prodLineDF)) |> 
  filter(!is.na(prodCategory))

# 7.4