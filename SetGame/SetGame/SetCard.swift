//
//  SetCard.swift
//  SetGame
//
//  Created by Dane Osborne on 2/28/18.
//  Copyright © 2018 Dane Osborne. All rights reserved.
//

import Foundation

struct SetCard: CustomStringConvertible {
    private(set) var color: Color
    private(set) var shape: Shape
    private(set) var numberOfShapes: NumberOfShapes
    private(set) var shading: Shading
    var description: String { return "Card: \(self.color.description), \(self.shape.description), \(self.numberOfShapes.description), \(self.shading.description)" }
    
    enum Color: String, CustomStringConvertible {
        case color1 = "color1"
        case color2 = "color2"
        case color3 = "color3"
        var description: String { return rawValue }
        static let all: [SetCard.Color] = [.color1,.color2,.color3]
    }
    
    enum Shape: String, CustomStringConvertible {
        case shape1 = "shape1"
        case shape2 = "shape2"
        case shape3 = "shape3"
        var description: String { return rawValue }
        static let all: [SetCard.Shape] = [.shape1,.shape2,.shape3]
    }
    
    enum NumberOfShapes: Int, CustomStringConvertible {
        case one = 1
        case two = 2
        case three = 3
        var description: String { return String(rawValue) }
        static let all: [SetCard.NumberOfShapes] = [.one,.two,.three]
    }
    
    enum Shading: String, CustomStringConvertible {
        case shade1 = "shade1"
        case shade2 = "shade2"
        case shade3 = "shade3"
        var description: String { return String (rawValue) }
        static let all: [SetCard.Shading] = [.shade1,.shade2,.shade3]
    }
    
    init(color withColor: Color,
         shape withShape: Shape,
         numberOfShapes withNumberOfShapes: NumberOfShapes,
         shading withShading: Shading) {
        color = withColor
        shape = withShape
        numberOfShapes = withNumberOfShapes
        shading = withShading
    }
    
    /**
     Tests whether the given three cards are a "Set." This should always be called on an instance of a SetCard (self),
     which is the first card in the comparison.
     
     - parameter secodCard: the second card to test.
     - parameter thirdCard: the third card to test.
     - returns: True if the three cards are a "Set" and otherwise false.
    **/
    func setMatch(secondCard: SetCard, thirdCard: SetCard) -> Bool {
        return
            (self.color == secondCard.color && secondCard.color == thirdCard.color) ||
            (self.shape == secondCard.shape && secondCard.shape == thirdCard.shape) ||
            (self.shading == secondCard.shading && secondCard.shading == thirdCard.shading) ||
            (self.numberOfShapes == secondCard.numberOfShapes && secondCard.numberOfShapes == thirdCard.numberOfShapes)
    }
}

extension SetCard: Equatable {
    static func == (lhs: SetCard, rhs: SetCard) -> Bool {
        return
            lhs.color == rhs.color &&
            lhs.numberOfShapes == rhs.numberOfShapes &&
            lhs.shape == rhs.shape &&
            lhs.shading == rhs.shading
    }
}

