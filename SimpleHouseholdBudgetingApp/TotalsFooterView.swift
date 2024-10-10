//
//  TotalsFooterView.swift
//  SimpleHouseholdBudgetingApp
//
//  Created by 佐藤咲祐 on 2023/09/28.
//

import SwiftUI

struct TotalsFooterView: View {
    @ObservedObject var entryData: EntryData

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("合計収入:")
                Spacer()
                Text("¥\(entryData.totalIncome, specifier: "%.0f")")
            }
            HStack {
                Text("合計支出:")
                Spacer()
                Text("¥\(entryData.totalExpense, specifier: "%.0f")")
            }
        }
        .padding()
    }
}

