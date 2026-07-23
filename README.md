# AI-Usage-Cost-Analysis-Dashboard

## Description
### Core Functions
  This project is a dashboard that tracks AI usage costs (in cents) over time and displays this data in a line graph or a table. Furthermore, for either the graph or the table, the data displayed can be total cost or the average cost. 

  The comparisons of AI usage cost can be split across total cost, aggregation of costs across categories, drilldown comparison of costs in clusters or nodes, and comparisons of week-over-week delta costs. Because of this, the dashboard can be split across 5 different views: Overview (Total and Basic WoW), Aggregation (category comparison), DrillDown (drilldown comparisons), and WoW (aggregated WoW comparisons). 

  The data provided is a sample of AI usage records covering 90 days of queries across different clusters, nodes, and query types in different global regions (US West, US East, and West Europe).

### Secondary Functions
  Secondary functions include a data export feature to CSV files, an anomaly detection feature to mark days where the cost is 2 standard deviations or more  above the average cost of the time period, and a forecast feature which uses linear regression to predict the usage cost for the next 30 days according to the data given beforehand.  

## Installation and Run Instructions

## Project Features

## License
MIT License

## Glossary
aggregation: process of collecting different pieces of data or information and combining them into a single summarized form.

anomaly: something that is different from what is considered normal or standard. 

drilldown: A way to analyze data by navigating from broad summaries of data down to finer and more nuanced specific data within the broader group of data.

cluster: An interconnected group of individual nodes that process data at high speeds to run AI queries.

node: A computer or server with CPU or GPU processors that processes data for AI. Multiple nodes often make up an AI cluster

standard deviation: The measurement of how far something is spread out from the average

linear regression: A method to model a relationship between two items or concepts by fitting them on a straight line in context with collected data. 

query type: A term that refers to what type of information a person is asking AI for an answer for. 

week-over-week-delta: A measurement that calculates the change in usage cost between the current week and the previous week. 
