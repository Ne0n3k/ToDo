//
//  ToDoTests.swift
//  ToDoTests
//
//  Created by Jakub Błażowski on 21/08/2025.
//

import Testing
import Foundation
import SwiftUI
import ViewInspector
@testable import ToDo

@available(*, deprecated, message: "Waiting for stability of ViewInspector")
extension ContentView: @retroactive Inspectable {}
@available(*, deprecated, message: "Waiting for stability of ViewInspector")
extension AddTaskFormView: @retroactive Inspectable {}
@available(*, deprecated, message: "Waiting for stability of ViewInspector")
extension CheckBoxView: @retroactive Inspectable {}
@available(*, deprecated, message: "Waiting for stability of ViewInspector")
extension CompletedTasksView: @retroactive Inspectable {}
@available(*, deprecated, message: "Waiting for stability of ViewInspector")
extension SummaryView: @retroactive Inspectable {}
@available(*, deprecated, message: "Waiting for stability of ViewInspector")
extension SummaryCardView: @retroactive Inspectable {}
@available(*, deprecated, message: "Waiting for stability of ViewInspector")
extension ToDoCardView: @retroactive Inspectable {}
@available(*, deprecated, message: "Waiting for stability of ViewInspector")
extension ToDoListView: @retroactive Inspectable {}

enum VIHost {
    @MainActor
    static func mount<V: View>(_ view: V) {
        ViewHosting.host(view: view)
    }
    @MainActor
    static func unmount() {
        ViewHosting.expel()
    }
}

struct ToDoTests {

    @Test func example() async throws {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
    }

}
