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
    
    init(title: String, graphType: String, description: String?) {
        self.title = title
        self.graphType = graphType
        self.description = description
    }
    
    var body: some View {
        HStack {
            VStack {
                //Title
                Text(title + "\n" + graphType).font(.largeTitle).fontWeight(.bold)
                Text("(2026)").fontWeight(.bold)
            }
            
            if description != nil {
                //Info button
                InfoButton(description: description!).id(description)
            }
            
            Spacer()
            //Date filter button
            DateFilterButton()
            
            //MultiSelect button
            MultiSelectFilterButton()
            
            Spacer()
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
            
            Spacer()
            //Date filter button
            DateFilterButton()
            
            Spacer()
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
    
    init(title: String, graphType: String, description: String?) {
        self.title = title
        self.graphType = graphType
        self.description = description
    }
    
    var body: some View {
        HStack {
            VStack {
                //Title
                Text(title + "\n" + graphType).font(.largeTitle).fontWeight(.bold)
                Text("(2026)").fontWeight(.bold)
            }
            
            if description != nil {
                //Info button
                InfoButton(description: description!).id(description)
            }
        
            Spacer()
            //Date filter button
            DateFilterButton()
            
            //Filter Button
            MultiSelectFilterButton()
            
            Spacer()
        
            //Cost type switch
            CostTypeSwitch()
            
            //View type switch
            ViewTypeSwitch()
        }.padding(.top)
    }
}
//MARK: Drilldown Title and Button
struct DrillDownTitleAndButtonLayout: View {
    @Environment(AppData.self) private var appData
    var title: String
    var graphType: String
    var description: String?
    
    init(title: String, graphType: String, description: String?) {
        self.title = title
        self.graphType = graphType
        self.description = description
    }
    
    var body: some View {
        HStack {
            VStack {
                //Title
                Text(title + "\n" + graphType).font(.largeTitle).fontWeight(.bold)
                Text("(2026)").fontWeight(.bold)
            }
            
            if description != nil {
                //Info button
                InfoButton(description: description!).id(description)
            }
            
            Spacer()
            //Date button
            DateFilterButton()
            //Drilldown buttons
            DrillDownButton()
                .onChange(of: appData.drillFilterCluster) {appData.drillFilterNode = .inital}
            DrillNodeButton()

            Spacer()
            //Cost type button
            CostTypeSwitch()
            
            //View type button
            ViewTypeSwitch()        
        }.padding(.top)
    }
}


