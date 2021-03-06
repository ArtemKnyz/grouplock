//
//  KeyTypeViewControllerTests.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 18.07.16.
//  Copyright (c) 2016 Lanit-Tercom School. All rights reserved.
//

import XCTest
@testable import GroupLock

// swiftlint:disable force_cast
class KeyTypeViewControllerTests: XCTestCase {

    struct Seeds {
        struct SetKeyType {
            static let defaultKeyType = KeyType.QRCode
            static let buttonLabelText = "Key Name"
        }
    }

    // MARK: Subject under test
    var sut: KeyTypeViewController!

    var window: UIWindow!

    // MARK: - Test lifecycle

    override func setUp() {
        super.setUp()

        window = UIWindow()
        setupKeyTypeViewController()
    }

    override func tearDown() {

        window = nil
        super.tearDown()
    }

    // MARK: - Test setup

    func setupKeyTypeViewController() {

        let bundle = Bundle.main
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        sut = storyboard.instantiateViewController(
            withIdentifier: "KeyTypeViewController") as! KeyTypeViewController
        loadView()
    }

    func loadView() {
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }

    // MARK: - Test doubles

    class KeyTypeViewControllerOutputSpy: KeyTypeViewControllerOutput {

        var setKeyType_called = false // swiftlint:disable:this variable_name
        var receivedKeyName = "none"

        var files: [File] = []
        var keyType = Seeds.SetKeyType.defaultKeyType

        func setKeyType(_ request: KeyTypeModels.SetType.Request) {
            setKeyType_called = true
            receivedKeyName = request.keyName
        }

    }

    class KeyTypeRouterSpy: KeyTypeRouter {

        var passDataToNumberOfKeysScene_called = false // swiftlint:disable:this variable_name

        override func passDataToNumberOfKeysScene(_ segue: UIStoryboardSegue) {
            passDataToNumberOfKeysScene_called = true
        }
    }

    // MARK: - Tests

    func test_ThatKeyTypeButtons_triggerSettingKeyType() {

        // Given
        let keyTypeViewControllerOutputSpy = KeyTypeViewControllerOutputSpy()
        sut.output = keyTypeViewControllerOutputSpy
        let keyTypeButton = UIButton(type: .custom)
        keyTypeButton.titleLabel?.text = Seeds.SetKeyType.buttonLabelText

        // When
        sut.onKeyType(keyTypeButton)

        // Then
        XCTAssertTrue(keyTypeViewControllerOutputSpy.setKeyType_called,
                      "Tapping on a key type button should cause invoking setKeyType method on output")
    }

    func test_ThatKeyTypeButtons_passTheirLabelTextToOutput() {

        // Given
        let keyTypeViewControllerOutputSpy = KeyTypeViewControllerOutputSpy()
        sut.output = keyTypeViewControllerOutputSpy
        let keyTypeButton = UIButton(type: .custom)
        keyTypeButton.titleLabel?.text = Seeds.SetKeyType.buttonLabelText

        // When
        sut.onKeyType(keyTypeButton)

        // Then
        let expectedValue = Seeds.SetKeyType.buttonLabelText
        let returnedValue = keyTypeViewControllerOutputSpy.receivedKeyName
        XCTAssertEqual(expectedValue, returnedValue, "The text on a key type button should be passed to output")
    }

    func test_ThatKeyTypeButtons_TriggerPassingDataToNumberOfKeysScene() {

        // Given
        let keyTypeRouterSpy = KeyTypeRouterSpy()
        sut.router = keyTypeRouterSpy
        sut.router.viewController = sut
        let keyTypeButton = UIButton(type: .custom)
        keyTypeButton.titleLabel?.text = Seeds.SetKeyType.buttonLabelText

        // When
        sut.onKeyType(keyTypeButton)

        // Then
        XCTAssertTrue(keyTypeRouterSpy.passDataToNumberOfKeysScene_called,
                      "Tapping on a key type button should trigger passing data to NumberOfKeys scene")
    }
}
// swiftlint:enable force_unwrapping
