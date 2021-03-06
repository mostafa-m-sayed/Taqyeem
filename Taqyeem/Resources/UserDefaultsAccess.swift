//
//  UserDefaultsAccess.swift
//  Taqyeem
//
//  Created by Mostafa sayed on 11/19/19.
//  Copyright © 2019 mazeedit. All rights reserved.
//

import Foundation
class UserDefaultsAccess {
    static let sharedInstance = UserDefaultsAccess()
    let defaults = UserDefaults.standard
    var skippedLogin = false
    var token: String {
        get {
            if let token = defaults.object(forKey: "token") as? String {
                return token
            }
            return ""
        } set {
            defaults.set(newValue, forKey: "token")
        }
    }
    var user : User? {
        get {
            return UserDefaults.standard.getObject(key: "loggedUser")
        } set {
            defaults.saveObject(rawData: newValue, forKey: "loggedUser")
        }
    }
    func clearData() {
        self.user = nil
        token = ""
    }
    
}
