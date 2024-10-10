//
//  ContentView.swift
//  SimpleHouseholdBudgetingApp
//
//  Created by 佐藤咲祐 on 2023/09/10.
//

import SwiftUI

struct ContentView: View {      //前とは一新してあります。
    @ObservedObject var entryData = EntryData()
    @State private var isReorderMode: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(entryData.entriesGroupedByMonth().keys.sorted(), id: \.self) { key in
                        Section(header: Text(key)) {
                            ForEach(entryData.entriesGroupedByMonth()[key]!, id: \.id) { entry in
                                NavigationLink(destination: EntryDetailView(entry: entry)) {
                                    DisplayEntryRow(type: entry.type, amount: entry.amount)
                                }
                            }
                            .onDelete(perform: { indexSet in
                                deleteEntries(at: indexSet, monthKey: key)
                            })
                            .onMove(perform: { indices, newOffset in
                                moveEntries(from: indices, to: newOffset, monthKey: key)
                            })
                        }
                    }
                }
                .listStyle(PlainListStyle())
                .environment(\.editMode, isReorderMode ? .constant(.active) : .constant(.inactive)) // Add this line
                .navigationTitle("家計簿")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink("追加", destination: AddEntryView(entryData: entryData))
                    }
                    
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            withAnimation {
                                self.isReorderMode.toggle()
                            }
                        }) {
                            Text(isReorderMode ? "完了" : "")
                        }
                    }
                }
                
                Divider()
                
                TotalsFooterView(entryData: entryData)
            }
        }
    }
    
    func deleteEntries(at offsets: IndexSet, monthKey: String) {
            let entriesForMonth = entryData.entriesGroupedByMonth()[monthKey]!
            let idsToDelete = offsets.map { entriesForMonth[$0].id }
            entryData.entries.removeAll { entry in
                idsToDelete.contains(entry.id)
            }
        }
    
    func moveEntries(from source: IndexSet, to destination: Int, monthKey: String) {
        var entriesForMonth = entryData.entriesGroupedByMonth()[monthKey]!
        entriesForMonth.move(fromOffsets: source, toOffset: destination)
        // Find and update the original entries array.
        for movedEntry in source.map({ entriesForMonth[$0] }) {
            if let index = entryData.entries.firstIndex(where: { $0.id == movedEntry.id }) {
                entryData.entries.remove(at: index)
                entryData.entries.insert(movedEntry, at: destination)
            }
        }
    }
}





struct EntryRowView: View {
    @Binding var entry: Entry
    
    var body: some View {
        HStack {
            Text(entry.type.rawValue)
            Spacer()
            Text("¥\(entry.amount, specifier: "%.0f")")
        }
        .padding()
        .background(entry.isSelected ? Color.blue.opacity(0.3) : Color.clear)
    }
}

struct DisplayEntryRow: View {
    var type: EntryType
    var amount: Double

    var body: some View {
        HStack {
            Text(type.rawValue)
            Spacer()
            Text("¥\(amount, specifier: "%.0f")")
        }
        .padding()
    }
}
