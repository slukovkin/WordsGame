//
//  TitleView.swift
//  WordsGame
//
//  Created by Sergey Lukovkin on 10.04.2024.
//

import SwiftUI

struct TitleView: View {
    
    @State var text: String
    
    var body: some View {
        Text(text)
            .padding()
            .font(.custom("AvenirNext-Bold", size: 42))
            .background(Color("FirstPlayer"))
            .cornerRadius(16)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
    }
}

struct TitleView_Previews: PreviewProvider {
    static var previews: some View {
        TitleView(text: "Магнитотерапия")
    }
}
