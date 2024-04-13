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
                TitleView(text: "Words Game")
                    .padding(.bottom, 30)
                
                InputFieldView(someWord: $bigWord, placeholder: "Введите длинное слово")
                    .padding(.bottom, 30)
                
                InputFieldView(someWord: $player1, placeholder: "Введите первого игрока")
                
                InputFieldView(someWord: $player2, placeholder: "Введите второго игрока")
                
                Button {
                    if bigWord.count >= 7 {
                        isShowGameScreen.toggle()
                    }
                } label: {
                    Text("Start")
                        .padding()
                        .frame(width: screen.width - 30)
                        .font(.custom("AvenirNext-Bold", size: 24))
                        .foregroundColor(Color.white)
                        .background(Color("FirstPlayer"))
                        .cornerRadius(16)
                        .padding(.vertical)
                }
                
            }
        } .background(Image("background"))
            .fullScreenCover(isPresented: $isShowGameScreen) {
                
                let playerOne = Player(name: player1 == "" ? "Игрок 1": player1)
                let playerTwo = Player(name: player2 == "" ? "Игрок 2": player2)
                
                let gemeViewModel = GameViewModel(playerOne: playerOne, playerTwo: playerTwo, word: bigWord)
                
                GameView(viewModel: gemeViewModel)
            }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            StartView()
        }
    }
}
