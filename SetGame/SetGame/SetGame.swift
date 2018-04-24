//
//  SetGame.swift
//  SetGame
//
//  Created by Dane Osborne on 2/28/18.
//  Copyright © 2018 Dane Osborne. All rights reserved.
//

import Foundation

class SetGame {
    var deckOfCards = SetCardDeck()
    var cardsInPlay = [SetCard]()
    var selectedCards = [SetCard]()
    var matchedCards = [SetCard]()
    var isMatch = false
    var score = 0
    let maximumNumberOfCards = 24
    
    func chooseCard(atIndex index: Int) {
        if !selectedCards.contains(cardsInPlay[index]) {
            switch selectedCards.count {
            case 0,1:
                selectedCards.append(cardsInPlay[index])
            case 2:
                selectedCards.append(cardsInPlay[index])
                isMatch = (selectedCards.first?.setMatch(secondCard: selectedCards[1], thirdCard: selectedCards[2]))!
                if isMatch {
                    score += 5
                    for selectedCard in selectedCards {
                        matchedCards.append(selectedCard)
                    }
                } else {
                    score -= 10
                }
            case 3:
                if isMatch {
                    for card in selectedCards {
                        if deckOfCards.deck.count > 0 {
                            cardsInPlay[cardsInPlay.index(of: card)!] = deckOfCards.randomCardInDeck()
                        }
                    }
                }
                
                selectedCards.removeAll()
                selectedCards.append(cardsInPlay[index])
            default:
                break
            }
        }
        else {
            selectedCards.remove(at: selectedCards.index(of: cardsInPlay[index])!)
            score -= 5
        }
    }
    
    func addThreeCards() {
        for _ in 0..<3 {
            if cardsInPlay.count < maximumNumberOfCards, deckOfCards.deck.count != 0 {
                cardsInPlay.append(deckOfCards.randomCardInDeck())
            }
        }
        //print("CardsInPlayCount: \(cardsInPlay.count)")
    }
    
    func newGame() {
        deckOfCards = SetCardDeck()
        cardsInPlay = [SetCard]()
        selectedCards = [SetCard]()
        matchedCards = [SetCard]()
        score = 0
        isMatch = false
        for _ in 0..<(maximumNumberOfCards / 2) {
            cardsInPlay.append(deckOfCards.randomCardInDeck())
        }
    }
    
//    private func matchCards(indexAt index: Int) {
//        for card in selectedCards {
//            matchedCards.append(card)
//            if deckOfCards.deck.count > 0 {
//                cardsInPlay.insert(deckOfCards.randomCardInDeck(), at: index)
//            }
//        }
//    }
}
