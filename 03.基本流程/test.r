# 加载必须的包
library(shiny)
library(ggplot2)

plotplot <- function(x1, x2) {
  df <- data.frame(    x = x1,    y = x2  )
  ggplot(df, aes(x, y)) +    geom_point()
}

t_test <- function(x1, x2) {
  test <- t.test(x1, x2)
  
  sprintf(    "p value: %0.3f\n[%0.2f, %0.2f]",    test$p.value, test$conf.int[1], test$conf.int[2]  )
}

# 定义UI界面
ui <- fluidPage(
  titlePanel("比较两个数据集"),
  
  sidebarLayout(
    sidebarPanel(
      fileInput("file1", "选择第一个TXT文件", accept = ".txt"),
      fileInput("file2", "选择第二个TXT文件", accept = ".txt"),
      actionButton("compare", "比较")
    ),
    
    mainPanel(
      textOutput("path"),
      tableOutput("df1"),
      plotOutput("freqPolyPlot"),  # 修复了注释掉的输出
      verbatimTextOutput("tTestResult")
    )
  )
)

# 定义服务器逻辑
server <- function(input, output) {
  observeEvent(input$compare, {  # 响应按钮点击事件
    
    req(input$file1, input$file2)  # 确保文件已经上传
    
    # 读取数据
    x1 <- read.table(input$file1$datapath,header = T)[,2]  # 修复了`%>% head()`的问题，确保读取完整数据
    x2 <- read.table(input$file2$datapath,header = T)[,3]
    
    output$path <- renderText(input$file1$datapath) # # 显示文件路径
    output$df1 <- renderTable(head(data.frame(x1, x2)))     # 显示前几行数据
    output$freqPolyPlot <- renderPlot({ plotplot(x1, x2) })     # 绘制频率多边形
    output$tTestResult <- renderText({ t_test(x1, x2) })    # 输出t检验结果
  })
}

# 运行应用程序
shinyApp(ui = ui, server = server)

