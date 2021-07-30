//
//  WordManager.swift
//  DICTO
//
//  Created by Deepanshu Gautam on 24/07/21.
//

import Foundation

protocol WordManagerDelegate {
    func didFindMeaning(_ wordManager: WordManager, answer: Response)
    func didNotFindMeaning(_ wordManager: WordManager)
}

struct WordManager {
    var delegate: WordManagerDelegate?
    func findMeaning(of word: String) {
        let urlString = "https://api.dictionaryapi.dev/api/v2/entries/en_US/\(word)"
        let url = URL(string: urlString)
        if let safeURL = url {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: safeURL) { data, urlResponse, error in
                if let e = error {
                    print(e.localizedDescription)
                } else {
                    if let safeData = data {
                        self.parseJSON(data: safeData)
                    }
                }
            }
            task.resume()
        } else {
            print("Error In Creating URL")
        }
    }
    
    func parseJSON(data: Data) {
        let decoder = JSONDecoder()
        do {
            let response: [Response] = try decoder.decode([Response].self, from: data)
            let result = response[0]
            DispatchQueue.main.async {
                delegate?.didFindMeaning(self, answer: result)
            }
        } catch {
            print(error.localizedDescription)
        }
        
    }
}


