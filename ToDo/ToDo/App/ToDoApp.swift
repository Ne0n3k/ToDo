//
//  ToDoApp.swift
//  ToDo
//
//  Created by Jakub Błażowski on 21/08/2025.
//

import SwiftUI
import SwiftData

@main
struct ToDoApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().modelContainer(for: ToDo.self)
        }
    }
}
