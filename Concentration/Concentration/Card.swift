//
//  File.swift
//  Concentration
//
//  Created by Dane Osborne on 1/20/18.
//  Copyright © 2018 Dane Osborne. All rights reserved.
//

import Foundation

struct Card {
    var isFaceUp = false
    var isMatched = false
    var identifier : Int
    
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return Card.identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
