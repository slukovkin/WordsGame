//
//  GameView.swift
//  WordsGame
//
//  Created by Sergey Lukovkin on 10.04.2024.
//

import SwiftUI

struct GameView: View {
    
    @State var inputWord = ""
    @State var isAlertPresent = false
    @State var alertText = ""
    @State var confirmPresent = false
    @Environment(\.dismiss) var dismiss
    
    var viewModel: GameViewModel
    
    var body: some View {
        ZStack {
            VStack {
                
                HStack {
                    Button {
                        confirmPresent.toggle()
                    } label: {
                        Text("Выход")
                            .multilineTextAlignment(.leading)
                            .padding(.vertical, 8.0)
                            .padding(.horizontal)
                            .font(.custom("AvenirNext-Bold", size: 18))
                            .foregroundColor(.white)
                            .background(Color("bgButton"))
                            .cornerRadius(12)
                            .padding(.horizontal)
                    }
                    Spacer()
                }
                
                Text(viewModel.word)
                    .padding()
                    .font(.custom("AvenirNext-Bold", size: 30))
                    .foregroundColor(.white)
                HStack(spacing: 12) {
                    VStack {
                        Text("\(viewModel.playerOne.score)")
                            .font(.custom("AvenirNext-Bold", size: 60))
                            .foregroundColor(.white)
                        Text("\(viewModel.playerOne.name)")
                            .font(.custom("AvenirNext-Bold", size: 20))
                            .foregroundColor(.white)
                    }
                    .padding(20)
                    .frame(width: screen.width / 2.2,
                           height: screen.width / 2.2)
                    .background(Color("FirstPlayer"))
                    .cornerRadius(12)
                    .shadow(color: viewModel.isFirstPlayer ? .red: .clear, radius: 4, x: 0, y: 0)
                    
                    VStack {
                        Text("\(viewModel.playerTwo.score)")
                            .font(.custom("AvenirNext-Bold", size: 60))
                            .foregroundColor(.white)
                        Text("\(viewModel.playerTwo.name)")
                            .font(.custom("AvenirNext-Bold", size: 20))
                            .foregroundColor(.white)
                    }
                    .padding(20)
                    .frame(width: screen.width / 2.2, height: screen.width / 2.2)
                    .background(Color("SecondPlayer"))
                    .cornerRadius(12)
                    .shadow(color: viewModel.isFirstPlayer ? .clear: .purple, radius: 4, x: 0, y: 0)
                    
                }
                InputFieldView(someWord: $inputWord, placeholder: "Введите слово")
                    .padding(.vertical)
                
                Button {
                    
                    var score = 0
                    
                    do {
                        try score = viewModel.checkScore(word: inputWord)
                    } catch WordError.repeatWord {
                        alertText = WordError.repeatWord.rawValue
                        isAlertPresent.toggle()
                    }catch WordError.wrongWord {
                        alertText = WordError.wrongWord.rawValue
                        isAlertPresent.toggle()
                    } catch WordError.littleWord {
                        alertText = WordError.littleWord.rawValue
                        isAlertPresent.toggle()
                    } catch WordError.sameWord {
                        alertText = WordError.sameWord.rawValue
                        isAlertPresent.toggle()
                    } catch {
                        alertText = WordError.unknownError.rawValue
                        isAlertPresent.toggle()
                    }
                    
                    
                    if score > 0 {
                        inputWord = ""
                    }
                    
                } label: {
                    Text("Готово!")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .font(.custom("AvenierNext-Bold", size: 22))
                        .foregroundColor(.white)
                        .background(Color("bgButton"))
                        .cornerRadius(12)
                        .padding(.horizontal)
                        .padding(.bottom)
                    
                }
                
                List {
                    ForEach(0 ..< self.viewModel.words.count, id: \.description) { item in
                        WordCell(word: self.viewModel.words[item])
                            .background(item % 2 == 0 ? Color("FirstPlayer"): Color("SecondPlayer"))
                            .listRowInsets(EdgeInsets())
                    }
                    
                }.listStyle(.plain)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                
            }
            .alert(alertText, isPresented: $isAlertPresent) {
                Text("OK")
            }
            .confirmationDialog("Вы хотите завершить игру?", isPresented: $confirmPresent, titleVisibility: .visible) {
                Button(role: .destructive) {
                    self.dismiss()
                } label: {
                    Text("Да")
                }
                
                Button(role: .cancel) {
                    //
                } label: {
                    Text("Нет")
                }
            }
        }.background(Image("background"))
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(viewModel: GameViewModel(playerOne: Player(name: "Ivan"), playerTwo: Player(name: "Александр"), word: "Магнитотерапия"))
    }
}
