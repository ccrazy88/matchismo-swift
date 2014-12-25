//
//  PlayingCardGameViewController.swift
//  Matchismo-Swift
//
//  Created by Chrisna Aing on 12/24/14.
//  Copyright (c) 2014 Chrisna Aing. All rights reserved.
//

import UIKit

class PlayingCardGameViewController: CardGameViewController {
   
    // MARK: -
    // MARK: Utilities

    override func createDeck() -> Deck {
        return PlayingCardDeck()
    }

}
