//
//  UserDefaults+Extension.swift
//  Whik
//
//  Created by Eden on 7/26/25.
//

import Foundation

extension UserDefaults {
    
    private enum Keys {
        static let hasCompletedOnboarding = "hasCompletedOnboarding"
        static let memberId = "memberId"
        static let nickname = "nickname"
    }
    
    var hasCompletedOnboarding: Bool {
        get { bool(forKey: Keys.hasCompletedOnboarding) }
        set { set(newValue, forKey: Keys.hasCompletedOnboarding) }
    }
    
    var memberId: String? {
        get { string(forKey: Keys.memberId) }
        set { set(newValue, forKey: Keys.memberId) }
    }

    var nickname: String? {
        get { string(forKey: Keys.nickname) }
        set { set(newValue, forKey: Keys.nickname) }
    }

    func resetOnboardingFlag() {
        removeObject(forKey: Keys.hasCompletedOnboarding)
        removeObject(forKey: Keys.memberId)
        removeObject(forKey: Keys.nickname)
    }
}

