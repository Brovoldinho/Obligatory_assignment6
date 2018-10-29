library(tibble)
library(tidyverse)
library(tidyr)

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


#Make Ansvar a string

DS$Ansvar <- as.character(DS$Ansvar)

DS <- separate(DS, Ansvar, into = c("Ansvar1_3", "rest"), sep = 3)

DS %>% group_by(Ansvar1_3) %>% summarise(sum=sum(amount))

#Removing the collumn fk_project_code.
DS$fk_project_code = NULL

#Renaming labels within the ~fk_function_code.


DS <- DS %>% mutate(new_fk_function_code =
                case_when(fk_function_code =="Det"~"Supplies",
                          fk_function_code =="Sal"~"Supplies",
                          fk_function_code =="Met"~"Inventories",
                          fk_function_code =="Pol"~"Other expenses"))

DS$fk_function_code = NULL


#TASK 2!
df <- data.frame(Product=gl(3,10,labels=c("A","B", "C")), 
                 Year=factor(rep(2002:2011,3)), 
                 Sales=1:30)

library(data.table)


DT <- data.table(df)

# Choose index variable or key variable, when using data.table

setkey(DT, "Year")
# Calculate shares by year
DT <- DT[ , Share := Sales/(sum(Sales)), by=list(Year)]

library(latticeExtra)
asTheEconomist(
xyplot(Sales + Share ~ Year, groups=Product, data = DT,
       t="b", scales=list(relation="free", x=list(rot=45)),
       auto.key=list(space="top", column=3),
       main="Product information"))
