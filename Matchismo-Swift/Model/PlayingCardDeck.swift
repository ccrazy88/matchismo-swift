//
//  PlayingCardDeck.swift
//  Matchismo-Swift
//
//  Copyright (c) 2014 Chrisna Aing. All rights reserved.
//

import Foundation

class PlayingCardDeck: Deck {

    // MARK: -
    // MARK: Initializers

    override init() {
        super.init()
        for rank in 1...PlayingCard.maxRank() {
            for suit in PlayingCard.validSuits() {
                let card = PlayingCard(rank: rank, suit: suit)!
                addCard(card)
            }
        }
    }

}
