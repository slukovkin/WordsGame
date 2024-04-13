//
//  GameViewModel.swift
//  WordsGame
//
//  Created by Sergey Lukovkin on 11.04.2024.
//

import Foundation

enum WordError: String, Error {
    case sameWord = "Составленное слово не должно быть исходным словом"
    case wrongWord = "Слово не может быть составлено"
    case littleWord = "Слишком короткое слово"
    case repeatWord = "Придумай другое слово. Такое уже было придумано"
    case unknownError = "Неизвестная ошибка"
}

class GameViewModel : ObservableObject {
    @Published var playerOne: Player
    @Published var playerTwo: Player
    @Published var words = [String]()
    
    let word: String
    var isFirstPlayer = true
    
    
    init(playerOne: Player, playerTwo: Player, word: String) {
        self.playerOne = playerOne
        self.playerTwo = playerTwo
        self.word = word.uppercased()
    }
    
    func validate(word: String) throws {
        let word = word.uppercased()
        
        guard word != self.word else {
            throw WordError.sameWord
        }
        
        guard word.count > 1 else {
            throw WordError.littleWord
        }
        
        guard !words.contains(word) else {
            throw WordError.repeatWord
        }
        return
    }
    
    func wordToArrayCharacters(word: String) -> [Character] {
        var characters = [Character] ()
        
        for char in word.uppercased() {
            characters.append(char)
        }
        
        return characters
    }
    
    func checkScore(word: String) throws -> Int {
        
        do {
            try self.validate(word: word)
        } catch {
            throw error
        }
        
        var bigWordArray = self.wordToArrayCharacters(word: self.word)
        let smallWordArray = self.wordToArrayCharacters(word: word)
        var result = ""
        
        for char in smallWordArray {
            if bigWordArray.contains(char) {
                result.append(char)
                
                var idx = 0
                while bigWordArray[idx] != char {
                    idx += 1
                }
                bigWordArray.remove(at: idx)
                
            } else {
                throw WordError.wrongWord
            }
        }
        
        guard result == word.uppercased() else {
            throw WordError.unknownError
        }
        
        words.insert(result, at: 0)
        
        if isFirstPlayer {
            self.playerOne.score += result.count
        } else {
            self.playerTwo.score += result.count
        }
        
        isFirstPlayer.toggle()
        
        return result.count
    }
    
}
