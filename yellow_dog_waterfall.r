#Load necessary libraries
library(dplyr)
library(ggplot2)
library(stringr)
library(shiny)

#Set working directory
setwd("./FreshStartInitiative")

#Read in data
data <- read.csv("FreshStartInitiative.csv")

#Data Preparation and Cleaning
#Rename columns
colnames(data) <- c("uni_id", 
                    "firstname", 
                    "lastname", 
                    "age", 
                    "gender",
                    "state",
                    "course_taken")
#Create a categorical variable for gender
data$gender_cat <- factor(data$gender, 
                          levels = c("M","F"), 
                          labels = c("Male","Female"))

#Filter out students based on age
data_filter <- filter(data, age<= 18)

#Create dataframe for students from the same city
total_by_state <- group_by(data_filter, state)
densities_by_state <- summarise(total_by_state, 
                               total_students = n())

#Data Visualization
#Plot number of students in each state
ggplot(densities_by_state,
       aes(x = state, y = total_students))+
  geom_bar(stat = "identity", fill = "darkgreen")+
  labs(title = "Number of Students in Each State", 
       x = "State", y = "Number of Students")

#Create dataframe for students taking same course
total_by_course <- group_by(data_filter, course_taken)
densities_by_course <- summarise(total_by_course, 
                                total_students_taken = n())

#Plot number of students taking same course
ggplot(densities_by_course,
       aes(x = course_taken, y = total_students_taken))+
  geom_bar(stat = "identity", fill = "darkblue")+
  labs(title = "Number of Students Taking Same Course", 
       x = "Course", y = "Number of Students")

#Create dataframe for gender ratio
total_by_gender <- group_by(data_filter, gender_cat)
densities_by_gender <- summarise(total_by_gender, 
                                total_gender = n())

#Plot gender ratio
ggplot(densities_by_gender,
       aes(x = gender_cat, y = total_gender))+
  geom_bar(stat = "identity", fill = c("red", "pink"))+
  labs(title = "Gender Ratio of Students", 
       x = "Gender", y = "Number of Students")

#Design Dashboard
#UI
ui <- fluidPage(
  titlePanel("The Fresh Start Initiative"),
  
  sidebarLayout(
  
    sidebarPanel(
      radioButtons("ageRange", 
                   label = "Select Age Range:",
                   choices = list("14-18" = "14_18",
                                  "18-21" = "18_21",
                                  "21-25" = "21_25"),
                   selected = "14_18"),
      selectInput("state", 
                  label = "Select State:",
                  choices = levels(data_filter$state)),
      selectInput("courseTaken", 
                  label = "Select Course:",
                  choices = levels(data_filter$course_taken))
    ),
    
    mainPanel(
      tabsetPanel(
        
        tabPanel("Number of Students in Each State", 
                 plotOutput("plot1")),
                 
        tabPanel("Number of Students Taking Same Course", 
                 plotOutput("plot2")),
        
        tabPanel("Gender Ratio of Students", 
                 plotOutput("plot3"))
      )
    )
  )
)

#Server
server <- function(input, output, session){
  
  #Filter data according to age range
  filteredData <- reactive({
    if (input$ageRange == "14_18"){
      data_filter
    }
  })
  
  #Filter data according to state
  filterState <- reactive({
    if (input$state != "All"){
      filter(filteredData(), state == input$state)
    }
    else{
      filteredData()
    }
  })
  
  #Filter data according to course
  filterCourse <- reactive({
    if (input$courseTaken != "All"){
            filter(filterState(), course_taken == input$courseTaken)
    }
    else{
      filterState()
    }
  })
  
  #Create plots
  output$plot1 <- renderPlot({
    total_by_state <- group_by(filterCourse(), state)
    densities_by_state <- summarise(total_by_state, 
                                   total_students = n())
    ggplot(densities_by_state,
           aes(x = state, y = total_students))+
      geom_bar(stat = "identity", fill = "darkgreen")+
      labs(title = "Number of Students in Each State", 
           x = "State", y = "Number of Students")
  })
  
  output$plot2 <- renderPlot({
    total_by_course <- group_by(filterCourse(), course_taken)
    densities_by_course <- summarise(total_by_course, 
                                    total_students_taken = n())
    ggplot(densities_by_course,
           aes(x = course_taken, y = total_students_taken))+
      geom_bar(stat = "identity", fill = "darkblue")+
      labs(title = "Number of Students Taking Same Course", 
           x = "Course", y = "Number of Students")
  })
  
  output$plot3 <- renderPlot({
    total_by_gender <- group_by(filterCourse(), gender_cat)
    densities_by_gender <- summarise(total_by_gender, 
                                    total_gender = n())
    ggplot(densities_by_gender,
           aes(x = gender_cat, y = total_gender))+
      geom_bar(stat = "identity", fill = c("red", "pink"))+
      labs(title = "Gender Ratio of Students", 
           x = "Gender", y = "Number of Students")
  })
}

#Create dashboard
shinyApp(ui, server)