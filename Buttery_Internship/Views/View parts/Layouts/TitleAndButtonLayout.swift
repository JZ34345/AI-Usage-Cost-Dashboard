//
//  TitleAndButtonLayout.swift
//  Buttery_Internship
//
//  Created by Jason Zhang on 7/11/26.
//
import Cocoa
import SwiftUI

//MARK: Overview Title and Button
struct OverviewTitleAndButtonLayout: View {
    var title: String
    var description: String?
    
    init(title: String, description: String?) {
        self.title = title
        self.description = description
    }
    
    var body: some View {
        HStack {
            VStack {
                //Title
                Text(title).font(.largeTitle).fontWeight(.bold)
                Text("(2026)").fontWeight(.bold)
            }
            
            if description != nil {
                //Info button
                InfoButton(description: description!).id(description)
            }
            
            Spacer()
            
            //Date filter button
            DateFilterButton()
            
            //Anomaly Switch
            AnomalySwitch()
            
            Spacer()
            
            HStack {
                //Data type switch
                DataTypeSwitch()
                
                //View type switch
                ViewTypeSwitch()
            }
            
        }
    }
}
//MARK: WoW Title and Button
struct WoWTitleAndButtonLayout: View {
    var title: String
    var graphType: String
    var description: String?
    var isAverage: Bool
    
    init(title: String, graphType: String, description: String?, isAverage: Bool) {
        self.title = title
        self.graphType = graphType
        self.description = description
        self.isAverage = isAverage
    }
    
    var body: some View {
        HStack {
            VStack {
                //Title
                if isAverage {
                    Text(title).font(.largeTitle).fontWeight(.bold)
                    Text("Average").font(.largeTitle).fontWeight(.bold)
                    Text(graphType).font(.largeTitle).fontWeight(.bold)
                } else {
                    Text(title).font(.largeTitle).fontWeight(.bold)
                    Text(graphType).font(.largeTitle).fontWeight(.bold)
                }
                
                Text("(2026)").fontWeight(.bold)
            }
            
            if description != nil {
                //Info button
                InfoButton(description: description!).id(description)
            }
            
            Spacer(minLength: 330)
            //Date filter button
            DateFilterButton()
            
            //MultiSelect button
            MultiSelectFilterButton()
            
            Spacer(minLength: 100)
            //Cost type button
            CostTypeSwitch()
            
            //View type button
            ViewTypeSwitch()
        }
    }
}

//MARK: Overview WoW Title and Button
struct WoWOverviewTitleAndButtonLayout: View {
    var title: String
    var description: String?
    
    init(title: String, description: String?) {
        self.title = title
        self.description = description
    }
    
    var body: some View {
        HStack {
            VStack {
                //Title
                Text(title).font(.largeTitle).fontWeight(.bold)
                Text("(2026)").fontWeight(.bold)
            }
            
            if description != nil {
                //Info button
                InfoButton(description: description!).id(description)
            }
            
            Spacer(minLength: 100)
            //Date filter button
            DateFilterButton()
            
            Spacer(minLength: 100)
            //Cost type button
            DataTypeSwitch()
            
            //View type button
            ViewTypeSwitch()
        }
    }
}
//MARK: Aggregation Title and Button
struct AggregationTitleAndButtonLayout: View {
    var title: String
    var graphType: String
    var description: String?
    var isAverage: Bool
    
    init(title: String, graphType: String, description: String?, isAverage: Bool) {
        self.title = title
        self.graphType = graphType
        self.description = description
        self.isAverage = isAverage
    }
    
    var body: some View {
        HStack {
            VStack {
                //Title
                if isAverage {
                    Text(title).font(.largeTitle).fontWeight(.bold)
                    Text("Average").font(.largeTitle).fontWeight(.bold)
                    Text(graphType).font(.largeTitle).fontWeight(.bold)
                } else {
                    Text(title).font(.largeTitle).fontWeight(.bold)
                    Text(graphType).font(.largeTitle).fontWeight(.bold)
                }
                
                Text("(2026)").fontWeight(.bold)
            }
            
            if description != nil {
                //Info button
                InfoButton(description: description!).id(description)
            }
        
            Spacer(minLength: 200)
            //Date filter button
            DateFilterButton()
            
            //Filter Button
            MultiSelectFilterButton()
            
            //Anomaly Switch
            AnomalySwitch()
            
            Spacer(minLength: 80)

            //Cost type switch
            CostTypeSwitch()
            
            //View type switch
            ViewTypeSwitch()
        }
    }
}
//MARK: Drilldown Title and Button
struct DrillDownTitleAndButtonLayout: View {
    @Environment(AppData.self) private var appData
    var title: String
    var graphType: String
    var description: String?
    var isAverage: Bool
    
    init(title: String, graphType: String, description: String?, isAverage: Bool) {
        self.title = title
        self.graphType = graphType
        self.description = description
        self.isAverage = isAverage
    }
    
    var body: some View {
        HStack {
            VStack {
                //Title
                if isAverage {
                    Text(title).font(.largeTitle).fontWeight(.bold)
                    Text("Average").font(.largeTitle).fontWeight(.bold)
                    Text(graphType).font(.largeTitle).fontWeight(.bold)
                } else {
                    Text(title).font(.largeTitle).fontWeight(.bold)
                    Text(graphType).font(.largeTitle).fontWeight(.bold)
                }
                
                Text("(2026)").fontWeight(.bold)
            }
            
            if description != nil {
                //Info button
                InfoButton(description: description!).id(description)
            }
            
            Spacer(minLength: 200)
            //Date button
            DateFilterButton()
            //Drilldown menus
            DrillDownButton()
                .onChange(of: appData.drillFilterCluster) {appData.drillFilterNode = .inital}
            DrillNodeButton()
            
            //Anomaly Switch
            AnomalySwitch()

            Spacer(minLength: 100)
            //Cost type button
            CostTypeSwitch()
            
            //View type button
            ViewTypeSwitch()        
        }
    }
}


