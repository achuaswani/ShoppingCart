//
//  FirebaseSession.swift
//  ShoppingCart
//
//  Created by Aswani G on 7/25/20.
//  Copyright © 2020 pixycoders private limited. All rights reserved.
//

import SwiftUI
import Firebase
import FirebaseAuth

class FirebaseSession: ObservableObject {
    
    //MARK: Properties
    @Published var user: User?
    @Published var isLoggedIn: Bool?
    //MARK: Functions
    func listen() {
        _ = Auth.auth().addStateDidChangeListener { (auth, user) in
            if let user = user {
                self.user = User(uid: user.uid, displayName: user.displayName, email: user.email)
                self.isLoggedIn = true
                Crashlytics.crashlytics().setUserID(user.uid)
            } else {
                self.isLoggedIn = false
                self.user = nil
            }
        }
    }
    
    func signin(email: String, password: String, handler: @escaping AuthDataResultCallback) {
        Auth.auth().signIn(withEmail: email, password: password, completion: handler)
    }
    
    func signout() {
            try! Auth.auth().signOut()
            self.isLoggedIn = false
            self.user = nil

    }
    
    func signUp(email: String, password: String, handler: @escaping AuthDataResultCallback) {
        Auth.auth().createUser(withEmail: email, password: password, completion: handler)
    }
    
}
