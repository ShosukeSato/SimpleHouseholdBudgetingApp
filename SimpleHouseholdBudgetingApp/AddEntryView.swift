//
//  AddEntryView.swift
//  SimpleHouseholdBudgetingApp
//
//  Created by 佐藤咲祐 on 2023/09/10.
//

import SwiftUI

struct AddEntryView: View {
    @ObservedObject var entryData: EntryData
    @State private var type: EntryType = .income
    @State private var amount: String = ""
    @State private var category: String = ""
    
    var body: some View {
        Form {
            Picker("タイプ", selection: $type) {
                ForEach(EntryType.allCases, id: \.self) { type in
                    Text(type.rawValue).tag(type)
                }
            }
            
            TextField("金額", text: $amount).keyboardType(.decimalPad)
            
            TextField("カテゴリ", text: $category)
            
            Button("保存") {
                if let amount = Double(amount), !category.isEmpty {
                    let entry = Entry(type: type, amount: amount, category: category, date: Date())
                    entryData.entries.insert(entry, at: 0) // Insert new entries at the beginning
                }
            }
        }
    }
}


