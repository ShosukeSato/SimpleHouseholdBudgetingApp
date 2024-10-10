//
//  EntryData.swift
//  SimpleHouseholdBudgetingApp
//
//  Created by 佐藤咲祐 on 2023/09/10.
//

import SwiftUI

class EntryData: ObservableObject {
    @Published var entries: [Entry] {
        didSet {
            saveToUserDefaults()
        }
    }

    init() {
        if let savedData = UserDefaults.standard.data(forKey: "Entries"),
           let decodedData = try? JSONDecoder().decode([Entry].self, from: savedData) {
            self.entries = decodedData
        } else {
            self.entries = []
        }
    }

    func saveToUserDefaults() {
        if let encodedData = try? JSONEncoder().encode(entries) {
            UserDefaults.standard.set(encodedData, forKey: "Entries")
        }
    }
    
    func entriesGroupedByMonth() -> [String: [Entry]] {   //ここが新しい関数のコード
        var groupedEntries: [String: [Entry]] = [:]
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM"
        
        for entry in entries {
            let key = dateFormatter.string(from: entry.date)
            if var entriesForMonth = groupedEntries[key] {
                entriesForMonth.append(entry)
                groupedEntries[key] = entriesForMonth
            } else {
                groupedEntries[key] = [entry]
            }
        }
        
        return groupedEntries
    }
    
    func totals(for entries: [Entry]) -> (income: Double, expense: Double) {  //ここも
        var income = 0.0
        var expense = 0.0
        
        for entry in entries {
            if entry.type == .income {
                income += entry.amount
            } else {
                expense += entry.amount
            }
        }
        
        return (income, expense)
    }
}


extension EntryData {
    var totalIncome: Double {
        entries.filter { $0.type == .income }.map { $0.amount }.reduce(0, +)
    }

    var totalExpense: Double {
        entries.filter { $0.type == .expense }.map { $0.amount }.reduce(0, +)
    }
}
