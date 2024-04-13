//
//  WordCell.swift
//  WordsGame
//
//  Created by Sergey Lukovkin on 13.04.2024.
//

import SwiftUI

struct WordCell: View {
    
    let word: String
    
    var body: some View {
        HStack {
            Text(word)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            Text("\(word.count)")
                .foregroundColor(.white)
                .padding()
        }.padding()
            .font(.custom("Avenier-bold", size: 22))
    }
}

struct WordCell_Previews: PreviewProvider {
    static var previews: some View {
        WordCell(word: "Магнит")
    }
}
