//
//  Profile.swift
//  GiftHunteriOS
//
//  Created by Aswani G on 8/7/20.
//

import Foundation

struct Profile: Codable {
    var displayName: String
    var image: String
    var about: String
    var age: String
    var grade: String
    var level: Int
    var points: Int
    var minutes: Int
    var isQuotaCompleted: Bool
    static let `default`  = Self(displayName: "",
                                 image: "",
                                 about: "",
                                 age: "",
                                 grade: "",
                                 level: 1,
                                 points: 0,
                                 minutes: 0,
                                 isQuotaCompleted: false
                                )
}
