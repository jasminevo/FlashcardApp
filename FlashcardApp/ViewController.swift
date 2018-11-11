//
//  ViewController.swift
//  FlashcardApp
//
//  Created by Jasmine Vo on 10/13/18.
//  Copyright © 2018 Jasmine Vo. All rights reserved.
//

import UIKit

struct Flashcard {
    var question: String
    var answer: String
}

class ViewController: UIViewController {

    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var backLabel: UILabel!
    
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    
    // array to hold flashcards
    var flashcards = [Flashcard]()
    
    // current flashcard index
    var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        readSavedFlashcards()
        
        if (flashcards.count == 0) {
        updateFlashcard(question: "What team does Klay Thompson play for?", answer: "Golden State Warriors")
        }
        else {
            updateLabels()
            updateNextPrevButtons()
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // let the segue know the destination is the Navigation Controller
        let navigationController = segue.destination as! UINavigationController
        
        // we know the navigation controller only contains a creation view controller
        let creationController = navigationController.topViewController as! CreationViewController
        
        // we set flashcardController property to self
        creationController.flashcardsController = self
    }
    
    @IBAction func didTapOnFlashcard(_ sender: Any) {
        if (frontLabel.isHidden) {
            frontLabel.isHidden = false
        }
        else {
        frontLabel.isHidden = true
        }
    }
    
    func saveAllFlashcardsToDisk() {
        let dictionary = flashcards.map { (card) -> [String: String] in
            return ["question": card.question, "answer": card.answer]
        }
        UserDefaults.standard.set(dictionary, forKey: "flashcards")
        print("Flashcards saved to UserDefaults")
    }
    
    func readSavedFlashcards() {
        if let dictionary = UserDefaults.standard.array(forKey: "flashcards") as? [[String: String]] {
            let savedCards = dictionary.map { (dictionaryArray) -> Flashcard in
                return Flashcard(question: dictionaryArray["question"]! , answer: dictionaryArray["answer"]!)
            }
            flashcards.append(contentsOf: savedCards)
        }
    }
    
    func updateFlashcard(question: String, answer: String) {
        let flashcard = Flashcard(question: question, answer: answer)
        
        frontLabel.text = flashcard.question
        backLabel.text = flashcard.answer
        
        // adding flashcard in the flashcards array
        flashcards.append(flashcard)
        
        // logging into the consoles
        print("Added new flashcard")
        print("We now have \(flashcards.count) flashcards")
        
        // update current index
        currentIndex = flashcards.count - 1
        print("Our current index is \(currentIndex)")
        
        // update buttons
        updateNextPrevButtons()
        
        // update labels
        updateLabels()
    }
    
    func updateNextPrevButtons() {
        if (flashcards.count == 1) {
            prevButton.isEnabled = false
            nextButton.isEnabled = false
        } else if (currentIndex == 0) {
            prevButton.isEnabled = false
            nextButton.isEnabled = true
        } else if (currentIndex == flashcards.count - 1) {
            prevButton.isEnabled = true
            nextButton.isEnabled = false
        } else {
            nextButton.isEnabled = true
            prevButton.isEnabled = true
        }
    }
    
    func updateLabels() {
        
        // get current flashcard
        let currentFlashcard = flashcards[currentIndex]
        
        // update labels
        frontLabel.text = currentFlashcard.question
        backLabel.text = currentFlashcard.answer
    }
    
    @IBAction func didTapOnPrevious(_ sender: Any) {
        if (currentIndex + 1 < flashcards.count) {
            // increase current index
            currentIndex = currentIndex - 1
            
            // update labels
            updateLabels()
            
            // update buttons
            updateNextPrevButtons()
        }
    }
    
    @IBAction func didTapOnNext(_ sender: Any) {
        
        if (currentIndex + 1 < flashcards.count) {
            // increase current index
            currentIndex = currentIndex + 1
        
            // update labels
            updateLabels()
        
            // update buttons
            updateNextPrevButtons()
        }
    }
}
