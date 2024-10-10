//
//  EntryDetailView.swift
//  SimpleHouseholdBudgetingApp
//
//  Created by 佐藤咲祐 on 2023/09/29.
//

import SwiftUI

struct EntryDetailView: View {
    var entry: Entry

    var body: some View {
        VStack(spacing: 20) {
            Text(entry.type.rawValue).font(.headline)
            Text("¥\(entry.amount, specifier: "%.0f")").font(.title)
            Text(entry.category).font(.subheadline)
            Text(entry.date, style: .date).font(.subheadline)
        }
        .padding()
        .navigationTitle("明細")
    }
}


struct EntryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        EntryDetailView(entry: Entry(type: .income, amount: 100.0, category: "Salary", date: Date()))
    }
}


