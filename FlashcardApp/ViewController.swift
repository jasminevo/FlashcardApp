//
//  ViewController.swift
//  FlashcardApp
//
//  Created by Jasmine Vo on 10/13/18.
//  Copyright © 2018 Jasmine Vo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var backLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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
        if frontLabel.isHidden == true {
            frontLabel.isHidden = false
        }
        else {
        frontLabel.isHidden = true
        }
    }
    
    func updateFlashcard(question: String, answer: String) {
        
        frontLabel.text = question
        backLabel.text = answer
    }
    
   // @IBAction func didTapOnDone(_ sender: Any) {
   //   dismiss(animated: true)
   //  }
    

    
    
}

