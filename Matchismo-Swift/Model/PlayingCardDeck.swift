//
//  PlayingCardDeck.swift
//  Matchismo-Swift
//
//  Created by Chrisna Aing on 11/28/14.
//  Copyright (c) 2014 Chrisna Aing. All rights reserved.
//

class PlayingCardDeck: Deck {

    // MARK: -
    // MARK: Initializers

    override init() {
        super.init()
        for rank in 1...PlayingCard.maxRank() {
            for suit in PlayingCard.validSuits() {
                let card = PlayingCard(rank: rank, suit: suit)
                addCard(card)
            }
        }
    }

}
