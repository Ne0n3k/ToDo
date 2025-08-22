//
//  ToDoCardView.swift
//  ToDo
//
//  Created by Jakub Błażowski on 22/08/2025.
//

import SwiftUI

struct ToDoCardView: View {
    let task: ToDo
    @Binding var isCompleted: Bool

    private var priorityColor: Color {
        switch task.priority {
        case .high:   return .red
        case .normal: return .yellow
        case .low:    return .green
        }
    }

    private var plannedDateTextValue: String {
        plannedDateText(task.plannedDate)
    }

    private var daysUntilDeadlineValue: String {
        daysUntilDeadlineString(task.deadline)
    }

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            CheckBoxView(isChecked: $isCompleted)
                .padding(.top, 2)

            VStack(alignment: .leading, spacing: 6) {
                Text(task.title)
                    .font(.headline)
                    .foregroundStyle(.primary)

                if let desc = task.taskDescription, !desc.isEmpty {
                    Text(desc)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .lineLimit(2)
                }

                HStack(spacing: 8) {
                    Circle()
                        .fill(priorityColor)
                        .frame(width: 8, height: 8)

                    Text(plannedDateTextValue)
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }

                Text(daysUntilDeadlineValue)
                    .font(.footnote)
                    .foregroundStyle(daysUntilDeadlineValue.contains("after") ? .red : .secondary)
            }

            Spacer(minLength: 0)
        }
        .padding(14)
        .background(
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .fill(.background.opacity(0.6))
                .overlay(
                    RoundedRectangle(cornerRadius: 14, style: .continuous)
                        .stroke(.quaternary, lineWidth: 1)
                )
        )
        .shadow(radius: 2, y: 1)
        .padding(.horizontal, 16)
        .padding(.vertical, 6)
    }
}

#Preview("ToDoCardView", traits: .sizeThatFitsLayout) {
    ToDoCardView(
        task: ToDo(
            title: "Prototype ToDoCardView",
            taskDescription: "Small card showing priority, planned date and deadline.",
            priority: .high,
            plannedDate: Date(),
            deadline: Calendar.current.date(byAdding: .day, value: 2, to: Date())
        ),
        isCompleted: .constant(false)
    )
    .padding()
}
