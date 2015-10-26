library(shiny)
selectValues <- c("Miles/(US) gallon" = "mpg",
                  "Number of cylinders" = "cyl",
                  "Displacement (cu.in.)" = "disp",
                  "Gross horsepower" = "hp",
                  "Rear axle ratio" = "drat",
                  "Weight (lb/1000)" = "wt",
                  "1/4 mile time" = "qsec",
                  "V engine/Straight engine" = "vs",
                  "Transmission (0-Automatic 1-Manual)" = "am",
                  "Number of forward gears" = "gear",
                  "Number of carburettors" = "carb");
				  
shinyUI(fluidPage(
  titlePanel("Motor Trend Car Road Tests Dataset Analysis"),
  fluidRow(
    column(12, wellPanel(
		h3("About this simple web application"),
		p("This is a simple web application that allows users (without knowledge about R) to explore 'mtcars' dataset based on basic functionalities of qplot function of ggplot2 library."),
		p("In this web application, on the left panel, user can choose:"),
		p("- x-axis variable"),
		p("- y-axis variable"),
		p("- Colour variable"),
		p("- Size variable"),
		p("Those chances are immediately reflected on the right-hand plot."),
		p("Correlation between x & y axis variables is also calculated (if possible) and displayed below the plot.")
	  )
	)
  ),
  fluidRow(
    column(4,
      wellPanel(
        selectInput("xVar", "Select variable for X axis:", 
					selectValues,
					selected = "hp"),
		selectInput("yVar", "Select variable for Y axis:", 
					selectValues,
					selected = "mpg"),
		selectInput("colour", "Select variable for Colour:",
					c("N/A" = "N/A", selectValues)),
		selectInput("size", "Select variable for Size:", 
					c("N/A" = "N/A", selectValues))
      )       
    ),

    column(8,
      plotOutput("distPlot"),
	  verbatimTextOutput("correlation")
	  #h3(textOutput("correlation"))
    )
  )
))