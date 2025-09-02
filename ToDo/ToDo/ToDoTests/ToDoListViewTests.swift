//
//  ToDoListViewTests.swift
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
struct ToDoListViewTests {

    private let sample = [
        ToDo(title: "A"),
        ToDo(title: "B"),
        ToDo(title: "C")
    ]

    @Test
    func renders_allItems_asCards() throws {
        let sut = ToDoListView(toDos: sample, showGradient: false)
        ViewHosting.host(view: sut)
        defer { ViewHosting.expel() }

        let cards = try sut.inspect().findAll(ToDoCardView.self)
        #expect(cards.count == sample.count)
    }

    @Test
    func showsGradient_whenEnabled_andHidesWhenDisabled() throws {
        let withGradient = ToDoListView(toDos: sample, showGradient: true)
        ViewHosting.host(view: withGradient)
        #expect((try? withGradient.inspect().find(ViewType.LinearGradient.self)) != nil)
        ViewHosting.expel()

        let noGradient = ToDoListView(toDos: sample, showGradient: false)
        ViewHosting.host(view: noGradient)
        #expect((try? noGradient.inspect().find(ViewType.LinearGradient.self)) == nil)
        ViewHosting.expel()
    }
}
