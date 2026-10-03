//
//  CreateBillView.swift
//  SplitMate
//
//  Created by Zoraver Malhotra on 29/09/2026.
//

import SwiftUI

struct Person {
    let name: String
    var percentage: Double
}

struct CreateBillView: View {
    @State private var billName = ""
    @State private var billAmount = ""
    @State private var newPerson = ""
    @State private var people = [
        Person(name: "Zoraver", percentage: 1)
    ]
    @State private var splitMethod = "Equally"
    
    var amountPerPerson: Double {
        guard let amount = Double(billAmount), !people.isEmpty else {
            return 0
        }
        
        return amount / Double(people.count)
    }
    
    func amountForPerson(_ person: Person) -> Double {
        guard let amount = Double(billAmount) else {
            return 0
        }
        
        return amount * person.percentage
    }
    
    var totalPercentage: Double {
        people.reduce(0) {
            total, person in total + person.percentage
        }
    }
    
    var body: some View {
        Form {
            Section("Bill Details") {
                TextField("Bill name", text: $billName)
                
                TextField("Amount", text: $billAmount)
                    .keyboardType(.decimalPad)
            }
            
            Section("People") {
                ForEach(people, id: \.name) {
                    person in Text(person.name)
                }
                .onDelete {
                    IndexSet in people.remove(atOffsets: IndexSet)
                }
                
                TextField("Person name", text: $newPerson)
                
                Button("Add Person") {
                    if !newPerson.isEmpty {
                        people.append(
                            Person(name: newPerson, percentage: 0)
                        )
                        
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
                    ForEach(people, id: \.name) {
                        person in HStack {
                            Text(person.name)
                            
                            Spacer()
                            
                            Text(String(format: "$%.2f", amountPerPerson))
                        }
                    }
                }
                
                if splitMethod == "Percentage" {
                    if totalPercentage != 1 {
                        Text("Percentages total \(String(format: "%.0f", totalPercentage * 100))%")
                            .foregroundStyle(.red)
                    }
                    
                    ForEach($people, id: \.name) {
                        $person in HStack {
                            Text(person.name)

                            Spacer()
                            
                            TextField(
                                "Percentage",
                                value: $person.percentage,
                                format: .percent
                            )
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                            
                            Text(
                                String(
                                    format: "$%.2f",
                                    amountForPerson(person)
                                )
                            )
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
