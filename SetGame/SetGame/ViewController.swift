//
//  ViewController.swift
//  SetGame
//
//  Created by Dane Osborne on 2/28/18.
//  Copyright © 2018 Dane Osborne. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private var game = SetGame()
    @IBOutlet var cardButtons: [UIButton]!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var dealThreeMoreCards: UIButton!
    private var buttonIsVisible = [true,true,true,true,true,true,true,true,true,true,true,true,
                                  false,false,false,false,false,false,false,false,false,false,false,false]
    private enum Symbols: String, CustomStringConvertible {
        case triangle = "▲"
        case circle = "●"
        case square = "■"
        var description: String { return rawValue }
        static let all: [Symbols] = [.triangle,.circle,.square]
    }
    var attributes = [NSAttributedStringKey.foregroundColor:UIColor.white,
                      NSAttributedStringKey.strokeWidth:0.0,
                      NSAttributedStringKey.strokeColor:UIColor.white] as [NSAttributedStringKey : Any]
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardIndex = cardButtons.index(of: sender) {
            if buttonIsVisible[cardButtons.index(of: sender)!] {
                game.chooseCard(atIndex: cardIndex)
                updateViewFromModel()
            }
        }
    }
    
    private func updateViewFromModel() {        
        for index in cardButtons.indices {
            // If no more cards are in the deck and the card has been matched, mark the card as not visible
            if game.deckOfCards.deck.count == 0, index < game.cardsInPlay.count, game.matchedCards.contains(game.cardsInPlay[index]), game.selectedCards.count < 3 {
                buttonIsVisible[index] = false
            }
            if buttonIsVisible[index] {
                //Set Card Button SubView Display
                let card = game.cardsInPlay[index]
                attributes.updateValue(0.0, forKey: NSAttributedStringKey.strokeWidth)
                setColor(withCard: card)
                setShading(withCard: card)
                cardButtons[index].backgroundColor = UIColor.white
                cardButtons[index].layer.borderColor = game.selectedCards.contains(card) ? setButtonBorderColor() : UIColor.clear.cgColor
                cardButtons[index].layer.borderWidth = 3.0
                cardButtons[index].setAttributedTitle(setButtonLabel(withCard: card), for: .normal)
            } else {
                cardButtons[index].layer.borderWidth = 3.0
                cardButtons[index].layer.borderColor = UIColor.clear.cgColor
                cardButtons[index].backgroundColor = UIColor.clear
                cardButtons[index].setAttributedTitle(NSAttributedString(string: ""), for: .normal)
                cardButtons[index].setTitle("", for: .normal)
            }
        }
        
        scoreLabel.text = "Score: \(game.score)"
    }
    
    @IBAction func newGame(_ sender: UIButton) {
        game.newGame()
        buttonIsVisible = [true,true,true,true,true,true,true,true,true,true,true,true,
                    false,false,false,false,false,false,false,false,false,false,false,false]
        dealThreeMoreCards.isEnabled = true
        updateViewFromModel()
    }
    
    @IBAction func dealThreeMoreCards(_ sender: UIButton) {
        var count = 0
        for index in 0 ..< buttonIsVisible.count {
            if !buttonIsVisible[index], count < 3 {
                buttonIsVisible[index] = true
                count += 1
            }
        }
        if !buttonIsVisible.contains(false) || game.deckOfCards.deck.count == 0 {
            sender.isEnabled = false
        }
        game.addThreeCards()
        game.score -= 5
        updateViewFromModel()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        game.newGame()
        updateViewFromModel()
    }
    
    private func setButtonBorderColor() -> CGColor {
        switch game.selectedCards.count {
        case 0, 1, 2:
            return UIColor.black.cgColor
        case 3:
            return (game.isMatch ? UIColor.green.cgColor : UIColor.red.cgColor)
        default:
            return UIColor.clear.cgColor
        }
    }
    
    /**
     Sets the color of the NSAttributedText that populates each button's label.
     
     - parameter card: The SetCard for the instance of the button being touched.
     */
    private func setColor(withCard card: SetCard) {
        switch card.color {
        case .color1:
            attributes.updateValue(UIColor.red, forKey: .foregroundColor)
        case .color2:
            attributes.updateValue(UIColor.green, forKey: .foregroundColor)
        case .color3:
            attributes.updateValue(UIColor.purple, forKey: .foregroundColor)
        }
    }
    
    /**
     Sets the "shading" of the NSAttributedText that populates each button's label.
     
     - parameter card: The SetCard for the instance of the button being touched.
     */
    private func setShading(withCard card: SetCard) {
        switch card.shading {
        case .shade2:
            if let stripedShading = attributes[NSAttributedStringKey.foregroundColor] as? UIColor {
                attributes.updateValue(stripedShading.withAlphaComponent(0.15), forKey: NSAttributedStringKey.foregroundColor)
            }
        case .shade3:
            if let _ = attributes[NSAttributedStringKey.strokeWidth] as? NSNumber  {
                attributes.updateValue(attributes[NSAttributedStringKey.foregroundColor]!, forKey: NSAttributedStringKey.strokeColor)
                attributes.updateValue(5.0, forKey: NSAttributedStringKey.strokeWidth)
            }
        default: break
        }
    }
    
    /**
     Sets the symbol and number of symbols of the NSAttributedText that populates each button's label.
     
     - parameter card: The SetCard for the instance of the button being touched.
     */
    private func setButtonLabel(withCard card: SetCard) -> NSAttributedString{
        var symbol = ""
        var buttonTextLabel = NSAttributedString(string: "")
        
        switch card.shape {
        case .shape1:
            symbol = Symbols.circle.description
        case .shape2:
            symbol = Symbols.triangle.description
        case .shape3:
            symbol = Symbols.square.description
        }
        
        switch card.numberOfShapes {
        case .one:
            buttonTextLabel = NSAttributedString(string: symbol, attributes: attributes)
        case .two:
            buttonTextLabel = NSAttributedString(string: symbol+symbol, attributes: attributes)
        case .three:
            buttonTextLabel = NSAttributedString(string: symbol+symbol+symbol, attributes: attributes)
        }
        return buttonTextLabel
    }
}
