//
//  Word.swift
//  DICTO
//
//  Created by Deepanshu Gautam on 24/07/21.
//

import Foundation
import UIKit
struct Response: Codable {
    let word: String
    let meanings: [Meaning]
}

struct Meaning: Codable {
    let partOfSpeech: String
    let definitions: [Definition]
}

struct Definition: Codable {
    let definition: String
    let synonyms: [String]?
    let example: String?
}

