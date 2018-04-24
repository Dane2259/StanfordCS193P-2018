//
//  ViewController.swift
//  Concentration
//
//  Created by Dane Osborne on 1/19/18.
//  Copyright © 2018 Dane Osborne. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // Instance variables
    @IBOutlet private weak var flipCountLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    private lazy var emojiChoices = themes[Array(themes.keys)[(themes.count).arc4Random]]!
    
    private var themes: Dictionary<String,[String]> = [
        "Halloween" : ["🦇","😱","🙀","😈","🎃","👻","🍭","🍬","🍎"],
        "Sports" : ["⚾️","🏀","⛹️‍♂️","🏈","⚽️","🥅","🏐","🏒","🤼‍♂️"],
        "Christmas" : ["🎅","🤶🏾","🎄","🇨🇽","⛄️","🏂","🎿","❄︎"],
        "Flags" : ["🇺🇸","🇨🇱","🇨🇴","🇯🇵","🇱🇷","🇬🇪","🇪🇭","🇪🇹"],
        "Technology" : ["💾","💿","📺","🎥","📷","🕹","🖥","📼"],
        "Travel" : ["🚗","🚂","✈️","🚀","🚡","🛥","⚓️","⛵️"]
    ]
    
    private var emoji = [Int:String]()
    
    var numberOfPairsOfCards: Int {
        return (cardButtons.count + 1) / 2
    }
    
    // IBAction methods
    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("Chosen card was not in card buttons")
        }
    }
    
    @IBAction func newGame(_ sender: Any) {
        game.newGame()
        emoji = [Int:String]()
        emojiChoices = themes.randomValue()!
        //emojiChoices = themes[Array(themes.keys)[themes.count.arc4Random]]! //themes[randomKey]!
        updateViewFromModel()
    }
    
    // private implementation methods
    private func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
            }
        }
        flipCountLabel.text = "Flips: \(game.flipCount)";
        scoreLabel.text = "Score: \(game.score)"
    }
    
    private func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            emoji[card.identifier] = emojiChoices.remove(at: emojiChoices.count.arc4Random)
        }
        return emoji[card.identifier] ?? "?"
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

// method to return random value from Dictionary
extension Dictionary {
    func randomValue() -> Value? {
        return self[Array(self.keys)[Int(arc4random_uniform(UInt32(self.count)))]]
    }
}

