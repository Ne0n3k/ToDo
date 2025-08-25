//
//  InitialData.swift
//  ToDo
//
//  Created by Jakub Błażowski on 25/08/2025.
//

import Foundation

var initialToDos: [ToDo] = [
    ToDo(title: "Zadanie 1", taskDescription: "Opis 1", priority: .high, plannedDate: Date(), deadline: Date().addingTimeInterval(86400)),
    ToDo(title: "Zadanie 2", taskDescription: "Opis 2", priority: .normal, plannedDate: Date().addingTimeInterval(-86400), deadline: Date().addingTimeInterval(-172800)),
    ToDo(title: "Zadanie 3", taskDescription: "Opis 3", priority: .normal, plannedDate: Date().addingTimeInterval(100000), deadline: Date().addingTimeInterval(200800)),
    ToDo(title: "Zadanie 4", taskDescription: "Opis 4", priority: .normal, plannedDate: Date().addingTimeInterval(864000), deadline: Date().addingTimeInterval(1728000)),
    ToDo(title: "Zadanie 5", taskDescription: "Opis 5", priority: .normal, plannedDate: Date().addingTimeInterval(150000), deadline: Date().addingTimeInterval(300800)),
    ToDo(title: "Zadanie 6", taskDescription: "Opis 6", priority: .normal, plannedDate: Date().addingTimeInterval(300000), deadline: Date().addingTimeInterval(600800)),
    ToDo(title: "Zadanie 7", taskDescription: "Opis 7", priority: .normal, plannedDate: Date().addingTimeInterval(450000), deadline: Date().addingTimeInterval(900800))
]
