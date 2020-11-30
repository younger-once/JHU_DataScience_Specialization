# load libraries
library(dplyr)
library(gridExtra)

# read in data file
NEI <- readRDS("summarySCC_PM25.rds")

# subset NEI to include Baltimore, MD and LA County, CA
# aggregate emissions by year and city
# also create new variable Emissions_Rel99 to describe emissions on relative scale
balt_la <- NEI %>% 
  filter(fips %in% c("24510","06037")) %>%
  group_by(fips) %>% 
  mutate(tons99 = sum(ifelse(year == 1999,Emissions,0))) %>% 
  ungroup() %>% 
  mutate(
    city = case_when(
      fips == "24510" ~"Baltimore",
      fips == "06037" ~ "Los Angeles",
      TRUE ~ "Unknown"),
    Emissions_Rel99 = Emissions / tons99
    ) %>% 
  group_by(city, year) %>% 
  summarise(Emissions = sum(Emissions),
            Emissions_rel = sum(Emissions_Rel99))


# plot Baltimore vs LA on absolute basis
p1 <- ggplot(balt_la, aes(year,Emissions, color=city)) + 
  geom_line() + geom_point() + 
  theme_classic() +
  labs(y= "tons", title = "Absolute Scale: Baltimore vs Los Angeles PM2.5 Emissions by Year") + 
  scale_x_continuous(breaks = seq(1999,2008,3)) +
  scale_color_brewer(type = "qual",palette=6) 

# plot Baltimore vs LA on relative basis (i.e. relative to 1999 baseline) 
p2 <- ggplot(balt_la, aes(year,Emissions_rel, color=city)) + 
  geom_line() + geom_point() + 
  theme_classic() +
  labs(y= "tons relative to 1999 level", title = "Relative Scale: Baltimore vs Los Angeles PM2.5 Emissions by Year") + 
  scale_x_continuous(breaks = seq(1999,2008,3)) +
  scale_color_brewer(type = "qual",palette=6) 

# aggregate plots together into one master plot  
combined_plot <- arrangeGrob(p1,p2)

# save as png file
ggsave("plot6.png",combined_plot)

# turn off graphical device
dev.off()
