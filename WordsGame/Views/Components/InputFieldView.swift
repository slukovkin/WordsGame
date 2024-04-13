//
//  InputFieldView.swift
//  WordsGame
//
//  Created by Sergey Lukovkin on 10.04.2024.
//

import SwiftUI

struct InputFieldView: View {
    
    @State var someWord: Binding<String>
    var placeholder: String
    
    var body: some View {
        TextField(placeholder, text: someWord)
            .padding()
            .font(.title2)
            .background(.white)
            .cornerRadius(16)
            .padding(.horizontal)
    }
}
