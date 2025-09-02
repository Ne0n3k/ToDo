//
//  ContentFilteringTests.swift
//  ToDo
//
//  Created by Jakub Błażowski on 01/09/2025.
//

import Testing
@testable import ToDo
import Foundation

struct ContentFilteringTests {
    private let cal = Calendar.current
    private var now: Date { cal.startOfDay(for: Date()) }
    private var yesterday: Date { cal.date(byAdding: .day, value: -1, to: now)! }
    private var today: Date { now }
    private var tomorrow: Date { cal.date(byAdding: .day, value: 1, to: now)! }

    private func make(
        title: String,
        completed: Bool = false,
        planned: Date? = nil,
        deadline: Date? = nil
    ) -> ToDo {
        ToDo(title: title, priority: .normal, plannedDate: planned, deadline: deadline, isCompleted: completed)
    }

    private func allTasks(_ t: ToDo, at now: Date) -> Bool {
        !t.isCompleted
    }
    private func planned(_ t: ToDo, at now: Date) -> Bool {
        !t.isCompleted
        && (t.plannedDate ?? now) >= now
        && (t.deadline ?? now) > now
    }
    private func overdue(_ t: ToDo, at now: Date) -> Bool {
        !t.isCompleted && (t.deadline ?? Date.distantFuture) < now
    }
    private func completed(_ t: ToDo, at _: Date) -> Bool {
        t.isCompleted
    }

    @Test
    func filters_returnExpectedSets() {
        let items: [ToDo] = [
            make(title: "A_active_upcoming", completed: false, planned: today,   deadline: tomorrow),
            make(title: "B_active_overdue",  completed: false, planned: yesterday, deadline: yesterday),
            make(title: "C_completed",        completed: true,  planned: today,   deadline: tomorrow),
            make(title: "D_noDates_active",   completed: false, planned: nil,     deadline: nil),
        ]

        let all = items.filter { allTasks($0, at: now) }
        #expect(all.map(\.title).sorted() == ["A_active_upcoming", "B_active_overdue", "D_noDates_active"].sorted())

        let plan = items.filter { planned($0, at: now) }
        #expect(plan.map(\.title) == ["A_active_upcoming"])

        let late = items.filter { overdue($0, at: now) }
        #expect(late.map(\.title) == ["B_active_overdue"])

        let done = items.filter { completed($0, at: now) }
        #expect(done.map(\.title) == ["C_completed"])
    }
}
