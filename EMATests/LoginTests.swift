//
//  LoginTests.swift
//  EMATests
//
//  Created by Ertugrul Yilmaz on 22.07.18.
//  Copyright © 2018 Mustafa Sahinli. All rights reserved.
//

import XCTest
@testable import EMA

class LoginTests: XCTestCase {

    var loginManager = LoginManager()

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testWrongCredentials() {
        let isLoginSuccessful = loginManager.tryLogin(username: "admin", password: "1234")

        XCTAssertFalse(isLoginSuccessful)
    }

    func testCorrectCredentials() {
        let isLoginSuccessful = loginManager.tryLogin(username: "benutzername", password: "passwort")

        XCTAssertTrue(isLoginSuccessful)
    }

    func testPerformanceExample() {
        self.measure {
        }
    }
}
