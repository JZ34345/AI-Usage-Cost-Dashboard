import Cocoa
import Cocoa
import SwiftUI
import Charts
import SwiftData
import PlaygroundSupport

var greeting = "Hello, playground"

struct Overview: View {
    var body: some View {
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
                Divider()
                DataTable1()
            }
            HStack {
                Graph2()
                Divider()
                DataTable2()
            }
            Text("Graphs Showcase").font(.title)
            VStack {
                HStack {
                    Graph3()
                    Divider()
                    DataTable3()
                }
                HStack {
                    Graph4()
                    Divider()
                    DataTable4()
                }
            }

        }
    }
    
}
