import Cocoa
import Cocoa
import SwiftUI
import Charts
import SwiftData

public struct Overview: View {
    public var body: some View {
        ScrollView([.horizontal, .vertical]) {
            VStack {
                HStack {
                    Spacer()
                    CSVExport()
                    
                }
                Text("Overview").font(.title)
                HStack {
                    FilterButton()
                    DateFilterButton()
                    DrillDownButton()
                }.padding()
                HStack {
                    totalGraph
                        .frame(maxWidth: .infinity)
                    Divider()
                    totalDataTable
                        .frame(maxWidth: .infinity)
                    WoWGraph()
                        .frame(maxWidth: .infinity)
                    Divider()
                    WoWDataTable()
                        .frame(maxWidth: .infinity)
                }
                VStack {
                    Divider().background(Color.black)
                }
                Text("Graphs Showcase").font(.title)
                VStack {
                    HStack {
                        clusterGraph
                            .frame(maxWidth: .infinity)
                        Divider()
                        clusterDataTable
                            .frame(maxWidth: .infinity)
                        modelGraph
                            .frame(maxWidth: .infinity)
                        Divider()
                        modelDataTable
                            .frame(maxWidth: .infinity)
                    }
                }
            }
        }
    }
    
}
