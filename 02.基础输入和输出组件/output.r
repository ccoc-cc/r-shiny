library(shiny)
# library(DT)

ui <- fluidPage(
  textOutput("text"), 
  verbatimTextOutput("code"),
  
  tableOutput("static"),
  dataTableOutput("dynamic"),
  # DTOutput("dynamicDt"),  # 将输出标签名称改为更具描述性
  
  plotOutput("plot", width = "400px")
  
  # 还可以设置下载，不过这是高级功能，后面介绍
  # https://mastering-shiny.org/action-transfer.html#download
)

server <- function(input, output, session) {
  output$text <- renderText("这是文本输出")  # 渲染文本输出
  output$code <- renderPrint(summary(1:10))  # 渲染代码输出
  
  output$static <- renderTable(head(mtcars))  # 渲染静态表格
  output$dynamic <- renderDataTable(mtcars, options = list(pageLength = 5))  # 渲染动态数据表，带有分页选项
  #　output$dynamicDt <- renderDT(datatable(mtcars, options = list(pageLength = 5, dom = 't', ordering = FALSE)))  # 修改函数名为 renderDT
  
  output$plot <- renderPlot(plot(1:5), res = 96)  # 渲染基本的绘图输出
}

shinyApp(ui = ui, server = server)
