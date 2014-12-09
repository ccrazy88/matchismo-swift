//
//  CardGameViewController.swift
//  Matchismo-Swift
//
//  Created by Chrisna Aing on 10/25/14.
//  Copyright (c) 2014 Chrisna Aing. All rights reserved.
//

import UIKit

class CardGameViewController: UIViewController {

    // MARK: -
    // MARK: Private properties

    private lazy var game: CardMatchingGame = CardMatchingGame(
        cardCount: UInt(self.cardButtons.count), deck: self.createDeck())!

    // MARK: Outlets

    @IBOutlet private var cardButtons: [UIButton]!
    @IBOutlet private weak var scoreLabel: UILabel!

    // MARK: -
    // MARK: Utilities

    private func createDeck() -> Deck {
        return PlayingCardDeck()
    }

    private func titleForCard(card: Card) -> String? {
        return card.chosen ? card.contents : nil
    }

    private func backgroundImageForCard(card: Card) -> UIImage {
        return UIImage(named: card.chosen ? "CardFront" : "CardBack")!
    }

    // MARK: -
    // MARK: Game

    @IBAction func touchCardButton(sender: UIButton) {
        let cardButtonIndex = find(cardButtons, sender)!
        game.chooseCardAtIndex(UInt(cardButtonIndex))
        updateUI()
    }

    // MARK: -
    // MARK: UI

    func updateUI() {
        for cardButton in cardButtons {
            let cardButtonIndex = find(cardButtons, cardButton)!
            let card = game.cardAtIndex(UInt(cardButtonIndex))!
            cardButton.setTitle(titleForCard(card), forState: .Normal)
            cardButton.setBackgroundImage(backgroundImageForCard(card), forState: .Normal)
            cardButton.enabled = !card.matched
            scoreLabel.text = "Score: \(game.score)"
        }
    }

}
