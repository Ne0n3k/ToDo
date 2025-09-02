//
//  SummaryViewTests.swift
//  ToDo
//
//  Created by Jakub Błażowski on 01/09/2025.
//

import Testing
import Foundation
import SwiftUI
import ViewInspector
@testable import ToDo

@MainActor
struct SummaryViewTests {

    private let cal = Calendar.current
    private var now: Date { Date() }

    @Test
    func summaryCards_countsAreCorrect() throws {
        let plannedSoon = now.addingTimeInterval(60)

        let up1 = ToDo(
            title: "UP1",
            priority: .high,
            plannedDate: plannedSoon,
            deadline: cal.date(byAdding: .day, value: 1, to: now)
        )
        let up2 = ToDo(
            title: "UP2",
            priority: .normal,
            plannedDate: plannedSoon,
            deadline: cal.date(byAdding: .day, value: 2, to: now)
        )
        let ov1 = ToDo(
            title: "OV1",
            priority: .low,
            plannedDate: cal.date(byAdding: .day, value: -1, to: now),
            deadline: cal.date(byAdding: .day, value: -1, to: now)
        )
        let done = ToDo(title: "DONE", isCompleted: true)

        let sut = SummaryView(toDos: [up1, up2, ov1, done])
        ViewHosting.host(view: sut); defer { ViewHosting.expel() }

        let cards = try sut.inspect().findAll(SummaryCardView.self)
        var counts: [String:Int] = [:]
        for c in cards {
            let v = try c.actualView()
            counts[v.title] = v.count
        }

        #expect(counts["upcoming"] == 2)   // up1, up2
        #expect(counts["overdue"] == 1)    // ov1
        #expect(counts["completed"] == 1)  // done
        #expect(counts["high"] == 1)       // up1
        #expect(counts["normal"] == 1)     // up2
        #expect(counts["low"] == 1)        // ov1
    }

    @Test
    func list_order_isUpcomingThenOverdue_sortedByDeadlineAscending() throws {
        let plannedSoon = now.addingTimeInterval(60)

        // Upcoming
        let upFast = ToDo(
            title: "UP_FAST",
            plannedDate: plannedSoon,
            deadline: cal.date(byAdding: .day, value: 1, to: now)
        )
        let upSlow = ToDo(
            title: "UP_SLOW",
            plannedDate: plannedSoon,
            deadline: cal.date(byAdding: .day, value: 3, to: now)
        )

        // Overdue
        let ovOld = ToDo(
            title: "OV_OLD",
            plannedDate: cal.date(byAdding: .day, value: -2, to: now),
            deadline: cal.date(byAdding: .day, value: -2, to: now)
        )
        let ovNew = ToDo(
            title: "OV_NEW",
            plannedDate: cal.date(byAdding: .day, value: -1, to: now),
            deadline: cal.date(byAdding: .day, value: -1, to: now)
        )

        let sut = SummaryView(toDos: [ovNew, upSlow, ovOld, upFast]) // mieszamy kolejność wejściową
        ViewHosting.host(view: sut); defer { ViewHosting.expel() }

        let cards = try sut.inspect().findAll(ToDoCardView.self)
        let titles = try cards.map { try $0.actualView().task.title }

        // Najpierw upcoming (rosnąco po deadline), potem overdue (rosnąco po deadline)
        #expect(titles == ["UP_FAST", "UP_SLOW", "OV_OLD", "OV_NEW"])
    }
}
