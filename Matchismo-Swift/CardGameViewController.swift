//
//  CardGameViewController.swift
//  Matchismo-Swift
//
//  Copyright (c) 2014 Chrisna Aing. All rights reserved.
//

import Foundation
import UIKit

class CardGameViewController: UIViewController {

    // MARK: -
    // MARK: Private Properties

    private lazy var game: CardMatchingGame = self.createGame()

    // MARK: Outlets

    // Need private(set) for subclasses, *sigh*.
    @IBOutlet private(set) var cardButtons: [UIButton]!

    @IBOutlet private weak var historyLabel: UILabel!
    @IBOutlet private weak var scoreLabel: UILabel!

    // MARK: -
    // MARK: Abstract Utilities

    func createDeck() -> Deck {
        // Abstract; will cause application to crash if used.
        return Deck()
    }

    // MARK: -
    // MARK: Utilities

    func createGame() -> CardMatchingGame {
        // Assumes that there are fewer cardButtons than there are cards in the deck.
        // Semi-abstract? Users may want to set an explicit cardsToMatch, which defaults to 2.
        return CardMatchingGame(cardCount: UInt(cardButtons.count), deck: self.createDeck())!
    }

    func titleForCard(card: Card) -> NSAttributedString? {
        // Abstract
        return nil
    }

    func backgroundImageForCard(card: Card) -> UIImage? {
        // Abstract
        return nil
    }

    func stringForCards(cards: [Card]) -> NSAttributedString? {
        // Abstract; will cause application to crash if used.
        return nil
    }

    private func stringForMoveAtIndex(index: UInt) -> NSAttributedString {
        // Use the history array provided by CardMatchingGame to generate the final string.
        let moveString = NSMutableAttributedString()
        if index < UInt(game.history.count) {
            let move = game.history[Int(index)]
            // Getting a little frisky here!
            let cards = stringForCards(move.cards)!
            let score = move.matchScore

            switch (move.matchAttempted, move.matched) {
            case (true, true):
                moveString.appendAttributedString(NSAttributedString(string: "Matched "))
                moveString.appendAttributedString(cards)
                moveString.appendAttributedString(
                    NSAttributedString(string: " for \(score) point" + (score != 1 ? "s." : ".")))
            case (true, false):
                moveString.appendAttributedString(cards)
                moveString.appendAttributedString(
                    NSAttributedString(string: " don't match! \(score) point penalty!"))
            case (false, _): moveString.appendAttributedString(cards)
            default: break
            }
        }
        return NSAttributedString(attributedString: moveString)
    }

    // MARK: -
    // MARK: Game

    func createNewGame() {
        game = createGame()
        resetUI()
    }

    @IBAction func startNewGame() {
        let alertController = UIAlertController(title: "Start New Game", message: "Are you sure?",
                                                preferredStyle: .Alert)
        let noAction = UIAlertAction(title: "No", style: .Cancel, handler: nil)
        let yesAction = UIAlertAction(title: "Yes", style: .Default) { (action) in
            dispatch_async(dispatch_get_main_queue()) {
                self.createNewGame()
            }
        }
        alertController.addAction(noAction)
        alertController.addAction(yesAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }

    @IBAction func touchCardButton(sender: UIButton) {
        // Assumes that all buttons are inside cardButtons.
        let cardButtonIndex = find(cardButtons, sender)!
        game.chooseCardAtIndex(UInt(cardButtonIndex))
        updateUI()
    }

    // MARK: -
    // MARK: UI

    private func resetUI() {
        updateUI()
    }

    private func updateUI() {
        for cardButton in cardButtons {
            let cardButtonIndex = find(cardButtons, cardButton)!
            let card = game.cardAtIndex(UInt(cardButtonIndex))!
            cardButton.setAttributedTitle(titleForCard(card), forState: .Normal)
            cardButton.setBackgroundImage(backgroundImageForCard(card), forState: .Normal)
            cardButton.enabled = !card.matched
        }

        scoreLabel.text = "Score: \(game.score)"

        let maxHistoryIndex = game.history.isEmpty ? 0 : game.history.count - 1
        historyLabel.attributedText = stringForMoveAtIndex(UInt(maxHistoryIndex))
    }

}
