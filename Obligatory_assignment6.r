library(tibble)
library(tidyverse)


#TASK 1!
DS = tribble(
  ~fk_account_code, ~Ansvar, ~fk_function_code, ~fk_project_code, ~amount,
  101030,40220,"Det",3432,1493.00,
  101030,40220,"Met",3586,2827.00,
  101030,40320,"Det",3456,49440.00,
  101030,40330,"Sal",NA,870716.00,
  101030,40350,"Met",NA,559928.00,
  101030,40360,"Sal",NA,125534.00,
  101030,40280,"Pol",NA,251611.00)


#Removing the collumn fk_project_code.
DS$fk_project_code = NULL

#Renaming labels within the ~fk_function_code.
DS$fk_function_code[DS$fk_function_code %in% "Det"] <- "Supplies"


DS$fk_function_code[DS$fk_function_code %in% "Sal"] <- "Supplies"


DS$fk_function_code[DS$fk_function_code %in% "Met"] <- "Inventories"


DS$fk_function_code[DS$fk_function_code %in% "Pol"] <- "Expenses"


#TASK 2!
df <- data.frame(Product=gl(3,10,labels=c("A","B", "C")), 
                 Year=factor(rep(2002:2011,3)), 
                 Sales=1:30)

df_A <- df %>%
  filter(Product == "A") %>%
  mutate(Sales_share = Sales/55)

df_B <- df %>%
  filter(Product == "B") %>%
  mutate(Sales_share = Sales/165)

df_C <- df %>%
  filter(Product == "C") %>%
  mutate(Sales_share = Sales/255)

df <- rbind(df_A, df_B, df_C)
