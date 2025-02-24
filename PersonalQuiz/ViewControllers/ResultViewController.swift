//
//  ResultViewController.swift
//  PersonalQuiz
//
//  Created by Ast on 13.02.2025.
//

import UIKit

final class ResultViewController: UIViewController {
    
    @IBOutlet var resultLabel: UILabel!
    @IBOutlet var textLabel: UILabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        navigationItem.setHidesBackButton(true, animated: false)
        resultLabel.text = "Вы - \(resultIcon)!"
        textLabel.text = resultText
        
    }
    
    @IBAction private func doneButtonTapped(_ sender: UIBarButtonItem) {
        
        dismiss(animated: true)
    }    
}
