//
//  QBAIRephraseTests.swift
//  QBAIRephrase
//
//  Created by Injoit on 07.09.2023.
//  Copyright © 2023 QuickBlox. All rights reserved.
//

import XCTest
@testable import QBAIRephrase

class QBAIRephraseTests: XCTestCase {
    override func tearDown() {
        QBAIRephrase.resetTonesToDefault()
        XCTAssertEqual(QBAIRephrase.tones.count, 10)
        
        super.tearDown()
    }
    
    func testQBAIRephrase_GetTones_default() {
        let tones = QBAIRephrase.tones
        XCTAssertNotNil(tones)
        XCTAssertEqual(tones.count, 10)
        
        guard let tone = tones[4] as? ToneInfo else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(tone, .neutral)
        XCTAssertNotEqual(tone, .friendly)
    }
    
    func testQBAIRephrase_RemoveTone_Existent() {
        QBAIRephrase.remove(tone: .neutral)
        
        let tones = QBAIRephrase.tones
        XCTAssertNotNil(tones)
        XCTAssertEqual(tones.count, 9)
        
        guard let tone = tones[4] as? ToneInfo else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(tone, .assertive)
        XCTAssertNotEqual(tone, .friendly)
    }
    
    func testQBAIRephrase_RemoveTone_notExistent() {
        let tone = ToneInfo(name: "test Tone")
        QBAIRephrase.remove(tone)
        XCTAssertEqual(QBAIRephrase.tones.count, 10)
    }
    
    func testQBAIRephrase_AppendTone_Existent() {
        QBAIRephrase.append(tone: .friendly)
        
        let tones = QBAIRephrase.tones
        XCTAssertNotNil(tones)
        XCTAssertEqual(tones.count, 10)
        
        guard let tone = tones[9] as? ToneInfo else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(tone, .friendly)
    }
    
    func testQBAIRephrase_AppendTone_New() {
        let newTone = ToneInfo(name: "test Tone")
        QBAIRephrase.append(newTone)
        
        let tones = QBAIRephrase.tones
        XCTAssertNotNil(tones)
        XCTAssertEqual(tones.count, 11)
        
        guard let tone = tones[10] as? ToneInfo else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(tone, newTone)
    }
    
    func testQBAIRephrase_InsertTone_ExistentToneAndIndex() {
        QBAIRephrase.insert(tone: .friendly, at: 6)
        
        var tones = QBAIRephrase.tones
        XCTAssertNotNil(tones)
        XCTAssertEqual(tones.count, 10)
        
        guard let tone = tones[5] as? ToneInfo else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(tone, .friendly)
        
        QBAIRephrase.insert(tone: .friendly, at: 3)
        
        tones = QBAIRephrase.tones
        XCTAssertEqual(tones.count, 10)
        
        guard let tone = tones[3] as? ToneInfo else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(tone, .friendly)
        
        QBAIRephrase.insert(tone: .friendly, at: 0)
        
        tones = QBAIRephrase.tones
        XCTAssertEqual(tones.count, 10)
        
        guard let tone = tones[0] as? ToneInfo else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(tone, .friendly)
    }
    
    func testQBAIRephrase_InsertTone_ExistentToneNotIndex() {
        QBAIRephrase.insert(tone: .friendly, at: 13)
        
        let tones = QBAIRephrase.tones
        XCTAssertNotNil(tones)
        XCTAssertEqual(tones.count, 10)
        
        guard let tone = tones[9] as? ToneInfo else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(tone, .friendly)
    }
    
    func testQBAIRephrase_InsertTone_ExistentIndexNotTone() {
        let newTone = ToneInfo(name: "test Tone")
        QBAIRephrase.insert(newTone, at: 1)
        
        let tones = QBAIRephrase.tones
        XCTAssertNotNil(tones)
        XCTAssertEqual(tones.count, 11)
        
        guard let tone = tones[2] as? ToneInfo else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(tone, .friendly)
        
        guard let tone = tones[1] as? ToneInfo else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(tone, newTone)
    }
    
    func testQBAIRephrase_InsertTone_NotExistentToneAndIndex() {
        let newTone = ToneInfo(name: "test Tone")
        QBAIRephrase.insert(newTone, at: 14)
        
        let tones = QBAIRephrase.tones
        XCTAssertNotNil(tones)
        XCTAssertEqual(tones.count, 11)
        
        guard let tone = tones[1] as? ToneInfo else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(tone, .friendly)
        
        guard let tone = tones[10] as? ToneInfo else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(tone, newTone)
    }
}
