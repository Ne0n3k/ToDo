//
//  CheckBoxViewTests.swift
//  ToDo
//
//  Created by Jakub Błażowski on 01/09/2025.
//

import Testing
import SwiftUI
@testable import ToDo

struct CheckBoxViewTests {

    @Test
    func bindingReflectsExternalChanges() {
        var value = false
        let binding = Binding<Bool>(
            get: { value },
            set: { value = $0 }
        )

        _ = CheckBoxView(isChecked: binding)

        #expect(value == false)
        binding.wrappedValue = true
        #expect(value == true)
    }

    @Test
    func initialStateIsUsedByView() {
        var value = true
        let binding = Binding<Bool>(
            get: { value },
            set: { value = $0 }
        )

        let view = CheckBoxView(isChecked: binding)
        #expect(view.isChecked == true)
    }
}
