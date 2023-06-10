tryCatch(find.package('pacman'), error = function(e) install.packages("pacman"))
pacman::p_load(data.table, ggplot2, viridis, cowplot)
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

to_plot = data[type_str != "Gen_FixedPrice"]

myColors = viridis(n = 3, option = "turbo")
names(myColors) = unique(to_plot$type)
colScale = scale_colour_manual(name = "type", values = myColors)


ggplot(to_plot) +
  geom_line(aes(x = A, y = profits, group = type_str, color = type_str)) +
  theme_cowplot() +
  colScale

ggsave("ProfitsByProductivity.png")
