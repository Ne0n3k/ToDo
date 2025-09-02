//
//  ToDoModelTests.swift
//  ToDo
//
//  Created by Jakub Błażowski on 01/09/2025.
//

import Testing
import Foundation
@testable import ToDo

struct ToDoModelTests {

    @Test
    func initDefaults_areCorrect() {
        let t = ToDo(title: "Hello")
        #expect(t.title == "Hello")
        #expect(t.taskDescription == nil)
        #expect(t.priority == .normal)
        #expect(t.plannedDate == nil)
        #expect(t.deadline == nil)
        #expect(t.isCompleted == false)
    }

    @Test
    func customInit_setsAllFields() {
        let id = UUID()
        let cal = Calendar.current
        let today = cal.startOfDay(for: Date())
        let dl = cal.date(byAdding: .day, value: 3, to: today)!

        let t = ToDo(
            id: id,
            title: "Full",
            taskDescription: "Desc",
            priority: .high,
            plannedDate: today,
            deadline: dl,
            isCompleted: true
        )

        #expect(t.id == id)
        #expect(t.taskDescription == "Desc")
        #expect(t.priority == .high)
        #expect(t.plannedDate == today)
        #expect(t.deadline == dl)
        #expect(t.isCompleted == true)
    }

    @Test
    func mutation_changesPersist() {
        let t = ToDo(title: "M")
        t.isCompleted = true
        t.priority = .low
        #expect(t.isCompleted)
        #expect(t.priority == .low)
    }
}
