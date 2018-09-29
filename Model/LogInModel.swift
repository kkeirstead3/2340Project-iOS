//
//  LogIn.swift
//  2340Project-iOS
//
//  Created by Kyle Keirstead on 9/20/18.
//  Copyright © 2018 Kyle Keirstead. All rights reserved.
//

import UIKit

class LogInModel {

    /**
     * Checks to see if user credentials are valid. Looks at saved emails and passwords as well as the default user/pass login. If valid, returns the correct user
     */
    func validSignIn(username: String!, password: String!) -> User? {
        
        var users: Array<User>! = []
        if let data = UserDefaults.standard.data(forKey: "Users") {
            users = NSKeyedUnarchiver.unarchiveObject(with: data) as! Array<User>
        }

        for user in users {
            if user.email.lowercased() == username.lowercased() && user.password == password {
                return user
            }
        }
        
        if username == "user" && password == "pass" {
            return User(name: "user", email: "TestEmail", password: "pass", category: Category.UserTypes.User)
        }
        
        return nil
    }
}
