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
        VStack {
            HStack {
                //Title
                Text(title).font(.largeTitle)
                if description != nil {
                    //Info button
                    InfoButton(description: description!).id(description)
                }
            }
            HStack {
                Spacer()
                //Data type switch
                DataTypeSwitch()
                
                //View type switch
                ViewTypeSwitch()
                Spacer()
                
            }.padding(.top)
            HStack {
                Spacer()
                //Date filter button
                DateFilterButton()
                Spacer()
            }.padding(.top)
        }
    }
}
//MARK: WoW Title and Button
struct WoWTitleAndButtonLayout: View {
    var title: String
    var description: String?
    
    init(title: String, description: String?) {
        self.title = title
        self.description = description
    }
    
    var body: some View {
        VStack {
            HStack {
                //Title
                Text(title).font(.largeTitle)
                if description != nil {
                    //Info button
                    InfoButton(description: description!).id(description)
                }
            }
            HStack {
                Spacer()
                //Cost type button
                CostTypeSwitch()
                
                //View type button
                ViewTypeSwitch()
                Spacer()
            }.padding(.top)
            
            HStack {
                Spacer()
                //Date filter button
                DateFilterButton()
                
                //MultiSelect button
                MultiSelectFilterButton()
                Spacer()
            }.padding(.top)
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
        VStack {
            HStack {
                //Title
                Text(title).font(.largeTitle)
                if description != nil {
                    //Info button
                    InfoButton(description: description!).id(description)
                }
            }
            HStack {
                Spacer()
                //Data type button
                DataTypeSwitch()
                
                //View type switch
                ViewTypeSwitch()
                Spacer()
            }.padding(.top)
            HStack {
                Spacer()
                //Date filter button
                DateFilterButton()
                Spacer()
            }.padding(.top)
        }
    }
}
//MARK: Aggregation Title and Button
struct AggregationTitleAndButtonLayout: View {
    var title: String
    var description: String?
    
    init(title: String, description: String?) {
        self.title = title
        self.description = description
    }
    
    var body: some View {
        VStack {
            HStack {
                //Title
                Text(title).font(.largeTitle)
                if description != nil {
                    //Info button
                    InfoButton(description: description!).id(description)
                }
            }
            HStack() {
                Spacer()
                //Cost type switch
                CostTypeSwitch()
                
                //View type switch
                ViewTypeSwitch()
                Spacer()
            }.padding(.top)
            
            HStack() {
                Spacer()
                //Date filter button
                DateFilterButton()
                
                //Filter Button
                MultiSelectFilterButton()
                Spacer()
            }.padding(.top)
        }
    }
}
//MARK: Drilldown Title and Button
struct DrillDownTitleAndButtonLayout: View {
    @Environment(AppData.self) private var appData
    var title: String
    var description: String?
    
    
    init(title: String, description: String?) {
        self.title = title
        self.description = description
    }
    
    var body: some View {
        VStack {
            HStack {
                //Title
                Text(title).font(.largeTitle)
                if description != nil {
                    //Info button
                    InfoButton(description: description!).id(description)
                }
            }

            HStack() {
                Spacer()
                //Cost type button
                CostTypeSwitch()
                
                //View type button
                ViewTypeSwitch()
                
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
        }
    }
}


