//
//  Concentration.swift
//  Concentration
//
//  Created by Dane Osborne on 1/20/18.
//  Copyright © 2018 Dane Osborne. All rights reserved.
//

import Foundation

class Concentration {
    private(set) var cards = [Card]()
    private(set) var flipCount = 0
    private var chosenCards = [Int]()
    private(set) var score = 0
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index
                    } else {
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not in the cards")
        if !cards[index].isMatched {
            flipCount += 1
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 2
                } else {
                    if chosenCards.contains(index) {
                        score -= 1
                    }
                    if chosenCards.contains(matchIndex) {
                        score -= 1
                    }
                    chosenCards.insert(index, at: chosenCards.count)
                    chosenCards.insert(matchIndex, at: chosenCards.count)
                }
                cards[index].isFaceUp = true
            } else {
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards): you must have at least one pair of cards")
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        shuffleCards()
    }
    
    func newGame() {
        flipCount = 0
        score = 0
        for index in cards.indices {
            cards[index].isFaceUp = false
            cards[index].isMatched = false
        }
        shuffleCards()
    }
    
    private func shuffleCards() {
        var shuffledCards = [Card]()
        for index in cards.indices {
            let card = cards.remove(at: cards.count.arc4Random)
            shuffledCards.insert(card, at: index)
        }
        cards = shuffledCards
    }
}
