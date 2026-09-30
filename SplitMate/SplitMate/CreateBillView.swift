//
//  CreateBillView.swift
//  SplitMate
//
//  Created by Zoraver Malhotra on 29/09/2026.
//

import SwiftUI

struct CreateBillView: View {
    @State private var billName = ""
    @State private var billAmount = ""
    @State private var newPerson = ""
    @State private var people = ["Zoraver"]
    @State private var splitMethod = "Equally"
    
    var amountPerPerson: Double {
        guard let amount = Double(billAmount), !people.isEmpty else {
            return 0
        }
        
        return amount / Double(people.count)
    }
    
    var body: some View {
        Form {
            Section("Bill Details") {
                TextField("Bill name", text: $billName)
                
                TextField("Amount", text: $billAmount)
                    .keyboardType(.decimalPad)
            }
            
            Section("People") {
                ForEach(people, id: \.self) {
                    person in Text(person)
                }
                .onDelete {
                    IndexSet in people.remove(atOffsets: IndexSet)
                }
                
                TextField("Person name", text: $newPerson)
                
                Button("Add Person") {
                    if !newPerson.isEmpty {
                        people.append(newPerson)
                        newPerson = ""
                    }
                }
            }
            
            Section("Split Method") {
                Picker("Split Method", selection: $splitMethod) {
                    Text("Equally").tag("Equally")
                    Text("By Percentage").tag("Percentage")
                    Text("By Item").tag("Item")
                }
            }
            
            Section("Split") {
                if splitMethod == "Equally" {
                    ForEach(people, id: \.self) {
                        person in HStack {
                            Text(person)
                            
                            Spacer()
                            
                            Text(String(format: "$%.2f", amountPerPerson))
                        }
                    }
                }
            }
        }
        .navigationTitle("New Bill")
    }
}

#Preview {
    CreateBillView()
}
