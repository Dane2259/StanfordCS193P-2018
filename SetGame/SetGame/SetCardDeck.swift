//
//  SetCardDeck.swift
//  SetGame
//
//  Created by Dane Osborne on 3/7/18.
//  Copyright © 2018 Dane Osborne. All rights reserved.
//

import Foundation

struct SetCardDeck {
    var deck = [SetCard]()
    
    init() {
        for color in SetCard.Color.all {
            for number in SetCard.NumberOfShapes.all {
                for shape in SetCard.Shape.all {
                    for shading in SetCard.Shading.all {
                        deck.append(SetCard(color: color, shape: shape, numberOfShapes: number, shading: shading))
                    }
                }
            }
        }
    }
    
    /**
     Returns a random card from the deck and removes this card from the deck.
     
     - returns: Random card from the SetCardDeck instance.
     */
    mutating func randomCardInDeck() -> SetCard {
        let indexOfRandomCard = deck.count.arc4Random
        assert(indexOfRandomCard < deck.count, "IndexOfRandomCard: \(indexOfRandomCard) is greater than number of cards in the deck. \nNumber of cards in the deck: \(deck.count)")
        let randomCard = deck.remove(at: indexOfRandomCard)
        //removeCardFromDeck(card: randomCard, indexInDeck: indexOfRandomCard)
        return randomCard
    }
}

// Returns random value from 1 to self
extension Int {
    var arc4Random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(self)))
        } else {
            return 0
        }
    }
}
