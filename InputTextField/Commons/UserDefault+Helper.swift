//
//  Defaults.swift
//  InputTextField
//
//  Created by Quang Công on 26/06/2021.
//

import Foundation
import UIKit

private enum Defaults: String {
    case suggestions
}

final class UserDefaultHelper {
    // Access shared defaults object
    private static let userDefaults = UserDefaults.standard
    
    static var suggestions: [String]? {
        set {
            saveSuggest(value: newValue, key: .suggestions)
        } get {
            return readSuggest(valueForKey: .suggestions) ?? []
        }
    }
    
    private static func saveSuggest(value: [String]?, key: Defaults) {
        userDefaults.set(value, forKey: key.rawValue)
    }

    private static func readSuggest(valueForKey key: Defaults)-> [String]? {
        return userDefaults.value(forKey: key.rawValue) as? [String]
    }
}
