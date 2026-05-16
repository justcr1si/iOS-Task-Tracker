//
//  TaskTrackerApp.swift
//  test
//
//  Created by Daniil Moskalenko on 15.05.2026.
//

import SwiftUI
import SwiftData

@main
struct TaskTrackerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Task.self)
    }
}
