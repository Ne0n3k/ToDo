//
//  CompletedTasksView.swift
//  ToDo
//
//  Created by Jakub Błażowski on 25/08/2025.
//

import SwiftUI

struct CompletedTasksView: View {
    let toDos: [ToDo]

    var body: some View {
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

            ScrollView {
                VStack {
                    ForEach(toDos.filter { $0.isCompleted }) { task in
                        ToDoCardView(task: task)
                    }
                }
            }
        }
    }
}

struct CompletedTasksView_Previews: PreviewProvider {
    static var previews: some View {
        CompletedTasksView(toDos: [
            ToDo(title: "Done 1", priority: .normal, isCompleted: true),
            ToDo(title: "Done 2", priority: .high, isCompleted: true),
            ToDo(title: "Not done", priority: .low, isCompleted: false)
        ])
    }
}
