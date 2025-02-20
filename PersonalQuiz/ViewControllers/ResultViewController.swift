//
//  ResultViewController.swift
//  PersonalQuiz
//
//  Created by Ast on 11.02.2025.
//

import UIKit

final class ResultViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    @IBAction func doneButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
}
