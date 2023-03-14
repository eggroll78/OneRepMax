//
//  OneRepMaxApp.swift
//  OneRepMax
//
//  Created by Cliff Chen on 3/9/23.
//

import SwiftUI

@main
struct OneRepMaxApp: App {
    @StateObject private var store = OneRepMaxStore(
        dataSource: FileWorkoutLoader(fileName: "workoutData",
                                      fileType: "txt",
                                      // Enable to see data streamed
                                      simulateLatency: false),
        formula: BrzyckiOneRepMaxFormula()
    )

    var body: some Scene {
        return WindowGroup {
            OneRepMaxList(store: store)
                .task {
                    store.compute()
                }
        }
    }
}
