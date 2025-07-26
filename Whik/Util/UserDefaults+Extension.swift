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
        static let hasCompletedOnboarding = "hasCompletedOnboarding"
        static let memberId = "memberId"
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
        removeObject(forKey: Keys.hasCompletedOnboarding)
    }
    
    // MARK: - Member ID (UUID)
    var memberId: String? {
        get {
            string(forKey: Keys.memberId)
        }
        set {
            set(newValue, forKey: Keys.memberId)
        }
    }
    
    func removeMemberId() {
        removeObject(forKey: Keys.memberId)
    }
}
