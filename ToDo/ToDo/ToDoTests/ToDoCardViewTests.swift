//
//  ToDoCardViewTests.swift
//  ToDo
//
//  Created by Jakub Błażowski on 01/09/2025.
//

import Testing
import Foundation
import SwiftUI
@testable import ToDo

struct ToDoCardViewTests {

    // MARK: - Helpers

    private func makeTask(
        title: String = "Task",
        description: String? = nil,
        priority: Priority = .normal,
        planned: Date? = nil,
        deadline: Date? = nil,
        completed: Bool = false
    ) -> ToDo {
        ToDo(
            title: title,
            taskDescription: description,
            priority: priority,
            plannedDate: planned,
            deadline: deadline,
            isCompleted: completed
        )
    }

    // MARK: - plannedDateText

    @Test
    func plannedDateText_nil_returnsNone() {
        let sut = ToDoCardView(task: makeTask(planned: nil))
        #expect(sut.plannedDateText == "None")
    }

    @Test
    func plannedDateText_today_returnsToday() {
        let today = Date()
        let sut = ToDoCardView(task: makeTask(planned: today))
        #expect(sut.plannedDateText == "Today")
    }

    @Test
    func plannedDateText_tomorrow_returnsTomorrow() {
        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: Date())!
        let sut = ToDoCardView(task: makeTask(planned: tomorrow))
        #expect(sut.plannedDateText == "Tomorrow")
    }

    @Test
    func plannedDateText_otherYear_containsYear() {
        let nextYearDate = Calendar.current.date(byAdding: .year, value: 1, to: Date())!
        let nextYear = Calendar.current.component(.year, from: nextYearDate)

        let sut = ToDoCardView(task: makeTask(planned: nextYearDate))
        #expect(sut.plannedDateText.contains(String(nextYear)))
    }

    // MARK: - daysUntilDeadline

    @Test
    func daysUntilDeadline_today_zeroLeft() {
        let now = Date()
        let sut = ToDoCardView(task: makeTask(deadline: now))
        #expect(sut.daysUntilDeadline == "0 days left")
    }

    @Test
    func daysUntilDeadline_future_returnsPositiveDaysLeft() {
        let inOneDay = Date().addingTimeInterval(24 * 60 * 60)
        let sut = ToDoCardView(task: makeTask(deadline: inOneDay))
        #expect(sut.daysUntilDeadline == "1 days left")
    }

    @Test
    func daysUntilDeadline_past_returnsDaysAfterDeadline() {
        let twoDaysAgo = Date().addingTimeInterval(-2 * 24 * 60 * 60)
        let sut = ToDoCardView(task: makeTask(deadline: twoDaysAgo))
        #expect(sut.daysUntilDeadline == "2 days after the deadline")
    }
}
