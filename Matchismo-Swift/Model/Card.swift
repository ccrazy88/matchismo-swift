//
//  Card.swift
//  Matchismo-Swift
//
//  Copyright (c) 2014 Chrisna Aing. All rights reserved.
//

import Foundation

class Card: NSObject {

    // MARK: -
    // MARK: Public Properties

    let contents: String
    var chosen: Bool
    var matched: Bool

    // MARK: -
    // MARK: Initializers

    init(contents: String, chosen: Bool = false, matched: Bool = false) {
        self.contents = contents
        self.chosen = chosen
        self.matched = matched
        super.init()
    }

    // MARK: -
    // MARK: Card Matching

    func match(otherCards: [Card]) -> Int {
        var score = 0
        for card in otherCards {
            if contents == card.contents {
                score = 1
            }
        }
        return score
    }
    
}
