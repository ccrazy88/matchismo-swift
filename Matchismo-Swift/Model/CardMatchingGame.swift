//
//  CardMatchingGame.swift
//  Matchismo-Swift
//
//  Created by Chrisna Aing on 12/9/14.
//  Copyright (c) 2014 Chrisna Aing. All rights reserved.
//

import Foundation

class CardMatchingGame: NSObject {

    // MARK: -
    // MARK: "Class" Properties

    // Hack!
    private struct Multiplier {
        static let CHOICE = 1
        static let MATCH = 4
        static let MISMATCH = 2
    }

    // MARK: Private Properties

    private lazy var cards = [Card]()

    // MARK: Read-only Properties
    
    private(set) var score: Int = 0

    // MARK: -
    // MARK: Initializers

    init?(cardCount: UInt, deck: Deck) {
        super.init()
        for count in 1...cardCount {
            if let card = deck.drawRandomCard() {
                cards.append(card)
            } else {
                return nil
            }
        }
    }

    // MARK: -
    // MARK: Utilities

    func cardAtIndex(index: UInt) -> Card? {
        return (index < UInt(cards.count)) ? cards[Int(index)] : nil
    }

    // MARK: -
    // MARK: Game

    func chooseCardAtIndex(index: UInt) {
        if let card = cardAtIndex(index) {
            if !card.matched {
                if card.chosen {
                    card.chosen = false
                } else {
                    for otherCard in cards {
                        if !otherCard.matched && otherCard.chosen {
                            let matchScore = card.match([otherCard])
                            if matchScore != 0 {
                                score += matchScore * Multiplier.MATCH
                                card.matched = true
                                otherCard.matched = true
                            } else {
                                score -= Multiplier.MISMATCH
                                otherCard.chosen = false
                            }
                            break
                        }
                    }
                    score -= Multiplier.CHOICE
                    card.chosen = true
                }
            }
        }
    }
   
}
