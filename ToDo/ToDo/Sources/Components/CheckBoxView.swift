//
//  CheckBoxView.swift
//  ToDo
//
//  Created by Jakub Błażowski on 22/08/2025.
//

import SwiftUI

struct CheckBoxView: View {
    @Binding var isChecked: Bool

    var body: some View {
        Image(systemName: isChecked ? "checkmark.square.fill" : "square")
            .resizable()
            .frame(width: 24, height: 24)
            .foregroundColor(isChecked ? .green : .gray)
            .onTapGesture {
                withAnimation(.easeInOut) {
                    isChecked.toggle()
                }
            }
    }
}
