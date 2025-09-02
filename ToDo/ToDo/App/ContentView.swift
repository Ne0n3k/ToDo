//
//  ContentView.swift
//  ToDo
//
//  Created by Jakub Błażowski on 21/08/2025.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Query(
        sort: [SortDescriptor(\ToDo.deadline, order: .forward)]
    ) var toDos: [ToDo]

    @Environment(\.modelContext) private var context
    @State private var isPresentingAddForm = false

    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color("gradientStartColor"),
                        Color("gradientEndColor")
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                TabView {
                    SummaryView(toDos: toDos)
                        .padding(.top, 20)
                        .tabItem {
                            Label("Summary", systemImage: "chart.bar")
                        }

                    ToDoListView(toDos: toDos.filter { !$0.isCompleted }, showGradient: true)
                        .tabItem {
                            Label("All tasks", systemImage: "list.bullet")
                        }

                    ToDoListView(
                        toDos: toDos.filter {
                            !$0.isCompleted &&
                            ($0.plannedDate ?? Date()) >= Date() &&
                            ($0.deadline ?? Date()) > Date()
                        }
                    )
                    .tabItem {
                        Label("Planned", systemImage: "calendar")
                    }

                    ToDoListView(
                        toDos: toDos.filter {
                            !$0.isCompleted &&
                            ($0.deadline ?? Date()) < Date()
                        },
                        showGradient: true
                    )
                    .tabItem {
                        Label("Overdue", systemImage: "exclamationmark.triangle")
                    }

                    CompletedTasksView(toDos: toDos)
                        .tabItem {
                            Label("Completed", systemImage: "checkmark.circle")
                        }
                }
                .accentColor(.red)
                .navigationBarTitleDisplayMode(.inline)

                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button {
                            isPresentingAddForm = true
                        } label: {
                            Image(systemName: "plus")
                                .foregroundColor(.white)
                                .frame(width: 28, height: 28)
                                .background(
                                    Circle()
                                        .fill(Color.red.opacity(0.8))
                                        .frame(width: 28, height: 28)
                                )
                        }
                        .accessibilityIdentifier("addTaskButton")
                        .padding(.trailing, 27)
                        .padding(.bottom, 72)
                    }
                }
            }
            .fullScreenCover(isPresented: $isPresentingAddForm) {
                AddTaskFormView()
            }
        }
        .navigationViewStyle(.stack)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .modelContainer(for: ToDo.self, inMemory: true)
    }
}
