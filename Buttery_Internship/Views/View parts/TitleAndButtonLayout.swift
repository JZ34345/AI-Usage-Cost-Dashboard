//
//  TitleAndButtonLayout.swift
//  Buttery_Internship
//
//  Created by Jason Zhang on 7/11/26.
//
import Cocoa
import SwiftUI

struct OverviewTitleAndButtonLayout: View {
    var title: String
    
    init(title: String) {
        self.title = title
    }
    
    var body: some View {
        VStack {
            Text(title).font(.largeTitle)
            HStack {
                Spacer()
                //Data type button
                DataTypeSwitch()
                
                //Date filter button
                DateFilterButton()
                Spacer()
            }.padding(.top)
        }.padding(.bottom)
    }
}

struct WoWTitleAndButtonLayout: View {
    var title: String
    var description: String
    
    init(title: String, description: String) {
        self.title = title
        self.description = description
    }
    
    var body: some View {
        VStack {
            Text(title).font(.largeTitle)
            Text(description).font(.title).foregroundStyle(.gray)
            HStack {
                Spacer()
                //Data type button
                CostTypeSwitch()
                
                //Date filter button
                DateFilterButton()
                Spacer()
            }.padding(.top)
        }.padding(.bottom)
    }
}

struct WoWOverviewTitleAndButtonLayout: View {
    var title: String
    var description: String
    
    init(title: String, description: String) {
        self.title = title
        self.description = description
    }
    
    var body: some View {
        VStack {
            Text(title).font(.largeTitle)
            Text(description).font(.title).foregroundStyle(.gray)
            HStack {
                Spacer()
                //Data type button
                DataTypeSwitch()
                
                //Date filter button
                DateFilterButton()
                Spacer()
            }.padding(.top)
        }.padding(.bottom)
    }
}

struct AggregationTitleAndButtonLayout: View {
    var title: String
    
    init(title: String) {
        self.title = title
    }
    
    var body: some View {
        VStack {
            Text(title).font(.largeTitle)
            HStack() {
                Spacer()
                //Cost type button
                CostTypeSwitch()
                
                //Date filter button
                DateFilterButton()
                
                //Filter Button
                MultiSelectFilterButton()
                Spacer()
            }.padding(.top)
        }.padding(.bottom)
    }
}

struct DrillDownTitleAndButtonLayout: View {
    @Environment(AppData.self) private var appData
    var title: String
    
    
    init(title: String) {
        self.title = title
    }
    
    var body: some View {
        VStack {
            Text(title).font(.largeTitle)
            
            HStack() {
                Spacer()
                //Cost type button
                CostTypeSwitch()
                
                //Date button
                DateFilterButton()
                Spacer()
            }.padding(.top)
            
            HStack {
                Spacer()
                //Drilldown buttons
               DrillDownButton()
                   .onChange(of: appData.drillFilterCluster) {appData.drillFilterNode = .inital}
               DrillNodeButton()
                Spacer()
            }.padding(.top)
        }.padding(.bottom)
    }
}


