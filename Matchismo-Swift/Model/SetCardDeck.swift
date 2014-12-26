//
//  SetCardDeck.swift
//  Matchismo-Swift
//
//  Copyright (c) 2014 Chrisna Aing. All rights reserved.
//

import Foundation

class SetCardDeck: Deck {

    // MARK: -
    // MARK: Initializers

    override init() {
        super.init()
        for color in 0..<SetCard.countOfType() {
            for number in 0..<SetCard.countOfType() {
                for shape in 0..<SetCard.countOfType() {
                    for shading in 0..<SetCard.countOfType() {
                        let card = SetCard(color: color, number: number, shading: shading,
                                           shape: shape)!
                        addCard(card)
                    }
                }
            }
        }
    }

}
