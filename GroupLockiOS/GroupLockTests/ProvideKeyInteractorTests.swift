//
//  ProvideKeyInteractorTests.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 03.08.16.
//  Copyright (c) 2016 Lanit-Tercom School. All rights reserved.
//

import XCTest
@testable import GroupLock

// swiftlint:disable force_unwrapping
class ProvideKeyInteractorTests: XCTestCase {

    struct Seeds {
        static let keys = ["Key 1", "Key 2", "Key 3"]
    }

    // MARK: Subject under test
    var sut: ProvideKeyInteractor!

    // MARK: - Test lifecycle
    override func setUp() {
        super.setUp()

        sut = ProvideKeyInteractor()
    }

    override func tearDown() {

        super.tearDown()
    }

    // MARK: - Test doubles

    class CryptoWrapperFake: CryptoWrapperProtocol {

        let maximumNumberOfKeys = -1

        func getKeys(min: Int, max: Int) -> [String] {
            return Seeds.keys
        }
        func validate(key: [String]) -> Bool {
            return false
        }

        func validatePart(_ key: String) -> Bool {
            return false
        }

        func encrypt(image: Data, withEncryptionKey key: [String]) -> Data? {
            return Data()
        }

        func decrypt(image: Data, withDecryptionKey key: [String]) -> Data? {
            return Data()
        }
    }

    class ProvideKeyInteractorOutputSpy: ProvideKeyInteractorOutput {

        var decryptionKeys: [String]?

        func createQRCodes(_ response: ProvideKey.Configure.Response) {
            decryptionKeys = response.decryptionKeys
        }
    }

    // MARK: - Tests

    func test_ThatProvideKeyInteractor_fetchesDecryptionKeys() {

        // Given
        let cryptoWrapperFake = CryptoWrapperFake()
        let provideKeyInteractorOutputSpy = ProvideKeyInteractorOutputSpy()
        sut.cryptoLibrary = cryptoWrapperFake
        sut.output = provideKeyInteractorOutputSpy

        // When
        sut.getKeys(ProvideKey.Configure.Request())

        // Then
        let expectedKeys = Seeds.keys
        let actualKeys = provideKeyInteractorOutputSpy.decryptionKeys
        XCTAssertNotNil(actualKeys,
                        "ProvideKeyInteractor should ask the presenter to create QR-codes with given keys")
        XCTAssertEqual(expectedKeys, actualKeys!,
                       "ProvideKeyInteractor should ask the crypto library for decryption keys and send them" +
            " to the presenter")
    }
}
// swiftlint:enable force_unwrapping
