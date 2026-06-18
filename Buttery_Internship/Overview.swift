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
                    Graph1()
                        .frame(maxWidth: .infinity)
                    Divider()
                    DataTable1()
                        .frame(maxWidth: .infinity)
                    Graph2()
                        .frame(maxWidth: .infinity)
                    Divider()
                    DataTable2()
                        .frame(maxWidth: .infinity)
                }
                VStack {
                    Divider().background(Color.black)
                }
                Text("Graphs Showcase").font(.title)
                VStack {
                    HStack {
                        Graph3()
                            .frame(maxWidth: .infinity)
                        Divider()
                        DataTable3()
                            .frame(maxWidth: .infinity)
                        Graph4()
                            .frame(maxWidth: .infinity)
                        Divider()
                        DataTable4()
                            .frame(maxWidth: .infinity)
                    }
                }
            }
        }
    }
    
}
