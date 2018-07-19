getwd()
setwd("c:\\Users\\tony\\Desktop\\data_science\\r_programming\\6. ADVANCED VISUALIZATION")

movies=read.csv("Section6-Homework-Data.csv")

#check the dataset
head(movies)
tail(movies)
str(movies)
nrow(movies) #608 rows of data

# Store the studios and genres that we want to look at
myStudios = c("Buena Vista Studios","Fox","Paramount Pictures","Sony","Universal","WB")
myGenres = c("action","adventure","animation","comedy","drama")

# boolean to only use the data that's in the list of studios/genres wanted 
check = (movies$Studio %in% myStudios) & (movies$Genre %in% myGenres)

#subset
myMovies=movies[which(check),]

# check that my subset plus anything not in it is the same total
nrow(movies[which(!(check)),])+nrow(myMovies) #608 rows total

#check the new dataset
nrow(myMovies)
head(myMovies)
tail(myMovies)
str(myMovies)

#need ggplot2 for plotting
#and extrafont (to use windows Comic Sans MS)
library(ggplot2)
library(extrafont)
loadfonts(device = "win")

# create plot with my data set
# US gross % on y, Genre on x, and
# size as Buget in millions
myplot=ggplot(data=myMovies,aes(x=Genre,
                                y=Gross...US,
                                size=Budget...mill.)) +
  # print random jitter colored by studio
  geom_jitter(aes(color=Studio))+
  
  # overlay an opaque boxplot on top 
  geom_boxplot(size=1.2,alpha=0.5,outlier.color=NA)+
  
  # change y axis label
  ylab("Gross % US")+
  # add the title
  ggtitle("Domestic Gross % by Genre")+
  #set
  theme(#set x and y axis text format
        axis.title.x = element_text(color="Blue",size=30),
        axis.title.y = element_text(color="Blue",size=30),
        axis.text.x = element_text(size=20),
        axis.text.y = element_text(size=20),
        
        #set legend text format
        legend.title = element_text(size = 10),
        legend.text = element_text(size = 8),
        
        #set title positioning
        plot.title = element_text(size=30,hjust=0.5),
        #set font stuff
        text=element_text(family="Comic Sans MS"))
#reset size variable for legend
myplot$labels$size="Budget $M"
#print
myplot
