//
//  UserDefaults+Extension.swift
//  Whik
//
//  Created by Eden on 7/26/25.
//

import Foundation

extension UserDefaults {
    // MARK: Onboarding
    private enum Keys {
        static let userUUID = "userUUID"
        static let hasCompletedOnboarding = "hasCompletedOnboarding"
    }
    
    var userUUID: String {
        get {
            if let existing = string(forKey: Keys.userUUID) {
                return existing
            } else {
                let newUUID = UUID().uuidString
                set(newUUID, forKey: Keys.userUUID)
                return newUUID
            }
        }
    }
    
    var hasCompletedOnboarding: Bool {
        get {
            bool(forKey: Keys.hasCompletedOnboarding)
        }
        set {
            set(newValue, forKey: Keys.hasCompletedOnboarding)
        }
    }
    
    func resetOnboardingFlag() {
        removeObject(forKey: Keys.userUUID)
        removeObject(forKey: Keys.hasCompletedOnboarding)
    }
}
