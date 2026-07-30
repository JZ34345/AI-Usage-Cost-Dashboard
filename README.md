# AI-Usage-Cost-Analysis-Dashboard

## Description
### Core Functions
  This project is a dashboard that tracks AI usage costs and displays this **data in a line graph or table.**
  
  Comparisons of AI usage costs can be split into 5 views: **Overview (total and basic week-over-week delta comparisons), Aggregation (category comparisons), DrillDown (drilldown comparisons), WoW (aggregated week-over-week delta comparisons), and Forecast (cost predictions for 30 days).** 
  
  Secondary functions include **CSV data export, anomaly detection, and forecast predictions using linear regression.**

#### Note: The data provided is a sample of AI usage records covering 90 days of queries across categories (cluster, node, query type) and global regions.

## Installation and Run Instructions
#### Note: Have Xcode installed on macOS or a similar platform to run the dashboard.
1. Clone the repository using 'git clone https://github.com' and 'cd REPOSITORY-NAME' in the terminal
2. Open the project in Xcode using 'open PROJECT-NAME.xcodeproj' in the terminal
3. Ensure that sample-data.json, or other data files, is correctly in the Source Data folder
4. Select the device to run the project
5. Run the project using ▶ button (top left) or Cmd + R

## Project Features 
- Data represented as a line graph or table format
- Cost displayed as either total or average cost 
- Date filtering over 7, 30, 90, or custom day ranges
- Category data aggregation (clusters, nodes, query types)
- Drilldown data comparison (clusters -> nodes -> query types)
- Anomaly day detection with modifiable threshold (default: above 2 standard deviations)
- Linear regression forecast with prediction band (limited depending on data provided)
- CSV file export

## Project Limitations
- Forecast view is incomplete as the linear regression graph displays the y-axis mean instead of standard units due to the low R^Squared and has high volatility based on the data provided.
- The center filters in the dashboard may shift slightly as spacing is not absolutely perfect.
- The local legend may sometimes shift between colors and shapes when anomaly thresholds change.

## Images
![Overview](<img width="1408" height="881" alt="Overview" src="https://github.com/user-attachments/assets/78668f45-5782-4490-9923-3ba26571b11d" />)
  - *The Overview page provides a visualization of total cost and of basic week-over-week delta.*

![Aggregation](<img width="1408" height="881" alt="Cluster Aggregation" src="https://github.com/user-attachments/assets/52c85039-5157-43ef-97c3-bd1ac623cdec" />)
  - *This is an aggregation view comparing cost across clusters.*
    

![Drilldown](<img width="1408" height="881" alt="eu-small-01 node drilldown" src="https://github.com/user-attachments/assets/75fccc59-d691-4116-a436-d935daa602d5" />)
  - *This is a drilldown view comparing query types in the eu-small-01 node.*

![WoW delta](<img width="1408" height="881" alt="Query WoW Average" src="https://github.com/user-attachments/assets/38617e53-3da8-4cbf-9a89-0e788ee10a4c" />)
  - *This is a week-over-week view comparing average deltas across query types.*

![Forecast](<img width="1408" height="881" alt="Forecast" src="https://github.com/user-attachments/assets/57609c07-b66b-4249-9c2c-1db9e0c53d3d" />)
  - *Forecast view gives cost prediction over the next 30 days using linear prediction. The value for this is the mean total cost due to various constraints.*

## Requirements
- macOS 15.0 (Sequoia)+
- Swift 5.9+
- Xcode 15+

## License
MIT License

## Glossary
aggregation: The process of collecting data or information and combining it into a single summarized form.

anomaly: Something that is different from what is considered normal or standard.

drilldown: A way to analyze data by navigating from broad summaries to finer, more nuanced information within the broader data.

cluster: An interconnected group of individual nodes that process data at high speeds to run AI queries.

node: A computer or server with CPU or GPU processors that processes data for AI. Multiple nodes often make up an AI cluster.

prediction band: An area around the linear regression line that indicates possible areas where predictions may appear.

standard deviation: The measurement of how far something is spread out from the average.

linear regression: A method for modeling the relationship between two items or concepts by fitting a straight line to collected data. 

query type: A term that refers to what type of information a person is asking AI for an answer to.

threshold: A value that determines what constitutes an anomaly.

week-over-week-delta: A metric that calculates the change in usage cost between the current and previous week. 
