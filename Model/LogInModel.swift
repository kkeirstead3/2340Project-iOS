//
//  LogIn.swift
//  2340Project-iOS
//
//  Created by Kyle Keirstead on 9/20/18.
//  Copyright © 2018 Kyle Keirstead. All rights reserved.
//

import UIKit

class LogInModel {

    func validSignIn(username: String!, password: String!) -> Bool {
        if username == "user" && password == "pass" {
            return true
        }
        return false
    }
}
