//
//  Authentication.swift
//  VKClient
//
//  Created by Dzmitry on 11/3/20.
//

import Foundation

/**
 Manages authentication process (sign in/sign out) and stores
 the current authentication status.
 */
struct Authentication {
    /**
     Keys associated with values in the current user‘s defaults
     database.
     */
    private enum UserDefaultsKey {
        static let isSignedIn = "isSignedIn"
    }

    /**
     A boolean flag indicating whether the user is signed in.
     */
    private(set) static var isSignedIn: Bool {
        get {
            return UserDefaults.standard.bool(forKey: UserDefaultsKey.isSignedIn)
        }
        set {
            if newValue != isSignedIn {
                UserDefaults.standard.set(newValue, forKey: UserDefaultsKey.isSignedIn)
            }
        }
    }

    /**
     Performs user authentication process.
     - Parameter completion: A completion handler that
     takes `true` as a parameter. A value of `true` means that
     the authentication is successfully completed or the user
     is already authenticated.
     */
    static func signIn(completion: (Bool) -> Void) {
        isSignedIn = true
        completion(true)
    }

    /**
     Performs user sign out process.
     - Parameter completion: A completion handler that
     takes `true` as a parameter. A value of `true` means that
     the sign out is successfully completed or the user already
     signed out.
     */
    static func signOut(completion: (Bool) -> Void) {
        isSignedIn = false
        completion(true)
    }
}
