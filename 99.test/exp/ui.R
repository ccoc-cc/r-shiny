fluidPage(
    titlePanel("基因表达量数据分析"),
    
    sidebarLayout(
        sidebarPanel(
            fileInput("expressionData", "上传基因表达量数据", accept = c(".csv", ".txt", ".xls")),
            fileInput("groupData", "上传分组文件", accept = c(".csv", ".txt", ".xls")),
            selectInput("analysisType", "选择分析类型", choices = c("PCA", "相关性", "热图")),
            
            conditionalPanel(
                condition = "input.analysisType == 'PCA'",
                selectInput("pcX", "选择PCX", choices = c("PC1", "PC2", "PC3"), selected = "PC1"),
                selectInput("pcY", "选择PCY", choices = c("PC1", "PC2", "PC3"), selected = "PC2")
            ),
            
            conditionalPanel(
                condition = "input.analysisType == '相关性'",
                selectInput("corMethod", "选择相关性系数", choices = c("Pearson", "Spearman", "Kendall"))
            ),
            
            conditionalPanel(
                condition = "input.analysisType == '热图'",
                checkboxInput("clustering", "是否进行聚类", value = TRUE)
            )
        ),
        
        mainPanel(
            plotOutput("plot"),
            downloadButton("downloadPlot", "下载结果文件")
        )
    )
)
