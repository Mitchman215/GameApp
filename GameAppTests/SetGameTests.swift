//
//  GameAppTests.swift
//  GameAppTests
//
//  Created by Mitchell Salomon on 2/10/22.
//

import XCTest
@testable import GameApp

class SetGameTests: XCTestCase {
    
    var sut: SetGame!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = SetGame()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func testInitialization() {
        XCTAssertEqual(sut.selectable.count, 12)
        XCTAssertEqual(sut.selected.count, 0)
        XCTAssertNil(sut.selectedAreMatch)
    }
    
    func testStandardDeal() {
        sut.standardDeal()
        XCTAssertEqual(sut.selectable.count, 15)
    }

    func testSelectedCountAfterTouchingUpToFourDifferentCards() {
        sut.touch(sut.selectable[0])
        XCTAssertEqual(sut.selected.count, 1)
        
        sut.touch(sut.selectable[1])
        XCTAssertEqual(sut.selected.count, 2)
        
        sut.touch(sut.selectable[2])
        XCTAssertEqual(sut.selected.count, 3)
        
        sut.touch(sut.selectable[3])
        XCTAssertEqual(sut.selected.count, 1)
    }
    
    func testTouchCardTwiceDeselectsIt() {
        sut.touch(sut.selectable[0])
        XCTAssertEqual(sut.selected.count, 1)
        
        sut.touch(sut.selectable[0])
        XCTAssertEqual(sut.selected.count, 0)
    }
    
    func testTouchThreeMatchingCards() {
        dealEntireDeck()
        // touch matching cards
        let zero = SetGame.Card(shape: .zero, color: .zero, shading: .zero, number: .zero)
        let one = SetGame.Card(shape: .one, color: .zero, shading: .zero, number: .zero)
        let two = SetGame.Card(shape: .two, color: .zero, shading: .zero, number: .zero)
        sut.touch(zero)
        XCTAssert(sut.selectedAreMatch == nil)
        sut.touch(one)
        XCTAssert(sut.selectedAreMatch == nil)
        sut.touch(two)
        XCTAssert(sut.selectedAreMatch != nil)
        XCTAssert(sut.selectedAreMatch!)
        
        // check that match is made properly
        sut.touch(one)
        XCTAssert(sut.selectedAreMatch == nil)
        // matched cards should be removed
        XCTAssertFalse(sut.selectable.contains(zero))
        XCTAssertFalse(sut.selectable.contains(one))
        XCTAssertFalse(sut.selectable.contains(two))
    }
    
    func testTouchThreeNonMatchingCards() {
        dealEntireDeck()
        // touch non-matching cards
        let zero = SetGame.Card(shape: .zero, color: .zero, shading: .zero, number: .zero)
        let one = SetGame.Card(shape: .one, color: .zero, shading: .zero, number: .zero)
        let unrelated = SetGame.Card(shape: .one, color: .one, shading: .two, number: .one)
        sut.touch(zero)
        XCTAssert(sut.selectedAreMatch == nil)
        sut.touch(one)
        XCTAssert(sut.selectedAreMatch == nil)
        sut.touch(unrelated)
        XCTAssert(sut.selectedAreMatch != nil)
        XCTAssertFalse(sut.selectedAreMatch!)
        
        // check that match is made properly
        sut.touch(zero)
        XCTAssert(sut.selectedAreMatch == nil)
        // matched cards should not be removed
        XCTAssert(sut.selectable.contains(zero))
        XCTAssert(sut.selectable.contains(one))
        XCTAssert(sut.selectable.contains(unrelated))
    }
    
    private func dealEntireDeck() {
        for _ in 0..<23 {
            sut.standardDeal()
        }
    }

}
