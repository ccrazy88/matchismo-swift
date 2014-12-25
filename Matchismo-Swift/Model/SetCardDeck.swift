//
//  SetCardDeck.swift
//  Matchismo-Swift
//
//  Created by Chrisna Aing on 12/24/14.
//  Copyright (c) 2014 Chrisna Aing. All rights reserved.
//

import Foundation

class SetCardDeck: Deck {

    // MARK: -
    // MARK: Initializers

    override init() {
        super.init()
        for color in 0..<SetCard.numberOfType() {
            for number in 0..<SetCard.numberOfType() {
                for shape in 0..<SetCard.numberOfType() {
                    for shading in 0..<SetCard.numberOfType() {
                        let card = SetCard(color: color, number: number, shading: shading, shape: shape)
                        addCard(card)
                    }
                }
            }
        }
    }

}
