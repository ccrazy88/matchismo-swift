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

    override func createGame() -> CardMatchingGame {
        let game = CardMatchingGame(cardCount: UInt(cardButtons.count), deck: self.createDeck())!
        game.cardsToMatch = 2
        return game
    }

    override func createDeck() -> Deck {
        return PlayingCardDeck()
    }

    override func titleForCard(card: Card) -> NSAttributedString? {
        let contents = NSMutableAttributedString(string: card.contents)
        // Make text black because UIButton's default color is tintColor.
        contents.addAttribute(
            NSForegroundColorAttributeName,
            value: UIColor.blackColor(),
            // To deal with Unicode length differences between String and NSString.
            range: NSMakeRange(0, (card.contents as NSString).length))
        // Return an immutable version.
        return card.chosen ? NSAttributedString(attributedString: contents) : nil
    }

    override func backgroundImageForCard(card: Card) -> UIImage? {
        return UIImage(named: card.chosen ? "CardFront" : "CardBack")
    }

    override func stringForCards(cards: [Card]) -> NSAttributedString? {
        var cardsString = ""
        for card in cards {
            cardsString += card.contents
        }
        return NSAttributedString(string: cardsString)
    }

}
