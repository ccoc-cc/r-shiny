library(shiny)
library(bslib)

# 定义UI ----
ui <- page_fluid(
  titlePanel("基础组件"),
  layout_columns(
    col_width = 3,
    
    card(card_header("按钮"),
         actionButton("drink", "图标", icon = icon("cocktail")),
         actionButton("click", "样式1", class = "btn-danger"),
         actionButton("drink2", "样式2", class = "btn-lg btn-success"),
         actionButton("action", "操作"), submitButton("提交")),
    
    card(card_header("单复选框"),
         checkboxInput("checkbox", "单复选框", value = TRUE),
         checkboxGroupInput("checkGroup", "多复选框", choices = list("选项1" = 1, "选项2" = 2, "选项3" = 3), selected = 1)),
    
    card(card_header("日期输入"),
         dateInput("date", "选择日期", value = "2014-01-01"), 
         dateRangeInput("dates", "选择日期范围")),
    
    card(card_header("帮助文本"), 
         helpText("注意：帮助文本不是一个真正的控件，", "但它提供了一种简单的方法来添加文本以", "伴随其他控件。"),
         helpText("帮助文本放哪都行。")),
    
    card(card_header("文件输入"), 
         fileInput("file", label = "选择文件") ),
    
    card(card_header("单选输入"), 
         radioButtons("radio", "单选按钮", choices = list("选项1" = 1, "选项2" = 2, "选项3" = 3), selected = 1),
         radioButtons("rb", "试试表情", choiceNames = list( icon("angry"), icon("smile"), icon("sad-tear") ), choiceValues = list("angry", "happy", "sad") )), 
    
    card(card_header("下拉输入"), 
         selectInput("select", "下拉单选", choices = list("选项1" = 1, "选项2" = 2, "选项3" = 3), selected = 1),
         selectInput("select", "下拉多选", choices = list("选项1" = 1, "选项2" = 2, "选项3" = 3), selected = 1, multiple=T),
         selectInput("groupedSelect", "选择一个选项:", choices = list(
           "水果" = list("苹果" = "apple", "香蕉" = "banana"),
           "蔬菜" = list("胡萝卜" = "carrot", "生菜" = "lettuce"),
           "饮料" = list("水" = "water", "咖啡" = "coffee")))),
    
    card(card_header("数字输入"),
         numericInput("num1", "输入数字", value = 25, min = 0, max = 100, step = 0.1)),
    
    card(card_header("滑块输入"),
         sliderInput("num2", "范围选择1", value = 50, min = 0, max = 100),
         sliderInput("num3", "范围选择2", value = c(10, 45), min = 0, max = 100),
         sliderInput( "dateSlider", "选择日期范围:", min = as.Date("2023-01-01"), max = as.Date("2023-12-31"), value = as.Date(c("2023-06-01", "2023-06-30")),        timeFormat = "%Y-%m-%d") ),
    
    card(card_header("文本输入"),
         textInput("text_shot", "短文本输入", value = "输入文本..."),
         passwordInput("passwd", "密码输入", value = "输入密码..."),
         textAreaInput("text_long", "长文本输入", value = "输入长文本...", rows = 3)
    )
  )
)

# 定义服务器逻辑 ----
server <- function(input, output) {}

# 运行应用 ----
shinyApp(ui = ui, server = server)

