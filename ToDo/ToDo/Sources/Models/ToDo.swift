//
//  ToDo.swift
//  ToDo
//
//  Created by Jakub Błażowski on 22/08/2025.
//

import Foundation
import SwiftData

public enum Priority: String, CaseIterable, Codable {
    case high = "High"
    case normal = "Normal"
    case low = "Low"
}

@Model
public class ToDo {
    public var id: UUID
    public var title: String
    public var taskDescription: String?
    public var priority: Priority
    public var plannedDate: Date?
    public var deadline: Date?
    public var isCompleted: Bool

    public init(
        id: UUID = UUID(),
        title: String,
        taskDescription: String? = nil,
        priority: Priority = .normal,
        plannedDate: Date? = nil,
        deadline: Date? = nil,
        isCompleted: Bool = false
    ) {
        self.id = id
        self.title = title
        self.taskDescription = taskDescription
        self.priority = priority
        self.plannedDate = plannedDate
        self.deadline = deadline
        self.isCompleted = isCompleted
    }
}
