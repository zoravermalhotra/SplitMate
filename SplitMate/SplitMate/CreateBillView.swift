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
    
    var body: some View {
        Form {
            Section("Bill Details") {
                TextField("Bill name", text: $billName)
                
                TextField("Amount", text: $billAmount)
                    .keyboardType(.decimalPad)
            }
        }
        .navigationTitle("New Bill")
    }
}

#Preview {
    CreateBillView()
}
