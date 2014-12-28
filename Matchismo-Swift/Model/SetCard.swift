//
//  SetCard.swift
//  Matchismo-Swift
//
//  Copyright (c) 2014 Chrisna Aing. All rights reserved.
//

import Foundation

class SetCard: Card {

    // MARK: -
    // MARK: "Class" Properties

    // Hack!
    private struct Utility {
        static let countOfType: UInt = 3
    }

    // MARK: -
    // MARK: Public Properties

    // Why?: http://stackoverflow.com/questions/26495586
    let color: UInt!
    let number: UInt!
    let shading: UInt!
    let shape: UInt!

    // MARK: -
    // MARK: Initializers

    init?(color: UInt, number: UInt, shading: UInt, shape: UInt, chosen: Bool = false,
          matched: Bool = false) {
        super.init(contents: "", chosen: chosen, matched: matched)

        if color >= Utility.countOfType || number >= Utility.countOfType || shading >=
           Utility.countOfType || shape >= Utility.countOfType {
                return nil
        } else {
            self.color = color
            self.number = number
            self.shading = shading
            self.shape = shape
        }
    }

    // MARK: -
    // MARK: Utilities

    class func countOfType() -> UInt {
        return Utility.countOfType
    }

    // TODO: Make generic.

    private func uniqueColors(cards: [SetCard]) -> UInt {
        var colors = [UInt: UInt]()
        cards.map { colors[$0.color] = 1 }
        return UInt(colors.count)
    }

    private func uniqueNumbers(cards: [SetCard]) -> UInt {
        var numbers = [UInt: UInt]()
        cards.map { numbers[$0.number] = 1 }
        return UInt(numbers.count)
    }

    private func uniqueShading(cards: [SetCard]) -> UInt {
        var shadings = [UInt: UInt]()
        cards.map { shadings[$0.shading] = 1 }
        return UInt(shadings.count)
    }

    private func uniqueShape(cards: [SetCard]) -> UInt {
        var shapes = [UInt: UInt]()
        cards.map { shapes[$0.shape] = 1 }
        return UInt(shapes.count)
    }

    // MARK: -
    // MARK: Card Matching

    override func match(otherCards: [Card]) -> Int {
        var score = 0
        // Must have numberOfType cards total to match.
        if otherCards.count == Utility.countOfType - 1 {
            if let otherSetCards = otherCards as? [SetCard] {
                let allCards = [self] + otherSetCards
                let uniqueCounts = [uniqueColors(allCards), uniqueNumbers(allCards),
                                    uniqueShading(allCards), uniqueShape(allCards)]
                for uniqueCount in uniqueCounts {
                    // For each property, all cards must either have the same value or different
                    // values.
                    if uniqueCount != 1 && uniqueCount != Utility.countOfType {
                        return score
                    }
                }
                score = 4
            }
        }
        return score
    }

}
