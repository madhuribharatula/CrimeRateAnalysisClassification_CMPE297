library(shiny)
library(shinydashboard)

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
      menuItem("charts", tabName = "charts", icon = icon("bar-chart-o")))
  ),
  dashboardBody(
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
    )
  ),

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
    )
  )
  )
)

server <- function(input, output) { }

shinyApp(ui, server)