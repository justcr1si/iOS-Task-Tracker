//
//  ContentView.swift
//  test
//
//  Created by Daniil Moskalenko on 14.05.2026.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Query(sort: \Task.order) private var tasks: [Task]
    @Environment(\.modelContext) private var modelContext
    @State private var newTaskTitle: String = ""

    var body: some View {
        VStack {
            Text("Task Tracker")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom)

            HStack {
                TextField("New Task", text: $newTaskTitle)
                Button("Add") {
                    addTask()
                }
                .buttonStyle(.borderedProminent)
                .disabled(newTaskTitle.isEmpty)
            }
            .padding()

            List {
                ForEach(tasks) { task in
                    HStack {
                        Text(task.title)
                            .strikethrough(task.isCompleted)
                            .fontWeight(.medium)
                        Image(
                            systemName: task.isCompleted ?
                                "checkmark.seal.fill" : "circlebadge"
                        )
                    }
                    .onTapGesture {
                        toggleTask(task)
                    }
                }
                .onMove(perform: moveTask)
                .onDelete(perform: deleteTask)
            }
            .toolbar {
                EditButton()
            }
        }
    }

    private func moveTask(from source: IndexSet, to destination: Int) {
        var updatedTasks = tasks
        updatedTasks.move(fromOffsets: source, toOffset: destination)

        for index in updatedTasks.indices {
            updatedTasks[index].order = index
        }
    }

    private func addTask() {
        let newTask = Task(title: newTaskTitle, order: tasks.count)
        modelContext.insert(newTask)
        newTaskTitle = ""
    }

    private func toggleTask(_ task: Task) {
        task.isCompleted.toggle()
    }

    private func deleteTask(at offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(tasks[index])
        }
    }
}

#Preview {
    ContentView()
}
