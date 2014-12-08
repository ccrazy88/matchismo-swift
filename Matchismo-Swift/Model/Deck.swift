//
//  Deck.swift
//  Matchismo-Swift
//
//  Created by Chrisna Aing on 10/26/14.
//  Copyright (c) 2014 Chrisna Aing. All rights reserved.
//

import Foundation

class Deck: NSObject {

    // MARK: -
    // MARK: Private Properties
    
    private lazy var cards = [Card]()

    // MARK: -
    // MARK: Deck Manipulation

    func addCard(card: Card, atTop: Bool = false) {
        if atTop {
            cards.insert(card, atIndex: 0)
        } else {
            cards.append(card)
        }
    }

    func drawRandomCard() -> Card? {
        var randomCard: Card?
        if !cards.isEmpty {
            let index = Int(arc4random_uniform(UInt32(cards.count)))
            randomCard = cards[index]
            cards.removeAtIndex(index)
        }
        return randomCard
    }

}
