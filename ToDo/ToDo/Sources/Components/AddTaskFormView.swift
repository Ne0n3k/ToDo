//
//  AddTaskFormView.swift
//  ToDo
//
//  Created by Jakub Błażowski on 22/08/2025.
//

import SwiftUI
import SwiftData

struct AddTaskFormView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss

    @State private var title: String = ""
    @State private var description: String = ""
    @State private var priority: Priority = .normal
    @State private var plannedDate: Date = Date()
    @State private var deadline: Date = Date()

    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color("gradientStartColor"),
                        Color("gradientEndColor")
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                Form {
                    Section(header: Text("Title")) {
                        TextField("Add title", text: $title)
                    }
                    Section(header: Text("Description")) {
                        TextField("Task description", text: $description)
                    }
                    Section(header: Text("Priority")) {
                        Picker("Priority", selection: $priority) {
                            ForEach(Priority.allCases, id: \.self) { pri in
                                Text(pri.rawValue).tag(pri)
                            }
                        }
                        .pickerStyle(.segmented)
                    }
                    Section(header: Text("Date")) {
                        DatePicker("Planned date", selection: $plannedDate, displayedComponents: .date)
                        DatePicker("Deadline", selection: $deadline, displayedComponents: .date)
                    }
                }
                .scrollContentBackground(.hidden)
                .background(Color.clear)
            }
            .navigationTitle("New task")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Back") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        saveTask()
                        dismiss()
                    }
                    .disabled(title.isEmpty)
                }
            }
        }
        .navigationViewStyle(.stack)
    }

    private func saveTask() {
        let newTask = ToDo(
            title: title,
            taskDescription: description.isEmpty ? nil : description,
            priority: priority,
            plannedDate: plannedDate,
            deadline: deadline
        )
        context.insert(newTask)
    }
}

struct AddTaskFormView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskFormView()
            .modelContainer(for: ToDo.self, inMemory: true)
    }
}
