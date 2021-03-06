#install.packages(c("shiny", "shinydashboard", "tidyverse", "dplyr", "ggplot2", "stringr", "caret", "DT", "plotly", "tree", "rattle", "randomForest" ))

library(shiny)
library(shinydashboard)
library(tidyverse)
library(dplyr)
library(ggplot2)
library(stringr)
library(caret)
library(DT)
library(plotly)

#Load data
waterPotabilityFullData<- read.csv("./data/water_potability.csv")


# Define UI for application that draws a histogram
shinyUI(
  dashboardPage(
    dashboardHeader(title = "Water Quality"),
    dashboardSidebar(
      sidebarMenu(
        menuItem("About", tabName = "about", icon = icon("clipboard")),
        menuItem("Data", tabName = "data", icon = icon("database")),
        menuItem("Data Exploration", tabName = "dataexp", icon = icon("search",lib = "glyphicon")),
        menuItem("Modeling", tabName = "modeling", icon = icon("signal",lib = "glyphicon"))               
      )),
    
    #Data Exploration page
    dashboardBody(
      tabItems(
        tabItem(tabName = "dataexp",
                fluidRow( h2("3. Data Exploration"),br(), br(),
                          
                )),
        
        #Modeling Page
        
        tabItem(tabName = "modeling",
                fluidRow( h2("4. Modeling"), br(),
                )),
        
        #Dataset page
        
        tabItem(tabName = "data",
                fluidRow( h2("2. Dataset"), br(), br(),
                          
                )),
        
        
        
        # About page            
        tabItem(tabName = "about",
                h2("About"),
                img(src = "./image/waterQuality.png", width = "100px", height = "100px"),
                h3("Purpose of the App"),
                h4("Our goal here will be to fit the model and predict the quality of the water and measure the statistics, how accurately can it be predicted. We will be using  the Random Forest model, Classical Regression Tree and
                         Multiple Linear model to fit the model and predict the water quality. Then choose the best one."),
                br(),
                br(),   
                
                h3("Navigate Through the App: This app will have 4 different components"),
                h3("1. About"), 
                h4("This page describes purpose of the app, purpose of each tab (page) of the app and information about the data"),
                
                h3("2. Data"),
                h4("In this page user can scroll through the data, subset it and save the data as a '.csv' file."),
                
                h3("3. Data Exploration"),
                h4("In this page displays numerical and graphical summaries. User can download plot, change type of plot and type of summary reported, change the variable and filter the rows to change the data in the plots/summaries"),
                
                
                h3("4. Modeling"),
                h4("This page will display three supervised learning models - multiple linear regression or generalized linear regression model, regression or classification tree, and a random forest model.This page contains three tabs :"),
                em(h4(strong("I. Modeling Info tab :"))),
                h4("This tab displays three modeling approaches, the benefits of each, and the drawbacks of each."),
                
                em(h4(strong("II. Model Fitting tab :"))),
                h4("User can split the data and choose the proportion of data used in each training and testing data set. User can choose model settings for each model. The models get compared on the test set and appropriate fit statistics reported."),
                em(h4(strong("III. Prediction tab :"))),
                h4("User can choose one of the models for prediction. User can select the values of the predictors and obtain a prediction for the response."),
                br(),
                br(),
                
                
                
                h2("Data Set Information"),
                h4("This data set is donloaded from ", 
                   a(href= "https://www.kaggle.com/adityakadiwal/water-potability", "kaggle"),
                   "Access to safe drinking-water is essential to health, a basic human right and a component of effective policy for health protection. This is important as a health and development issue at a national, regional and local level. In some regions, it has been shown that investments in water supply and sanitation can yield a net economic benefit, since the reductions in adverse health effects and health care costs outweigh the costs of undertaking the interventions.
						   This dataset describes if water is safe to consume as a drinking water based on water-potability."),
               br(),
               
               h3("Attribute Information"),
               h4("The water_potability.csv file contains water quality metrics for 3276 different water bodies."),
               br(),
        
               h4("1 - pH value", "- PH is an important parameter in evaluating the acid–base balance of water. It is also the indicator of acidic or alkaline condition of water status. WHO has recommended maximum permissible limit of pH from 6.5 to 8.5. The current investigation ranges were 6.52–6.83 which are in the range of WHO standards.", br(), br(), 
                  "2 - Hardness", "- Hardness is mainly caused by calcium and magnesium salts. These salts are dissolved from geologic deposits through which water travels. The length of time water is in contact with hardness producing material helps determine how much hardness there is in raw water. Hardness was originally defined as the capacity of water to precipitate soap caused by Calcium and Magnesium.", br(),br(), 
                  "3 - Solids (Total dissolved solids - TDS)", "- Water has the ability to dissolve a wide range of inorganic and some organic minerals or salts such as potassium, calcium, sodium, bicarbonates, chlorides, magnesium, sulfates etc. These minerals produced un-wanted taste and diluted color in appearance of water. This is the important parameter for the use of water. The water with high TDS value indicates that water is highly mineralized. Desirable limit for TDS is 500 mg/l and maximum limit is 1000 mg/l which prescribed for drinking purpose.", br(), br(),
                  "4 - Chloramines", "- Chlorine and chloramine are the major disinfectants used in public water systems. Chloramines are most commonly formed when ammonia is added to chlorine to treat drinking water. Chlorine levels up to 4 milligrams per liter (mg/L or 4 parts per million (ppm)) are considered safe in drinking water.", br(), br(),
                  "5 - Sulfate","- Sulfates are naturally occurring substances that are found in minerals, soil, and rocks. They are present in ambient air, groundwater, plants, and food. The principal commercial use of sulfate is in the chemical industry. Sulfate concentration in seawater is about 2,700 milligrams per liter (mg/L). It ranges from 3 to 30 mg/L in most freshwater supplies, although much higher concentrations (1000 mg/L) are found in some geographic locations.", br(),br(), 
                  "6 - Conductivity","- Pure water is not a good conductor of electric current rather’s a good insulator. Increase in ions concentration enhances the electrical conductivity of water. Generally, the amount of dissolved solids in water determines the electrical conductivity. Electrical conductivity (EC) actually measures the ionic process of a solution that enables it to transmit current. According to WHO standards, EC value should not exceeded 400 μS/cm.", br(), br(),
                  "7 - Organic_carbon", "- Total Organic Carbon (TOC) in source waters comes from decaying natural organic matter (NOM) as well as synthetic sources. TOC is a measure of the total amount of carbon in organic compounds in pure water. According to US EPA < 2 mg/L as TOC in treated / drinking water, and < 4 mg/Lit in source water which is use for treatment.", br(),br(),
                  "8 - Trihalomethanes", "- THMs are chemicals which may be found in water treated with chlorine. The concentration of THMs in drinking water varies according to the level of organic material in the water, the amount of chlorine required to treat the water, and the temperature of the water that is being treated. THM levels up to 80 ppm is considered safe in drinking water.", br(), br(),
                  "9 - Turbidity", "- The turbidity of water depends on the quantity of solid matter present in the suspended state. It is a measure of light emitting properties of water and the test is used to indicate the quality of waste discharge with respect to colloidal matter. The mean turbidity value obtained for Wondo Genet Campus (0.98 NTU) is lower than the WHO recommended value of 5.00 NTU.", br(), br(),
                  "10 - Potability", "- Indicates if water is safe for human consumption where 1 means Potable and 0 means Not potable."),                                                         
                  br(), br(), br(),
        
        br(),
                )
        

    )
  )
)
)
