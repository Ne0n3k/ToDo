//
//  ContentView.swift
//  ToDo
//
//  Created by Jakub Błażowski on 21/08/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
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

            VStack(spacing: 12) {
                Image(systemName: "checkmark.circle")
                    .font(.system(size: 48))

                Text("ToDo")
                    .font(.largeTitle).bold()

                Text("Project skeleton done")
                    .foregroundColor(Color("TextColorDark"))
            }
            .padding(24)
            .background(Color("backgroundFrameColor"))
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .shadow(radius: 6)
        }
    }
}

#Preview {
    ContentView()
}
