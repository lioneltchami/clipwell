//
//  UpdaterServiceTests.swift
//  ClipwellTests
//

import Foundation
import Testing
@testable import Clipwell

@MainActor
struct UpdaterServiceTests {

    @Test func missingPublicKeyIsInvalid() {
        #expect(UpdaterService.isValidPublicKey(nil) == false)
    }

    @Test func placeholderPublicKeyIsInvalid() {
        #expect(UpdaterService.isValidPublicKey("SPARKLE_PUBLIC_KEY") == false)
    }

    @Test func blankPublicKeyIsInvalid() {
        #expect(UpdaterService.isValidPublicKey(" \n\t ") == false)
    }

    @Test func malformedPublicKeyIsInvalid() {
        #expect(UpdaterService.isValidPublicKey("not-a-public-key") == false)
    }

    @Test func wrongLengthPublicKeyIsInvalid() {
        let publicKey = Data(repeating: 0, count: 31).base64EncodedString()
        #expect(UpdaterService.isValidPublicKey(publicKey) == false)
    }

    @Test func configuredPublicKeyIsValid() {
        let publicKey = Data(repeating: 0, count: 32).base64EncodedString()
        #expect(UpdaterService.isValidPublicKey(publicKey) == true)
    }
}
