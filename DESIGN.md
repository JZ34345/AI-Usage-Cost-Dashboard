# DESIGN Page

## Views
#### All costs mentioned in the views below can be seen as either total usage cost for each day or an average cost per day in the graph.
Overview: displays a swappable view of either **total cost of AI usage or a basic WoW delta graph** as an entry point to the data. The two graphs in the view are simple enough to let users get started while allowing them to see a broad scope of the data.

Aggregation: displays a view of **cost split by category (Total, Model, Node, Query Lines)**. Multiple categories can be compared at once, but only up to two categories. Allows users to see which category is driving the increase in cost.
- Two categories max, as more than two categories makes the graph unreadable and produces strain on the app.

DrillDown: displays a **view of cost down from cluster, to node, and to query type**. Allows for analysis and comparison of which item in a category drives increased cost. 

WoW: displays cost as **week-over-week deltas comparing the current week and previous ones**. Allows for analysis of cost trends over time. 

Forecast: displays **costs as predictions using linear regression**. Allows forecasting of potential costs for the next 30 days from the latest datapoint. 

## TabView
The type of view can be switched using the TabView object at the very front, displaying all the possible view types clearly all in one place. View switching occurs by pressing on the view users wish to select. 

## Default View
The default start view of the app is the overview view that displays the total cost for the last 7 days of the data. This view is meant to provide a broad context into the usage cost without initially delving too deep into details of usage cost. The date range was set to the last 7 days of data to provide the most relevant data to the user when entering, while also offering preset date ranges or custom input for usage cost over a longer period.

## Chart types
For each view, the data is visualized using a **line chart or multi-line chart**. This type of chart was chosen because it allows easy comparisons between categories over a set period of time. It is more practical to compare across periods of time than bar or stacked bar charts.  
- The best alternative was an area graph. However, the line graph was chosen over an area graph due to the volatility, or lack of clear trends, of the data used, and instances where multiple categories overlap the same area in a chart.

## Filters
Filters are all at the top of the page. They are menu buttons with new views appearing by clicking on menu options. Almost all filters have a max of one selection active at once, with MultiSelect having a max of 2 options at most. 

- DataType switch: Specifically in overview view. **Switches the data type between total usage cost or week-over-week deltas**. The switch is formatted as a segmented control because it has only two options to choose from.
  
- CostType switch: Not included in overview view due to DataTypeSwitch. **Switches the usage cost of the graph between total cost and average cost**. The switch is formatted as a segmented control because it has only two options.
  
- ViewType switch: Available for all views. **Switches the method by which data is visualized between a chart or a table**. The switch is formatted as a segmented control because it has only two options to choose from.
  
- Anomaly switch: Included in every view. **Activates the anomaly detection feature and threshold picker**, below the graph.
  
- Date Filter: Included in all views. It is a menu that **changes the time the graph displays** to 7, 30, or 90 days, or a custom input. Custom input must include a start and end date, with both dates in the format of "year-month-day".
  
- Multi-Select: Included in Aggregation and WoW views. It is a menu that **changes the category the data is displayed in, or split into**, in the graph. Multi-Select can display up to two different categories in a chart.

- DrillDown Cluster: Only in the DrillDown view. It is a menu that **selects which cluster in the data to drill into, displaying usage cost along nodes within the specified cluster**. The default DrillDown view is a graph split by cluster.
  - This filter can go back to the default view by clicking 'All' on the menu.    

- DrillDown Node: Only in the DrillDown view. It is a menu that selects which node in a specified cluster to drill into, displaying usage costs by query type for that node. This filter is activated only if the DrillDown Cluster selects a specific cluster.
  - This filter can go back to the original drilldown cluster view by clicking 'All' on the menu.

**Empty State
**** Note: no viable solution has been found yet for custom date ranges with no data available. Please follow guidelines on prompts for dates with data available to use.
- When no date has been entered in the custom date range, the app will default the screen to displaying all the data provided (90 days for sample data).
- If an incorrect date format has been provided in the custom date range, an error line will appear in the prompt, which will not move forward unless correct dates are inserted, and the graph will be replaced with a blank page.
- An error page will appear when there is no data provided in the graph or if the start and end date of the custom date range are the same or placed incorrectly.
  - The error page will have a line stating what specific issue has occurred, but will default to "No data available" if no specific issue is found.

 Filter: Which scales when there are 5+ filters active
