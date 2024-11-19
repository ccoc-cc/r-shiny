# 相当于这一段： tmp <- 1:3; names(tmp) <-  c("foo", "bar", "baz")
# 创建一个向量供后面的下拉选择
prod_codes <- setNames(products$prod_code, products$title)

ui <- fluidPage(
  # 创建了一个选择框
  fluidRow(
    column(6,
           selectInput("code", "Product", choices = prod_codes)
    )
  ),
  # 创建了 3 列用来展示数据
  fluidRow(
    column(4, tableOutput("diag")),
    column(4, tableOutput("body_part")),
    column(4, tableOutput("location"))
  ),
  # 输出的图片
  fluidRow(
    column(12, plotOutput("age_sex"))
  )
)

server <- function(input, output, session) {
  # reactive 响应；就是这里面的东西变化的时候就重新运行
  selected <- reactive(injuries %>% filter(prod_code == input$code))
  
  # 渲染3个表格用于输出
  output$diag <- renderTable(
    selected() %>% count(diag, wt = weight, sort = TRUE)
  )
  output$body_part <- renderTable(
    selected() %>% count(body_part, wt = weight, sort = TRUE)
  )
  output$location <- renderTable(
    selected() %>% count(location, wt = weight, sort = TRUE)
  )
  
  summary <- reactive({
    selected() %>%
      count(age, sex, wt = weight) %>%
      left_join(population, by = c("age", "sex")) %>%
      mutate(rate = n / population * 1e4)
  })
  
  output$age_sex <- renderPlot({
    summary() %>%
      ggplot(aes(age, n, colour = sex)) +
      geom_line() +
      labs(y = "Estimated number of injuries")
  }, res = 96)
}


# 运行应用程序
shinyApp(ui = ui, server = server)

