//
//  ToDoListView.swift
//  ToDo
//
//  Created by Jakub Błażowski on 22/08/2025.
//

import SwiftUI

struct ToDoListView: View {
    let toDos: [ToDo]
    var showGradient: Bool = true
    @Environment(\.modelContext) private var context
    
    var body: some View {
        ZStack {
            Group {
                if showGradient {
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color("gradientStartColor"),
                            Color("gradientEndColor")
                        ]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                } else {
                    Color.clear
                }
            }
            .edgesIgnoringSafeArea(.all)
            
            ScrollView {
                VStack {
                    ForEach(toDos) { task in
                        ToDoCardView(task: task)
                            .transition(.move(edge: .trailing))
                    }
                }
            }
            .animation(.easeInOut, value: toDos)
            .background(Color.clear)
        }
    }
}

struct ToDoListView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ToDoListView(toDos: initialToDos, showGradient: true)
                .previewDisplayName("Gradient")
            ToDoListView(toDos: initialToDos, showGradient: false)
                .previewDisplayName("Solid Color")
        }
    }
}
