library(shiny)
library(shinydashboard)
library(dplyr)
library(reshape2)
library(ggplot2)
library(readr)
library(lubridate)

ui <- dashboardPage(

  dashboardHeader(titleWidth = 450,title="SF Crime Classification"),
  dashboardSidebar(
  tags$head(tags$style(HTML('
   .skin-blue .main-sidebar {
                               background-color: #cc6699;
                               }
                               .skin-blue .sidebar-menu>li.active>a, .skin-blue .sidebar-menu>li:hover>a {
                                                  background-color: #862d59;
                                                  }'))),
      sidebarMenu(
      menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
      menuItem("Table", tabName = "tables", icon = icon("th")),
      menuItem("charts", tabName = "charts", icon = icon("bar-chart-o"),
             menuSubItem('crimes_by_day', tabName = 'crimes_by_day'),
             menuSubItem('crimes_by_district', tabName = 'crimes_by_district'),
              menuSubItem('crimes_by_year', tabName = 'crimes_by_year')))
  ),
  dashboardBody(
  	tabItems(
      tabItem(tabName = "dashboard",
fluidRow(
    box(title = "Box title", "Box content"),
    box(status = "warning", "Box content")
  ),
fluidRow(
    box(
      title = "Title 1", width = 4, solidHeader = TRUE, status = "primary",
      "Box content"
    ),
    box(
      title = "Title 2", width = 4, solidHeader = TRUE,
      "Box content"
    ),
    box(
      title = "Title 1", width = 4, solidHeader = TRUE, status = "warning",
      "Box content"
    )),
  fluidRow(
    box(
      width = 4, background = "black",
      "A box with a solid black background"
    ),
    box(
      title = "Title 5", width = 4, background = "light-blue",
      "A box with a solid light-blue background"
    ),
    box(
      title = "Title 6",width = 4, background = "maroon",
      "A box with a solid maroon background"
    ))),
tabItem(tabName = "tables"),
    tabItem('crimes_by_day',fluidRow(plotOutput("plot1",height=600,width=1090))),
    tabItem('crimes_by_district',fluidRow(plotOutput("plot2",height=600,width=1090))),
    tabItem('crimes_by_year',fluidRow(plotOutput("plot3",height=600,width=1090)))
  ))
  )

server <- function(input, output) {
output$plot1 <- renderPlot({
	data <- read_csv("C:/Users/Shilpa/Desktop/train.csv")

# Build a contingency table of all combinations of crime categories and days of the week
crimes_by_day <- table(data$Category,data$DayOfWeek)

# Reshape the table, so I can plot it later
crimes_by_day <- melt(crimes_by_day)
names(crimes_by_day) <- c("Category","DayOfWeek","Count")

# Make bar plots
g <- ggplot(crimes_by_day,aes(x=Category, y=Count,fill = Category)) + 
  geom_bar(stat = "Identity") + 
  coord_flip() +
  facet_grid(.~DayOfWeek) +
  theme(legend.position = "none")
g})
output$plot2 <- renderPlot({
	data <- read_csv("C:/Users/Shilpa/Desktop/train.csv")
crimes_by_district <- table(data$Category,data$PdDistrict)

crimes_by_district <- melt(crimes_by_district)
names(crimes_by_district) <- c("Category","PdDistrict","Count")

g <- ggplot(crimes_by_district,aes(x=Category, y=Count,fill = Category)) + 
  geom_bar(stat = "Identity") + 
  coord_flip() +
  facet_grid(.~PdDistrict) +
  theme(legend.position = "none")

g})
output$plot3 <- renderPlot({
	data <- read_csv("C:/Users/Shilpa/Desktop/train.csv")
data$Year <- year(ymd_hms(data$Dates))

crimes_by_year <- table(data$Category,data$Year)

crimes_by_year <- melt(crimes_by_year)
names(crimes_by_year) <- c("Category","Year","Count")

g <- ggplot(crimes_by_year,aes(x=Category, y=Count,fill = Category)) + 
  geom_bar(stat = "Identity") + 
  coord_flip() +
  facet_grid(.~Year) +
  theme(legend.position = "none")


g}) }

shinyApp(ui, server)
