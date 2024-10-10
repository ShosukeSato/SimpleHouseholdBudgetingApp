//
//  EntryModel.swift
//  SimpleHouseholdBudgetingApp
//
//  Created by 佐藤咲祐 on 2023/09/10.
//

import Foundation

struct Entry: Identifiable, Codable {
    var id = UUID()
    var type: EntryType
    var amount: Double
    var category: String
    var date: Date
    var isSelected: Bool = false
}


enum EntryType: String, CaseIterable, Codable {
    case income = "収入"
    case expense = "支出"
}


