//
//  Task.swift
//  test
//
//  Created by Daniil Moskalenko on 15.05.2026.
//

import Foundation
import SwiftData

@Model
class Task {
    var id = UUID()
    var title: String
    var isCompleted: Bool = false
    var order: Int

    init(title: String, isCompleted: Bool = false, order: Int = 0) {
        self.title = title
        self.isCompleted = isCompleted
        self.order = order
    }
}
