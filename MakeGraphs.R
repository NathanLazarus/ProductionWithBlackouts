tryCatch(find.package('pacman'), error = function(e) install.packages("pacman"))
pacman::p_load(data.table, ggplot2)
setwd("C:/Users/Nathan/Research/Blackouts")
data = fread("ProfitsWithAndWithoutGenerators.csv")
data[
  ,
  type_str := paste(
    fifelse(gen == 1, "Gen", "NoGen"),
    fifelse(pG2 == 1e10, "VariablePrice", "FixedPrice"),
    sep = "_"
  )
]

ggplot(data) +
  geom_line(aes(x = A, y = profits, group = type_str))
