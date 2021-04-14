
library(shiny)
library(fungible)
library(ggplot2)
library(ggpubr)

shinyServer(function(input, output) {
df <- reactive({
    round(runif(3, min = 30, max =  40))
    mm <- monte(nvar = as.numeric(input$variables),
                nclus = as.numeric(input$clustersReal), 
                clus.size = round(runif(as.numeric(input$clustersReal), 
                                        min = as.numeric(input$clustersSize[1]), 
                                        max =  as.numeric(input$clustersSize[2]))), 
                eta2 = c(runif(as.numeric(input$variables)))
                )
    df <- mm$data
    
})

output$PlotSimulated <- renderPlot({
    df <- df()
    data_pca <- prcomp(df[,-1])
    data_pca <- data.frame(
                           Dim1 = data_pca$x[,1],
                           Dim2 = data_pca$x[,2],
                           clusters = factor(df[,1])
                           )


    # Plot and color by groups
    p1 <- ggscatter(data_pca, x = "Dim1", y = "Dim2", 
              color = "clusters",
              size = 1, 
              ellipse = TRUE,
              ellipse.type = "convex",
              repel = TRUE)+
        ggtitle(label = 'Simulated Clusters')
    
    km <- kmeans(df[, -1], centers = as.numeric(input$clustersFit), iter.max = 500)
    data_pca <- prcomp(df[,-1])
    data_pca <- data.frame(
        Dim1 = data_pca$x[,1],
        Dim2 = data_pca$x[,2],
        clusters = factor(km$cluster)
    )
    
    
    # Plot and color by groups
    p2 <- ggscatter(data_pca, x = "Dim1", y = "Dim2", 
              color = "clusters",
              size = 1, 
              ellipse = TRUE,
              ellipse.type = "convex",
              repel = TRUE)+
        ggtitle(label = 'Fitted Clusters to the Simulated Data')
    ggarrange(p1, p2)
})

output$PlotFitted <- renderPlot({
    
})
    })


