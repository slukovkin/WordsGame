//
//  ContentView.swift
//  WordsGame
//
//  Created by Sergey Lukovkin on 10.04.2024.
//

import SwiftUI

struct StartView: View {
    
    @State var bigWord = ""
    @State var player1 = ""
    @State var player2 = ""
    
    @State var isShowGameScreen = false
    
    var body: some View {
        ZStack {
            VStack {
                TitleView(text: "Words Games")
                    .padding(.bottom, 30)
                
                InputFieldView(someWord: $bigWord, placeholder: "Введите большое слово")
                    .padding(.bottom, 30)
                
                InputFieldView(someWord: $player1, placeholder: "Введите первого игрока")
                
                InputFieldView(someWord: $player2, placeholder: "Введите второго игрока")
                
                Button {
                    isShowGameScreen.toggle()
                } label: {
                    Text("Start")
                        .padding()
                        .frame(width: 310)
                        .font(.custom("AvenirNext-Bold", size: 30))
                        .foregroundColor(Color.white)
                        .background(Color("FirstPlayer"))
                        .cornerRadius(16)
                        .padding(.vertical)
                }
            
            }
        } .background(Image("background"))
            .fullScreenCover(isPresented: $isShowGameScreen) {
                GameView()
            }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            StartView()
        }
    }
}
