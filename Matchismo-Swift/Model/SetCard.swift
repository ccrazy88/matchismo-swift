//
//  SetCard.swift
//  Matchismo-Swift
//
//  Created by Chrisna Aing on 12/24/14.
//  Copyright (c) 2014 Chrisna Aing. All rights reserved.
//

import Foundation

class SetCard: Card {

    // MARK: -
    // MARK: "Class" Properties

    // Hack!
    private struct Utility {
        static let numberOfType: UInt = 3
    }

    // MARK: -
    // MARK: Private Properties

    private var _color: UInt?
    private var _number: UInt?
    private var _shading: UInt?
    private var _shape: UInt?

    // MARK: -
    // MARK: Public Properties

    var color: UInt {
        get { return _color ?? 0 }
        set (newColor) {
            if newColor < Utility.numberOfType {
                _color = newColor
            }
        }
    }

    var number: UInt {
        get { return _number ?? 0 }
        set (newNumber) {
            if newNumber < Utility.numberOfType {
                _number = newNumber
            }
        }
    }

    var shading: UInt {
        get { return _shading ?? 0 }
        set (newShading) {
            if newShading < Utility.numberOfType {
                _shading = newShading
            }
        }
    }

    var shape: UInt {
        get { return _shape ?? 0 }
        set (newShape) {
            if newShape < Utility.numberOfType {
                _shape = newShape
            }
        }
    }

    override var contents: String {
        get { return "" }
        set { }
    }

    // MARK: -
    // MARK: Initializers

    init(color: UInt, number: UInt, shading: UInt, shape: UInt, chosen: Bool = false, matched: Bool = false) {
        super.init(contents: "", chosen: chosen, matched: matched)
        self.color = color
        self.number = number
        self.shading = shading
        self.shape = shape
    }

    // MARK: -
    // MARK: Utilities

    class func numberOfType() -> UInt {
        return Utility.numberOfType
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
        if otherCards.count == Utility.numberOfType - 1 {
            if let otherSetCards = otherCards as? [SetCard] {
                let allCards = [self] + otherSetCards
                let uniqueCounts = [uniqueColors(allCards), uniqueNumbers(allCards), uniqueShading(allCards), uniqueShape(allCards)]
                for uniqueCount in uniqueCounts {
                    // For each property, all cards must either have the same value or different values.
                    if uniqueCount != 1 && uniqueCount != Utility.numberOfType {
                        return score
                    }
                }
                score = 4
            }
        }
        return score
    }

}