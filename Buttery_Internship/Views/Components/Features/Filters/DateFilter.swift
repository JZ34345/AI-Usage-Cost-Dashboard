//
//  DateFilter.swift
//  Buttery_Internship
//
//  Created by Jason Zhang on 6/19/26.
//
import Cocoa
import SwiftUI
import Charts
import SwiftData

//MARK: Date filter
 struct DateFilterButton: View {
     @Environment(AppData.self) private var appData
     
    //MARK: Options
    //date filter options
     enum DataFilterOptions: String, CaseIterable {
        case seven = "7 Days"
        case thirty = "30 Days"
        case ninety = "90 Days"
        case custom = "Custom"
     }
     
     var label: String {
         switch appData.dateFilter {
         case .seven: return "7"
         case .thirty: return "30"
         case .ninety: return "90"
         case .custom: return "Custom"
         }
     }
    
     var body: some View {
        @Bindable var appBindData = appData
         
        //MARK: UI Structure
        //UI appearance for date filter
         VStack {
             Text("Day Range (\(label))").fontWeight(.semibold)
             Menu {
                 ForEach(DataFilterOptions.allCases, id: \.self) { option in
                     Button {
                         appData.dateFilter = option
                         
                         if option == .custom {
                             appData.datePicker = true
                         }
                     } label: {
                         Label(option.rawValue, systemImage: appData.dateFilter == option ? "checkmark" : " ")
                     }
                     
                 }
             } label: {
                 Label("", systemImage: "line.3.horizontal.decrease")
             }.menuStyle(.borderedButton)
                 .tint(.blue)
             
             //Display for custom input
                 .sheet(isPresented: $appBindData.datePicker) {
                     VStack {
                         Text("Custom Date Range").font(.headline)
                         
                         TextField("(yyyy-MM-dd)", text: $appBindData.startDate)
                             .border(appData.datePickerError != nil ? Color.red : Color.clear)
                         TextField("(yyyy-MM-dd)", text: $appBindData.endDate)
                             .border(appData.datePickerError != nil ? Color.red : Color.clear)
                         
                         if let error = appData.datePickerError {
                             Text(error).foregroundColor(Color.red).font(.caption)
                         }
                         
                         Button("Apply") {
                             appData.datePicker = false
                         }.disabled(appData.datePickerError != nil || appData.startDate == appData.endDate)
                     }.padding().frame(width: 300)
                 }
         }
    }
}
