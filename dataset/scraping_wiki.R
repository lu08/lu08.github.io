library(rvest)
library(tidyverse)

# 1. Define the Wikipedia URL
url <- "https://en.wikipedia.org/wiki/List_of_tallest_buildings"

# 2. Read the page content
page <- read_html(url)

# 3. Extract all tables from the page
tables <- page %>% html_nodes("table") %>% html_table()

# 4. Select the specific table (e.g., the first one)
# Note: Use [[index]] to select which table you want from the list
target_table <- tables[[2]]

#---data cleaning---#
my_table <- target_table[-1,]
names(my_table) <- c('Rank','Name','Height_m',"Height_f","Floors","Image","City","Location","Year","Comments","Ref")
my_table <- my_table %>% select(-c(Image,Ref))

#-------------------#

# 5. Export to CSV
write.csv(my_table, "tallest building_2026.csv", row.names = FALSE)
