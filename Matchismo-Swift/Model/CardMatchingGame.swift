//
//  CardMatchingGame.swift
//  Matchismo-Swift
//
//  Copyright (c) 2014 Chrisna Aing. All rights reserved.
//

import Foundation

class CardMatchingGame: NSObject {

    // MARK: -
    // MARK: "Class" Properties

    // Hack!
    private struct Utility {
        static let choice = 1
        static let match = 4
        static let mismatch = 2
        static let minCardsToMatch: UInt = 2
    }

    // MARK: Private Properties

    private lazy var cards = [Card]()
    
    // Why?: http://stackoverflow.com/questions/26495586
    private let cardsToMatch: UInt!

    // MARK: Read-only Properties
    
    private(set) var score: Int = 0
    private(set) lazy var history = [CardMatchingGameResult]()

    // MARK: -
    // MARK: Initializers

    init?(cardCount: UInt, deck: Deck, cardsToMatch: UInt) {
        super.init()

        // Hopefully the number of cards to match makes sense.
        if cardsToMatch < Utility.minCardsToMatch || cardsToMatch > cardCount {
            return nil
        } else {
            self.cardsToMatch = cardsToMatch
        }

        // Draw cards randomly.
        for count in 0..<cardCount {
            if let card = deck.drawRandomCard() {
                cards.append(card)
            } else {
                return nil
            }
        }
    }

    convenience init?(cardCount: UInt, deck: Deck) {
        self.init(cardCount: cardCount, deck: deck, cardsToMatch: Utility.minCardsToMatch)
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
                var otherCards = [Card]()
                var matchAttempted = false
                var matchScore = 0

                if card.chosen {
                    card.chosen = false
                } else {
                    // Put potential cards to match into an array.
                    otherCards = cards.filter { !$0.matched && $0.chosen }
                    // Only try to match the cards when there are enough of them.
                    if otherCards.count + 1 == cardsToMatch {
                        matchScore = card.match(otherCards)
                        switch matchScore {
                        case 0:
                            matchScore += Utility.mismatch
                            score -= matchScore
                            otherCards.map { $0.chosen = false }
                        default:
                            matchScore *= Utility.match
                            score += matchScore
                            card.matched = true
                            otherCards.map { $0.matched = true }
                        }
                        matchAttempted = true
                    }
                    score -= Utility.choice
                    card.chosen = true
                }

                // To capture enough information to generate text about each move that has been
                // made, add a "result" object to an array with relevant information (i.e. cards
                // chosen, whether or not matching was attempted, and the result of that attempt).
                history.append(CardMatchingGameResult(
                    cards: otherCards + filter([card]) { $0.chosen },
                    matchAttempted: matchAttempted,
                    matched: card.matched,
                    matchScore: matchScore,
                    time: NSDate()))
            }
        }
    }

}
