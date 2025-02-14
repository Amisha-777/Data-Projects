# London Bike-Sharing Data Analysis Dashboard
(DASHBOARD LINK: Tableau Public) [https://public.tableau.com/app/profile/amisha.shrestha1688/viz/BikeRides-MovingAverageandHeatmap_17395023015910/Dashboard1]

## 1. Project Overview
This project is an end-to-end data analytics workflow that analyzes the London bike-sharing dataset using Python and Tableau. It focuses on dynamic visualizations, user-interactive dashboards, and automation techniques for efficient data processing.

## 2. Dataset
- **Source:** Kaggle - London Bike-Sharing Dataset
- **Description:** The dataset contains bike ride counts along with weather conditions such as temperature, wind speed, and other environmental factors.
- **Usage:** Used for analyzing trends, identifying patterns, and visualizing factors affecting bike usage.

## 3. Project Structure

### a. Python
- **Data Collection:** Automates dataset retrieval from Kaggle.
- **Data Cleaning:** Uses Pandas for missing values handling and transformation.
- **Data Analysis:** Prepares data for visualization and extracts key insights.
- **Export:** Saves processed data as a CSV file for Tableau integration.

### b. Tableau
- **Dashboard Creation:** Builds interactive visualizations to explore bike usage trends.
- **User-Defined Parameters:** Allows dynamic filtering for enhanced data exploration.

## 4. Details of Visualization

### 1. **Total Number of Bike Rides (Top Left)**
   - Displays the overall bike usage count.
   
### 2. **Moving Average Chart (Main Visual, Center)**
   - Shows bike ride trends over time.
   - Supports **set actions** to filter and control the entire dashboard.
   - Allows **user-defined parameters** for different moving averages (e.g., 30-day, 30-week, 3-week).
   
### 3. **Temperature vs. Wind Speed Heatmap (Bottom Section)**
   - Visualizes the impact of temperature and wind speed on bike usage.
   
### 4. **Tooltip Visualizations (2 Additional Charts in Tooltips)**
   - Hovering over the **moving average chart** reveals bike rides split by **weather condition** and **hour of the day**.
   - The same tooltip feature applies to the **heatmap**.
   
### 5. **Timeline Filter (Top Right)**
   - Enables users to **shorten or extend the displayed time range** for analysis.
   
## 5. Key Techniques Used
- **Data Collection Automation:** Python script to fetch data from Kaggle.
- **Data Cleaning & Transformation:** Pandas for handling missing values and formatting.
- **Interactive Dashboards:** Set actions and user-defined parameters in Tableau.
- **Advanced Visualizations:** Heatmaps, moving averages, and dynamic tooltips.
- **Time-Series Analysis:** Identifies long-term bike-sharing trends.

## 6. Usefulness of This Dashboard
- **Urban Planning:** Helps city planners optimize bike-sharing infrastructure.
- **Business Decision-Making:** Provides insights for improving bike rental services.
- **Weather Impact Analysis:** Assists in understanding seasonal and environmental factors affecting bike usage.
- **User Engagement:** Enables stakeholders to interact with data dynamically, making informed decisions.

