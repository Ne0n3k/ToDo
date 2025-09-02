//
//  CheckBoxViewTests.swift
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
struct AddTaskFormViewTests {
    private func waitUntilSaveEnabled(_ sut: AddTaskFormView,
                                      timeout: TimeInterval = 0.6) throws -> Bool {
        let start = Date()
        while Date().timeIntervalSince(start) < timeout {
            let nav  = try sut.inspect().find(ViewType.NavigationView.self)
            let save = try nav.find(
                ViewType.Button.self,
                where: { (try? $0.labelView().text().string()) == "Save" }
            )
            if save.isDisabled() == false { return true }
            RunLoop.main.run(until: Date().addingTimeInterval(0.02))
        }
        return false
    }

    @Test
    func form_hasExpectedSectionsAndControls() throws {
        let sut = AddTaskFormView()
        ViewHosting.host(view: sut)
        defer { ViewHosting.expel() }

        let nav  = try sut.inspect().find(ViewType.NavigationView.self)
        let form = try nav.find(ViewType.Form.self)

        #expect((try? form.section(0).textField(0)) != nil)
        #expect((try? form.section(1).textField(0)) != nil)
        #expect((try? form.section(2).picker(0)) != nil)
        #expect((try? form.section(3).datePicker(0)) != nil)
        #expect((try? form.section(3).datePicker(1)) != nil)
    }
}
