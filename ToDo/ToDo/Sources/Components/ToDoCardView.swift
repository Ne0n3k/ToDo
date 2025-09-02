//
//  ToDoCardView.swift
//  ToDo
//
//  Created by Jakub Błażowski on 25/08/2025.
//

import SwiftUI

struct ToDoCardView: View {
    @State var task: ToDo

    var priorityColor: Color {
        switch task.priority {
        case .high:
            return Color("highPriorityColor")
        case .normal:
            return Color("normalPriorityColor")
        case .low:
            return Color("lowPriorityColor")
        }
    }

    var plannedDateText: String {
        guard let date = task.plannedDate else { return "None" }
        let calendar = Calendar.current
        if calendar.isDateInToday(date) {
            return "Today"
        } else if calendar.isDateInTomorrow(date) {
            return "Tomorrow"
        } else {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd MMMM"
            if calendar.component(.year, from: date) != calendar.component(.year, from: Date()) {
                dateFormatter.dateFormat = "dd MMMM yyyy"
            }
            return dateFormatter.string(from: date)
        }
    }

    var daysUntilDeadline: String {
        guard let deadline = task.deadline else { return "No date" }
        let cal = Calendar.current
        let startOfToday = cal.startOfDay(for: Date())
        let startOfDeadline = cal.startOfDay(for: deadline)
        let daysLeft = cal.dateComponents([.day], from: startOfToday, to: startOfDeadline).day ?? 0
        if daysLeft >= 0 {
            return "\(daysLeft) days left"
        } else {
            return "\(abs(daysLeft)) days after the deadline"
        }
    }

    var body: some View {
        VStack {
            HStack {
                CheckBoxView(isChecked: $task.isCompleted)
                    .padding()
                
                VStack(alignment: .leading, spacing: 5) {
                    Text(task.title)
                        .font(.headline).bold()
                        .foregroundColor(Color("TextColorDark"))
                    
                    HStack {
                        Circle()
                            .fill(priorityColor)
                            .frame(width: 10, height: 10)
                        
                        Text(plannedDateText)
                            .font(.subheadline)
                            .foregroundColor(Color("TextColorDark"))
                    }
                    
                    Text(daysUntilDeadline)
                        .font(.subheadline)
                        .foregroundColor(daysUntilDeadline.contains("after") ? .red : Color("TextColorDark"))
                }
                Spacer()
            }
            .padding()
            .background(Color("backgroundFrameColor"))
            .cornerRadius(15)
            .shadow(radius: 5)
            .padding(.horizontal, 20)
            .padding(.top, 20)
            .padding(.bottom, 8)
            
            Spacer()
        }
    }
}

struct ToDoCardView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoCardView(task: ToDo(title: "Task 1", taskDescription: "Description", priority: .high, plannedDate: Date(), deadline: Date().addingTimeInterval(86400)))
            .previewLayout(.sizeThatFits)
    }
}
