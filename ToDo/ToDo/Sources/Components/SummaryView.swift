//
//  SummaryView.swift
//  ToDo
//
//  Created by Jakub Błażowski on 22/08/2025.
//

import SwiftUI

struct SummaryView: View {
    let toDos: [ToDo]
    
    private var upcomingTasks: Int {
        toDos
            .filter { !$0.isCompleted }
            .filter {
                ($0.plannedDate ?? .distantPast) >= Date() &&
                ($0.deadline ?? .distantFuture) > Date()
            }
            .count
    }
    private var overdueTasks: Int {
        toDos
            .filter { !$0.isCompleted }
            .filter { ($0.deadline ?? .distantFuture) < Date() }
            .count
    }
    private var completedTasks: Int {
        toDos.filter { $0.isCompleted }.count
    }
    private var highPriorityTasks: Int {
        toDos
            .filter { !$0.isCompleted }
            .filter { $0.priority == .high }
            .count
    }
    private var normalPriorityTasks: Int {
        toDos
            .filter { !$0.isCompleted }
            .filter { $0.priority == .normal }
            .count
    }
    private var lowPriorityTasks: Int {
        toDos
            .filter { !$0.isCompleted }
            .filter { $0.priority == .low }
            .count
    }

    private var sortedTasks: [ToDo] {
        let now = Date()
        let active = toDos.filter { !$0.isCompleted }
        let upcoming = active
            .filter { ($0.deadline ?? .distantFuture) >= now }
            .sorted { ($0.deadline ?? now) < ($1.deadline ?? now) }
        let overdue = active
            .filter { ($0.deadline ?? .distantFuture) < now }
            .sorted { ($0.deadline ?? now) < ($1.deadline ?? now) }
        return upcoming + overdue
    }
    
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
            .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading, spacing: 20) {
                VStack(spacing: 15) {
                    SummaryCardView(title: "upcoming", count: upcomingTasks)
                    HStack(spacing: 15) {
                        SummaryCardView(title: "overdue", count: overdueTasks, color: .orange)
                        SummaryCardView(title: "completed", count: completedTasks, color: .purple)
                    }
                    HStack(spacing: 15) {
                        SummaryCardView(title: "high", count: highPriorityTasks, color: .red)
                        SummaryCardView(title: "normal", count: normalPriorityTasks, color: .yellow)
                        SummaryCardView(title: "low", count: lowPriorityTasks, color: .green)
                    }
                }
                .padding(.horizontal, 20)
                
                ScrollView {
                    VStack {
                        ForEach(sortedTasks) { task in
                            ToDoCardView(task: task)
                        }
                    }
                }
                .frame(height: 400)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.white.opacity(0.3), lineWidth: 1)
                )
                .padding(.horizontal, 20)
                
                Spacer()
            }
        }
    }
}


struct SummaryView_Previews: PreviewProvider {
    static var previews: some View {
        SummaryView(toDos: initialToDos)
    }
}

struct SummaryCardView: View {
    let title: String
    let count: Int
    var color: Color = .blue
    
    var body: some View {
        VStack {
            Text("\(count)")
                .font(.largeTitle).bold()
                .foregroundColor(color)
            Text(title)
                .font(.subheadline)
                .foregroundColor(.white)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color(UIColor.secondarySystemBackground).opacity(0.3))
        .cornerRadius(10)
    }
}
