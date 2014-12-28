//
//  SetCardGameViewController.swift
//  Matchismo-Swift
//
//  Copyright (c) 2014 Chrisna Aing. All rights reserved.
//

import UIKit

class SetCardGameViewController: CardGameViewController {

    // MARK: -
    // MARK: View Lifecycle

    override func viewDidLoad() {
        // The cards don't start facedown, so we need to create a new game immediately.
        createNewGame()
    }

    override func createGame() -> CardMatchingGame {
        return CardMatchingGame(cardCount: UInt(cardButtons.count), deck: self.createDeck(),
                                cardsToMatch: 3)!
    }

    // MARK: -
    // MARK: Utilities

    override func createDeck() -> Deck {
        return SetCardDeck()
    }

    override func titleForCard(card: Card) -> NSAttributedString? {
        if let card = card as? SetCard {
            let title = NSMutableAttributedString()
            for number in 0...card.number {
                // Getting the character and range for the attributed character.
                let shape = ["▲", "●", "■"][Int(card.shape)]
                let range = NSMakeRange(0, (shape as NSString).length)

                // Creating the attributed character.
                let character = NSMutableAttributedString(string: shape)
                let color = [UIColor.redColor(), UIColor.greenColor(),
                             UIColor.purpleColor()][Int(card.color)]
                switch card.shading {
                case 0:
                    // Solid
                    character.addAttribute(NSForegroundColorAttributeName, value: color,
                                           range: range)
                case 1:
                    // Striped (transparent in this case)
                    character.addAttribute(
                        NSForegroundColorAttributeName,
                        value: color.colorWithAlphaComponent(0.5), range: range)
                case 2:
                    // Outlined
                    character.addAttribute(NSStrokeColorAttributeName, value: color, range: range)
                    character.addAttribute(NSStrokeWidthAttributeName, value: 3, range: range)
                default: break
                }
                title.appendAttributedString(character)
            }
            return NSAttributedString(attributedString: title)
        } else {
            return nil
        }
    }

    override func backgroundImageForCard(card: Card) -> UIImage? {
        return UIImage(named: card.chosen ? "ChosenCardFront" : "CardFront")
    }

    override func stringForCards(cards: [Card]) -> NSAttributedString? {
        var cardsString = NSMutableAttributedString()
        for card in cards {
            if let title = titleForCard(card) {
                cardsString.appendAttributedString(title)
            } else {
                return nil
            }
        }
        return NSAttributedString(attributedString: cardsString)
    }

    // MARK: -
    // MARK: Game

    override func createNewGame() {
        storeGameStatistics("Match")
        super.createNewGame()
    }

}
