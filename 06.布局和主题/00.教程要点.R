
#----基础布局----
fluidPage( # 页面函数，提供基本的页面；也有其他的类似函数: fixedPage() and fillPage().
  titlePanel(), # 标题栏
  sidebarLayout( # 分栏
    sidebarPanel(), # 侧边栏
    mainPanel()     # 主面板
  )
)


#----多列布局----
fluidPage(
  fluidRow(
    column(4, 
           ...
    ),
    column(8, 
           ...
    )
  ),
  fluidRow(
    column(6, 
           ...
    ),
    column(6, 
           ...
    )
  )
)

#----分页布局----
ui <- fluidPage(
  tabsetPanel(
    tabPanel("Import data", 
             fileInput("file", "Data", buttonLabel = "Upload..."),
             textInput("delim", "Delimiter (leave blank to guess)", ""),
             numericInput("skip", "Rows to skip", 0, min = 0),
             numericInput("rows", "Rows to preview", 10, min = 1)
    ),
    tabPanel("Set parameters"),
    tabPanel("Visualise results")
  )
)

#----导航栏----
ui <- fluidPage(
  navlistPanel(
    id = "tabset",
    "Heading 1",
    tabPanel("panel 1", "Panel one contents"),
    "Heading 2",
    tabPanel("panel 2", "Panel two contents"),
    tabPanel("panel 3", "Panel three contents")
  )
)

#----水平导航栏----
ui <- navbarPage(
  "Page title",   
  tabPanel("panel 1", "one"),
  tabPanel("panel 2", "two"),
  tabPanel("panel 3", "three"),
  navbarMenu("subpanels", 
             tabPanel("panel 4a", "four-a"),
             tabPanel("panel 4b", "four-b"),
             tabPanel("panel 4c", "four-c")
  )
)


#----主题----
ui <- fluidPage(
  theme = bslib::bs_theme(bootswatch = "darkly"), #  darkly, flatly, sandstone, and united
  sidebarLayout(
    sidebarPanel(
      textInput("txt", "Text input:", "text here"),
      sliderInput("slider", "Slider input:", 1, 100, 30)
    ),
    mainPanel(
      h1(paste0("Theme: darkly")),
      h2("Header 2"),
      p("Some text")
    )
  )
)

##----自定义主题----
theme <- bslib::bs_theme(
  bg = "#0b3d91", 
  fg = "white", 
  base_font = "Source Sans Pro"
)

##----为ggplot设置主题
library(ggplot2)

ui <- fluidPage(
  theme = bslib::bs_theme(bootswatch = "darkly"),
  titlePanel("A themed plot"),
  plotOutput("plot"),
)

server <- function(input, output, session) {
  thematic::thematic_shiny()
  
  output$plot <- renderPlot({
    ggplot(mtcars, aes(wt, mpg)) +
      geom_point() +
      geom_smooth()
  }, res = 96)
}





