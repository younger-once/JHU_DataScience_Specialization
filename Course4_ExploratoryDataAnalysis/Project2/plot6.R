# load libraries
library(dplyr)
library(gridExtra)

# read in data files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# find row indices for sources (SCC) associated with motor vehicles in SCC data frame
# using Short.Name column, searching for term "veh" as proxy for motor vehicle
mv <- grep("veh",tolower(SCC$Short.Name))

# subset NEI to include Baltimore, MD and LA County, CA
# aggregate emissions by year and city
# also create new variable Emissions_Rel99 to describe emissions on relative scale
balt_la <- NEI %>% 
  filter(fips %in% c("24510","06037")) %>% 
  inner_join(SCC[mv,], by= "SCC") %>%  # joining on motor vehicle records
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

# plot to png
png('plot6.png')

# plot Baltimore vs LA on absolute basis
p1 <- ggplot(balt_la, aes(year,Emissions, color=city)) + 
  geom_line() + geom_point() + 
  theme_classic() +
  labs(y= "tons", title = "Absolute Scale: Baltimore vs LA Motor Vehicle Emissions by Year") + 
  scale_x_continuous(breaks = seq(1999,2008,3)) +
  scale_color_brewer(type = "qual",palette=6) 

# plot Baltimore vs LA on relative basis (i.e. relative to 1999 baseline) 
p2 <- ggplot(balt_la, aes(year,Emissions_rel, color=city)) + 
  geom_line() + geom_point() + 
  theme_classic() +
  labs(y= "tons relative to 1999 level", title = "Relative Scale: Baltimore vs LA Motor Vehicle Emissions by Year") + 
  scale_x_continuous(breaks = seq(1999,2008,3)) +
  scale_color_brewer(type = "qual",palette=6) 

# arnage plots in 2 x 1 grid
gA <- ggplotGrob(p1)
gB <- ggplotGrob(p2)
grid::grid.newpage()
grid::grid.draw(rbind(gA, gB))

# turn off graphical device
dev.off()
