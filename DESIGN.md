# DESIGN Page

## Views
#### All costs mentioned in the views below can be seen as either total usage cost for each day or an average cost per day in the graph.
Overview: displays a swappable view of either **total cost of AI usage or a basic WoW delta graph** as an entry point to the data. The two graphs in the view are simple enough to let users get started while allowing them to see a broad scope of the data.

Aggregation: displays a view of **cost split by category (Total, Model, Node, Query Lines)**. Multiple categories can be compared at once, but only up to two (to reduce visual and calculation strain in the app). Allows users to see which category is driving the increase in cost.

DrillDown: displays a **view of cost in depth from cluster to node to query type**. Allows comparison of which item in a category drives cost. 

WoW: displays cost as **week-over-week deltas comparing the current week and previous ones**. Allows for analysis of cost trends over time. 

Forecast: displays **costs as predictions using linear regression**. Allows forecasting of potential costs for the next 30 days from the latest data point. 

## TabView
The view type can be switched using the TabView object at the very front, displaying all possible view types in one place. View switching occurs by pressing on the view users wish to select. 

## Summaries
### Chart Summaries
 - Series of summary statistics below the filter. Consists of highlights such as the most dominant category, highest cost, daily average, or other relevant information.
   - Items marked in red indicate a high cost, while items in green are a low or negative cost.

### Anomaly Detection
#### Anomaly refers to any day when the cost is above or below a threshold, with the base set to the mean plus some standard deviations.
 - Anomaly statistics: Set below the graph containing overall information on anomalies such as the number of high-cost and low-cost anomalies, and the highest and lowest cost anomalies.
 - Anomaly threshold: Set on top of anomaly statistics. A threshold modifier that determines how many standard deviations above or below the mean the anomaly threshold is.
   - Higher thresholds mean a lower likelihood of anomaly appearance. 

## Default View
The app's default start view is the overview view, which displays the total cost for the last 7 days. This view is meant to provide a broad context for usage cost without delving too deeply into details. The date range was set to the last 7 days to provide the most relevant data to the user.

## Chart Types
For each view, the data is visualized using a **line chart or multi-line chart**. This type of chart was chosen because it is easier and more practical for comparing categories over a set period of time than other chart types. 
- The best alternative was an area graph. However, the line graph was chosen over an area graph due to the volatility and lack of clear trends in the data, with instances where multiple categories overlap the same area on a chart.

## Filters
#### Total filters per view:  up to 3 filters and 3 switches in the top row of the page. The current setup has 2 of the main switches stuck at the right of the bar to separate them from the other filters, making the bar cleaner and less cluttered.

All filters are at the top of the page as menu buttons that display new views when selected. Almost all filters allow a maximum of 1 option, with MultiSelect allowing a maximum of 2. 

- DataType switch: Specifically in the overview view. **Switches the data type between total usage cost or week-over-week deltas**. Formatted as a segmented control because of only two active options.
  
- CostType switch: Not included in overview view due to DataTypeSwitch. **Switches the usage cost of the graph between total cost and average cost**. Formatted as a segmented control because of only two active options.
  
- ViewType switch: Available for all views. **Switches the method between a chart or a table**. Formatted as a segmented control because of only two active options.
  
- Anomaly switch: Included in every view. **Activates the anomaly detection feature and threshold picker**, below the graph.
  
- Date Filter: Included in all views. It is a menu that **changes the time the graph displays** to 7, 30, or 90 days, or a custom input. Custom input must include a start and end date, with both in "year-month-day" format.
  
- Multi-Select: Included in Aggregation and WoW views. It is a menu that **changes the category the data is displayed in or split into**, in the graph. Multi-Select can display up to two different categories in a chart.

- DrillDown Cluster: Only in the DrillDown view. It is a menu that **selects which cluster in the data to drill into, displaying usage cost across nodes within the specified cluster**. The default DrillDown view is a graph split by cluster.
  - This filter can go back to the default view by clicking 'All' on the menu.    

- DrillDown Node: Only in the DrillDown view. It is a menu that selects which node in a specified cluster to drill into, displaying usage costs by query type for that node. This filter is activated only if a specific cluster is selected.
  - This filter can go back to the original drilldown cluster by clicking 'All' on the menu.

## Empty State
#### Context: dates refer to the date filter custom date range option
- When no date has been entered, the app will default the screen to displaying all provided data (90 days for sample).
- If an incorrect date format has been provided, an error line will appear in the prompt, which will not close unless correct dates are inserted, and the graph will be replaced with an error page.
- An error page will appear when there is no data provided in the graph or if the start and end dates are the same or placed incorrectly.
  - The error page will have a line stating if there is a specific issue, but will default to "No data available" if none are found.

#### Note: no viable solution has been found yet for custom date ranges with no data available. Please follow guidelines for dates with available data.

## Images
### TabView
<img width="481" height="43" alt="Screenshot 2026-07-27 at 10 15 22 PM" src="https://github.com/user-attachments/assets/4b612c3e-256d-4920-97b1-dbd0ba94c2d2" />

### App graph type: Line/Multi-Line graph
<img width="1375" height="478" alt="Screenshot 2026-07-27 at 10 21 08 PM" src="https://github.com/user-attachments/assets/15a6e785-c313-4eae-bcf8-3eb3ec7f886f" />

### Alternative view type: DataTable or Table
<img width="1391" height="503" alt="Screenshot 2026-07-27 at 10 21 55 PM" src="https://github.com/user-attachments/assets/36b1846d-e227-4ebf-ba39-80d77d303adb" />

### Default View
<img width="1408" height="663" alt="Screenshot 2026-07-27 at 10 18 20 PM" src="https://github.com/user-attachments/assets/50737fa6-63cf-4dfe-98a7-38ebaa42d82f" />

### Filters available in DrillDown View example
<img width="1394" height="108" alt="Screenshot 2026-07-27 at 10 19 42 PM" src="https://github.com/user-attachments/assets/caa9bc4d-a919-4963-95f2-9efef26aef0f" />

### Error View
<img width="224" height="119" alt="Screenshot 2026-07-27 at 10 17 06 PM" src="https://github.com/user-attachments/assets/eb10477f-23a4-4aec-a96b-4def91cc88ff" />
