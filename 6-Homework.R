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
nrow(myMovies)
head(myMovies)
tail(myMovies)
str(myMovies)

#need ggplot2 for plotting
#and extrafont (to use windows Comic Sans MS)
library(ggplot2)
library(extrafont)
loadfonts(device = "win")


myplot=ggplot(data=myMovies,aes(x=Genre,
                                y=Gross...US,
                                size=Budget...mill.)) +
  geom_jitter(aes(color=Studio))+
  geom_boxplot(size=1.2,alpha=0.5)+
  ylab("Gross % US")+
  ggtitle("Domestic Gross % by Genre")+
  theme(axis.title.x = element_text(color="Blue",size=30),
        axis.title.y = element_text(color="Blue",size=30),
        axis.text.x = element_text(size=20),
        axis.text.y = element_text(size=20),
        
        legend.title = element_text(size = 10),
        legend.text = element_text(size = 8),
        #legend.position = c(1,1),
        #legend.justification = c(1,1),
        
        plot.title = element_text(size=30,hjust=0.5),
        text=element_text(family="Comic Sans MS"))
myplot$labels$size="Budget $M"
myplot
