library(shiny)
data(mtcars)
library(ggplot2)

variables <- c("Miles/(US) gallon",
				"Number of cylinders",
				"Displacement (cu.in.)",
				"Gross horsepower",
				"Rear axle ratio",
				"Weight (lb/1000)",
				"1/4 mile time",
				"V engine/Straight engine",
				"Transmission (0-Automatic 1-Manual)",
				"Number of forward gears",
				"Number of carburettors");
names(variables) <- c("mpg","cyl","disp","hp","drat","wt","qsec","vs","am","gear","carb");

# create factors with value labels 
mtcars$gear <- factor(mtcars$gear,levels=c(3,4,5), labels=c("3gears","4gears","5gears"))
mtcars$am <- factor(mtcars$am,levels=c(0,1), labels=c("Automatic","Manual"))
mtcars$cyl <- factor(mtcars$cyl,levels=c(4,6,8), labels=c("4cyl","6cyl","8cyl"))
mtcars$vs <- factor(mtcars$vs,levels=c(0,1), labels=c("V engine","Straight engine"))

shinyServer(
  function(input, output) {    
	output$distPlot <- renderPlot({
	    if (input$colour != "N/A" & input$size != "N/A")
			q <- qplot(get(input$xVar), get(input$yVar),
				data = mtcars,
				xlab=variables[input$xVar],
				ylab=variables[input$yVar],
				colour=get(input$colour),
				size=get(input$size), method="lm", geom=c("point", "smooth"));
		
		if (input$colour != "N/A" & input$size == "N/A")
			q <- qplot(get(input$xVar), get(input$yVar),
			    data = mtcars,
				xlab=variables[input$xVar],
				ylab=variables[input$yVar],
				colour=get(input$colour), method="lm", geom=c("point", "smooth"));
		
		if (input$colour == "N/A" & input$size != "N/A")
			q <- qplot(get(input$xVar), get(input$yVar),
				data = mtcars,
				xlab=variables[input$xVar],
				ylab=variables[input$yVar],
				size=get(input$size), method="lm", geom=c("point", "smooth"));
		
		if (input$colour == "N/A" & input$size == "N/A")
			q <- qplot(get(input$xVar), get(input$yVar),
				data = mtcars,
				xlab=variables[input$xVar],
				ylab=variables[input$yVar],
				method="lm", geom=c("point", "smooth"));

		q;
    });
	
	output$correlation <- renderText({
	    paste("Correlation: ", cor(get("mtcars")[input$xVar], get("mtcars")[input$yVar]), sep="");
	});
  }
)