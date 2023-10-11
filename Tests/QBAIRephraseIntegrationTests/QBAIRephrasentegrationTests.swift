//
//  QBAIRephraseTests.swift
//
//  Created by Injoit on 09.09.2023.
//  Copyright © 2023 QuickBlox. All rights reserved.
//

import XCTest
@testable import QBAIRephrase

final class QBAIRephraseIntegrationTests: XCTestCase {
    
    func testHasText_RephraseByOpenAIWithToken_returnAnswer() async {
        do {
            var settings = AISettings(apiKey: Config.openAIToken,
                                      tone: Test.encouragingTone)
            let answersEncouraging = try await
            QBAIRephrase.rephrase(text: Test.text, history: Test.messages, using: settings)
            print(answersEncouraging)
            XCTAssertFalse(answersEncouraging.isEmpty)
            
            settings.tone = Test.professionalTone
            let answersProfessional = try await
            QBAIRephrase.rephrase(text: Test.text, history: Test.messages, using: settings)
            print(answersProfessional)
            XCTAssertFalse(answersProfessional.isEmpty)
        } catch {
            XCTFail("Unexpected error type: \(error)")
        }
    }
    
    // To start this tests we need to have running Proxy server
    // The repository is: https://github.com/QuickBlox/qb-ai-assistant-proxy-server
    func testHasText_translateByProxy_returnAnswer() async {
        do {
            let settings = AISettings(token: Config.qbToken,
                                      serverPath: "http://localhost:3000",
                                      tone: Test.professionalTone)
            let answers = try await
            QBAIRephrase.rephrase(text: Test.text, history: Test.messages, using: settings)
            print(answers)
            XCTAssertFalse(answers.isEmpty)
        } catch {
            XCTFail("Unexpected error type: \(error)")
        }
    }
    
}
