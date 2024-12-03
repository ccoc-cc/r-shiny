library(shiny)
library(ggplot2)
library(pheatmap)
library(reshape2)

function(input, output) {
    dataInput <- reactive({
        req(input$expressionData)
        read.csv(input$expressionData$datapath, header = TRUE, row.names = 1)
    })
    
    groupInput <- reactive({
        req(input$groupData)
        read.csv(input$groupData$datapath, header = TRUE, row.names = 1)
    })
    
    output$plot <- renderPlot({
        req(dataInput(), groupInput())
        data <- dataInput()
        group <- groupInput()
        
        if (input$analysisType == "PCA") {
            pca <- prcomp(t(data), scale. = TRUE)
            pcX <- as.numeric(sub("PC", "", input$pcX))
            pcY <- as.numeric(sub("PC", "", input$pcY))
            scores <- data.frame(pca$x)
            scores$group <- group$group
            ggplot(scores, aes_string(x = paste0("PC", pcX), y = paste0("PC", pcY), color = "group")) +
                geom_point() +
                theme_minimal()
            
        } else if (input$analysisType == "相关性") {
            corMatrix <- cor(data, method = input$corMethod)
            meltedCorMatrix <- melt(corMatrix)
            ggplot(meltedCorMatrix, aes(Var1, Var2, fill = value)) +
                geom_tile() +
                scale_fill_gradient2(low = "blue", high = "red", mid = "white", midpoint = 0) +
                theme_minimal()
            
        } else if (input$analysisType == "热图") {
            pheatmap(data, cluster_rows = input$clustering, cluster_cols = input$clustering)
        }
    })
    
    output$downloadPlot <- downloadHandler(
        filename = function() {
            paste("plot-", Sys.Date(), ".png", sep="")
        },
        content = function(file) {
            png(file)
            print(output$plot())
            dev.off()
        }
    )
}
