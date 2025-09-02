//
//  CompletedTasksViewTests.swift
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
struct CompletedTasksViewTests {

    @Test
    func renders_onlyCompletedTasks() throws {
        let items = [
            ToDo(title: "Done 1", isCompleted: true),
            ToDo(title: "Done 2", isCompleted: true),
            ToDo(title: "Active", isCompleted: false)
        ]

        let sut = CompletedTasksView(toDos: items)
        ViewHosting.host(view: sut)
        defer { ViewHosting.expel() }

        let cards = try sut.inspect().findAll(ToDoCardView.self)
        #expect(cards.count == 2)

        let titles = try cards.map { try $0.actualView().task.title }
        #expect(titles.contains("Done 1"))
        #expect(titles.contains("Done 2"))
        #expect(titles.contains("Active") == false)
    }
}
