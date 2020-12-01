## Data Overview 

Approximately every three years, the Environmental Protection Agency (EPA) releases a database on emission levels of fine particulate matter (PM2.5) in the United States.  The database is known as the National Emissions Inventory (NEI)&mdash; refer to this [link](http://www.epa.gov/ttn/chief/eiinformation.html) for details.   

The data set used in this analysis contains historical PM2.5 emissions data from the following years: 1999, 2002, 2005, and 2008.

Two data files were download [here](
https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip):  
  
  * `summarySCC_PM25.rds` - this file contains emissions by year, U.S.county, source of emission, and type of emission.
  * `Source_Classification_Code.rds` - this is a mapping table that provides both broad and specific details about the source classification code listed in the emissions data file.
     
## Dictionary
Below are field definitions for the main data table, `summarySCC_PM25.rds`:  
    
* **fips** (string) - five digit number representing U.S. county
* **SCC** (string) - eight or ten digit code indicating emission source.  
* **Pollutant** (string) - indicates the pollutant (all "PM25-PRI" in this data frame) 
* **Emissions** (double) - PM2.5 emissions, in tons
* **type** (string) - type of source (point, non-point, on-road, non-road).  
* **year** (integer) - year emissions were recorded



## Analysis

### Initial Data Processing

The `download_files.R` script downloads and unzips the two data files into the current working directory.
 
### Plots  

1. Using base R graphics, this plot shows that the total trend in emissions in the U.S. is decreasing over time.  Relevant files are `plot1.R` and `plot1.png`.
2. Using base R graphics, this plot indicates an overall decreasing trend of emissions in Baltimore City, MD; however, the trend is not consistent across all time periods.  Relevant files are `plot2.R` and `plot2.png`.
3.  Using the ggplot2 plotting library, this plot depicts the trend in Emissions within Baltimore, MD over time and for four different emission types.  With the exception of the "POINT" type, each emission type shows a flat or decreasing trend in each successive time period.  Refer to files `plot3.R` and `plot3.png`.
4. Using ggplot2, plot four indicates that emissions due to coal were decreasing or relatively flat over successive time periods&mdash;see `plot4.R` and `plot4.png`.
5. Created using the ggplot2 library, plot five shows motor vehicle emissions in Baltimore City, MD have consistently decreased over time.  Note: motor vehicle-related emissions were identify by SCC codes with a corresponding Short.Name field containing the term "veh"&mdash;short for "vehicle".  Relevant files are `plot5.R` and `plot5.png`.  
6. Plot six was generated using ggplot2, and depicts a small net increase in motor vehicle emissions in LA over the nine year period.  Baltimore, on the other hand, experienced consistent decreases in vehicle emissions throughout the nine year period. 
Los Angeles exhibited much larger swings in emissions (both positive and negative) throughout the period.  When viewed on a relative basis, however, Baltimore's history depicts more pronounced changes, with Baltimore's 2008 emissions down roughly 75% from levels recorded in 1999.  For details, refer to `plot6.r` and `plot6.png`.      

 
 
