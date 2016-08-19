//
//  Crypto.swift
//  GroupLock
//
//  Created by Sergej Jaskiewicz on 18.07.16.
//  Copyright © 2016 Lanit-Tercom School. All rights reserved.
//

import CoreImage

/// Wrapper for the crypto library
protocol CryptoWrapperProtocol {

    /// Provides a maximum number of keys that can be generated
    var maximumNumberOfKeys: Int { get }

    /**
     Forms a request for the crypto library to provide an array of decryption keys.

     - parameter min: The minimum amount of keys needed to be applied in order to decrypt a file.
     - parameter max: The overall amount of keys to generate.

     - returns: An array of decryption keys constructed by a crypto library.
     */
    func getKeys(min min: Int, max: Int) -> [String]

    /**
     Forms a request for the crypto library to validate provided key.

     - parameter key: Key to validate

     - returns: `true` if the key is valid, otherwise `false`
     */
    func validate(key key: [String]) -> Bool

    /**
     Forms a request for the crypto library to validate a part of shared secret

     - parameter key: A part of shared secret

     - returns: `true` if the key is valid, otherwise `false`
     */
    func validatePart(key: String) -> Bool

    /**
     Forms a request for the crypto library to encrypt given image using given encryption key.

     - parameter image: Image to encrypt
     - parameter key:   Encryption key

     - returns: Encrypted image
     */
    func encryptImage(image image: NSData, withEncryptionKey key: [String]) -> NSData?

    /**
     Forms a request for the crypto library ro decrypt given image useing given decryptionKey.

     - parameter image: Image to decrypt
     - parameter key:   Decryption key

     - returns: Decrypted image
     */
    func decryptImage(image image: NSData, withDecryptionKey key: [String]) -> NSData?
}

/// Default implementation of the `CryptoWrapperProtocol`
class Crypto: CryptoWrapperProtocol {

    func getKeys(min min: Int, max: Int) -> [String] {

        // implementation goes here
        return [Int](1...max).map(String.init)
    }

    func validate(key key: [String]) -> Bool {
        return false
    }

    func validatePart(key: String) -> Bool {
        return false
    }

    func encryptImage(image image: NSData, withEncryptionKey key: [String]) -> NSData? {

        // implementation goes here
        return image
    }

    func decryptImage(image image: NSData, withDecryptionKey key: [String]) -> NSData? {

        // implementatiuon goes here
        return image
    }

    let maximumNumberOfKeys = 15
}
