//
//  AuthService.swift
//  BreakPoint
//
//  Created by Jacob Ahlberg on 2017-11-28.
//  Copyright © 2017 Jacob Ahlberg. All rights reserved.
//

import Foundation
import Firebase

class AuthService {
    static let instance = AuthService()
    
    func registerUser(withEmail email: String, andPassword password: String, userCreationComplete: @escaping (_ status: Bool, _ error: Error?) ->()) {
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            guard let user = user else {
                userCreationComplete(false, error)
                return
            }
            
            let userData = ["provider": user.providerID, "email": user.email]
            DataService.instance.createDBUser(uid: user.uid, userData: userData)
            userCreationComplete(true, nil)
        }
    }
    
    func loginUser(withEmail email: String, andPassword password: String, loginCreationComplete: @escaping (_ status: Bool, _ error: Error?) ->()) {
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error != nil {
                loginCreationComplete(false, error)
            } else {
                loginCreationComplete(true, nil)
            }        
        }
    }
    
}
