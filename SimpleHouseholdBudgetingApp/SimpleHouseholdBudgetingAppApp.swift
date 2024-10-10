//
//  SimpleHouseholdBudgetingAppApp.swift
//  SimpleHouseholdBudgetingApp
//
//  Created by 佐藤咲祐 on 2023/09/10.
//

import SwiftUI

@main
struct SimpleHouseholdBudgetingAppApp: App {
    @ObservedObject var entryData = EntryData()

    var body: some Scene {
        WindowGroup {
            ContentView(entryData: entryData)
        }.onChange(of: scenePhase, perform: { phase in
            if phase == .background {
                entryData.saveToUserDefaults()
            }
        })
    }

    @Environment(\.scenePhase) private var scenePhase
}

