//
//  RegressionTitleButtonLayouy.swift
//  Buttery_Internship
//
//  Created by Jason Zhang on 7/17/26.
//
import Cocoa
import SwiftUI

//MARK: Regression Forecast Title and Button
struct RegressionTitleButtonLayout: View {
    @Environment(AppData.self) private var appData

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
                if appData.costType == .total {
                    Text("Regression Forecast").font(.largeTitle).fontWeight(.bold)
                } else {
                    Text("Average").font(.largeTitle).fontWeight(.bold)
                    Text("Regression Forecast").font(.largeTitle).fontWeight(.bold)
                }
                Text("(2026)").fontWeight(.bold)
            }
            
            if description != nil {
                //Info button
                InfoButton(description: description!).id(description)
            }
            
            Spacer()
                        
            HStack {
                //Data type switch
                CostTypeSwitch()
                
                //View type switch
                ViewTypeSwitch()
            }
            
        }
    }
}
