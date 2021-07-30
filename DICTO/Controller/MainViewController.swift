//
//  MainViewController.swift
//  DICTO
//
//  Created by Deepanshu Gautam on 21/07/21.
//

import UIKit
import GoogleSignIn
import Firebase
class MainViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var headingLabel: UILabel!
    var meanings: [Meaning]?
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate = self
        searchTextField.layer.cornerRadius = searchTextField.frame.size.height / 5
        navigationItem.hidesBackButton = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        wordManager.delegate = self
        tableView.dataSource = self
        tableView.isHidden = true
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        
    }
    
    @IBAction func logOutButtonPressed(_ sender: UIBarButtonItem) {
        if GIDSignIn.sharedInstance.currentUser != nil {
            GIDSignIn.sharedInstance.signOut()
        } else {
            do {
                if Auth.auth().currentUser != nil {
                    try Auth.auth().signOut()
                }
            } catch {
                print("Error In Signing Out")
            }
        }
        self.performSegue(withIdentifier: K.Segues.mainToWelcome, sender: self)
    }
    var wordManager = WordManager()
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
    }
    
}

//MARK: - UITextFieldDelegat

extension MainViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let word = textField.text, word != "" {
            wordManager.findMeaning(of: word)
        }
        textField.text = ""
    }
}


//MARK: - UIGestureDelegate

extension MainViewController: UIGestureRecognizerDelegate {
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

//MARK: - WordManagerDelegate

extension MainViewController: WordManagerDelegate {
    func didFindMeaning(_ wordManager: WordManager, answer: Response) {
        headingLabel.text = answer.word.uppercased()
        meanings = answer.meanings
        tableView.isHidden = false
        tableView.reloadData()
    }
    
    func didNotFindMeaning(_ wordManager: WordManager) {
        
    }
}

//MARK: - UITableViewDataSource

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meanings?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MeaningReusableCell
        cell.synonymsLabel.isHidden = true
        cell.exampleLabel.isHidden = true
        if let answers = meanings {
            let meaning = answers[indexPath.row]
            cell.partOfSpeechLabel.text = meaning.partOfSpeech.capitalized
            let definition = meaning.definitions[0]
            cell.definitionsLabel.text = "DEFINITION : \(definition.definition)"
            if let synonyms = definition.synonyms {
                cell.synonymsLabel.isHidden = false
                cell.synonymsLabel.text = "SYNONYMS : "
                for synonym in synonyms {
                    cell.synonymsLabel.text?.append("\(synonym), ")
                }
            }
            if let example = definition.example {
                cell.exampleLabel.isHidden = false
                cell.exampleLabel.text = "EXAMPLE : \(example)"
            }
        }
        return cell
    }
}
