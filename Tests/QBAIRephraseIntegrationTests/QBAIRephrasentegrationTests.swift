//
//  QBAIRephraseTests.swift
//
//  Created by Injoit on 09.09.2023.
//  Copyright © 2023 QuickBlox. All rights reserved.
//

import XCTest
@testable import QBAIRephrase

final class QBAIRephraseIntegrationTests: XCTestCase {
    override func tearDown() async throws {
        QBAIRephrase.resetTonesToDefault()
        XCTAssertEqual(QBAIRephrase.tones.count, 10)
        
        try await super.tearDown()
    }
    
    func testHasText_RephraseByOpenAIWithToken_returnAnswer() async {
        do {
            let answers = try await
            QBAIRephrase.openAI(rephrase: Test.text,
                                tone: .sarcastic,
                                secret: Config.openAIToken)
            print(answers)
            XCTAssertFalse(answers.isEmpty)
        } catch {
            XCTFail("Unexpected error type: \(error)")
        }
    }
    
    // To start this tests we need to have running Proxy server
    // The repository is: https://github.com/QuickBlox/qb-ai-assistant-proxy-server
    func testHasText_translateByProxy_returnAnswer() async {
        do {
            let answers = try await
            QBAIRephrase.openAI(rephrase: Test.text,
                                tone: .sarcastic,
                                qbToken: Config.qbToken,
                                proxy: "http://localhost:3000")
            print(answers)
            XCTAssertFalse(answers.isEmpty)
        } catch {
            XCTFail("Unexpected error type: \(error)")
        }
    }
    
}
