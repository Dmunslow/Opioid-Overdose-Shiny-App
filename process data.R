######################################
#### Opioid Shiny app test script ####
######################################

library(dplyr)
library(googleVis)


opioid_states <- read.table("./overdoses_states.txt", header = T, na.strings = c("Unreliable", "Suppressed"))

# remove pct symbols & convert to numeric
opioid_states$PCT_of_Total_Deaths <- as.numeric(gsub("%", "", opioid_states$PCT_of_Total_Deaths))

opioid_states <- tbl_df(opioid_states)

opioid_states$Multiple_Cause_of_death <- as.character(opioid_states$Multiple_Cause_of_death)

opioid_2015 <- filter(opioid_states, Year == 2015)

opioid_2015_heroin <- filter(opioid_states, Year == 2015, Multiple_Cause_of_death == "Heroin")


## group by state and year, calculate total death rates

states_grouped <- group_by(opioid_states, State, Year)

totals <- summarise(states_grouped, Deaths = sum(Deaths, na.rm = T), Crude_Rate = sum(Crude_Rate, na.rm = T), PCT_of_Total_Deaths = sum(PCT_of_Total_Deaths,na.rm = T))

totals$Multiple_Cause_of_death <- rep("All Opioids", length(totals$State))

# Merge data frames to produce final output

opioid_merge <- select(opioid_states, State, Year, Deaths, Crude_Rate, PCT_of_Total_Deaths, Multiple_Cause_of_death)

# Create final data frame
overdoses <- rbind(as.data.frame(opioid_merge), as.data.frame(totals))

# Arrange data by state and year

overdoses <- arrange(overdoses, desc(State), Year)

# write the dataframe to file

write.csv(overdoses, "./overdose_processed_states.csv", row.names = F)



#subset to all opioids

overdose_all <- filter(overdoses, Multiple_Cause_of_death == "All Opioids")
#cloropleth map - heroin overdoses

overdoseStates_DR  <- gvisGeoChart(opioid_2015_heroin, "State", "Crude_Rate", options = list(region="US",
                                                                                             displayMode = "regions",
                                                                                             resolution = "provinces",
                                                                                             width = 600, height = 400))

overdoseStates_DR  <- gvisGeoChart(opioid_2015_heroin, "State", "Crude_Rate", options = list(region="US",
                                                                                             displayMode = "regions",
                                                                                             resolution = "provinces",
                                                                                             width = 600, height = 400))


plot(overdoseStates_DR)


overdoseStates_All  <- gvisGeoChart(overdose_all, "State", "Crude_Rate", options = list(region="US",
                                                                                             displayMode = "regions",
                                                                                             resolution = "provinces",
                                                                                             width = 600, height = 400))

plot(overdoseStates_All)

overdoseStates_PCT <- gvisGeoChart(opioid_2015_heroin, "State", "PCT_of_Total_Deaths", options = list(region="US",
                                                                                                      displayMode = "regions",
                                                                                                      resolution = "provinces",
                                                                                                      width = 600, height = 400))
plot(overdoseStates_PCT)