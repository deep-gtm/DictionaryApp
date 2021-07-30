//
//  K.swift
//  Dicto
//
//  Created by Deepanshu Gautam on 17/07/21.
//

import Foundation
struct K {
    static let appName = "DICTO"
    static let cellNibName = "MeaningReusableCell"
    static let cellIdentifier = "reusableCell"
    struct BrandColors {
        static let yellow = "BrandYellow"
        static let blue = "BrandBlue"
        static let purple = "BrandPurple"
        static let orange = "BrandOrange"
        static let violet = "BrandViolet"
    }
    struct Images {
        static let background = "backgroundIcon"
        static let dictionaryIcon = "dictionary"
    }
    
    struct Segues {
        static let googleToMain = "googleToMain"
        static let registerToMain = "registerToMain"
        static let loginToMain = "loginToMain"
        static let animationToLogin = "animationToLogin"
        static let animationToMain = "animationToMain"
        static let mainToWelcome = "mainToWelcome"
    }
}

