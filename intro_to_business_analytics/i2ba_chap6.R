library(dplyr)
as_tibble((mtcars))

data()

library(nycflights13)

flights = flights

write.csv(flights, 'flights.csv')

flights |> 
  filter(day == 1, month == 1)

flights |> 
  arrange(year, month, day) |> 
  arrange(desc(arr_delay))

flights |> 
  select(year, month, day)

flights |> 
  select(-(year:day))

flights |> 
  select(tailnum) |> 
  distinct()

flightSpeedDF <- flights |> 
  select(distance, air_time) |> 
  mutate(speed = distance / air_time * 60)

flights |> 
  summarize(
    delay = mean(dep_delay, na.rm = TRUE)
  )

destinations <- flights |> 
  group_by(dest)

destDF <- destinations |> 
  summarize(
    planes = n_distinct(tailnum),
    flights = n()
  )

lightSpeedDF4 <- flights |> 
  select(distance, air_time, dest) |> 
  mutate(speed = distance / air_time *60) |> 
  group_by(dest) |> 
  summarize(avgSpeed = mean(speed, na.rm = TRUE)) |> 
  arrange(desc(avgSpeed))
