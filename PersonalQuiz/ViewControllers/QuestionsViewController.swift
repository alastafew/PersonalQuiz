//
//  QuestionsViewController.swift
//  PersonalQuiz
//
//  Created by Ast on 13.02.2025.
//

import UIKit

final class QuestionsViewController: UIViewController {
    
    // MARK: - IB Outlets
    @IBOutlet private var questionLabel: UILabel!
    @IBOutlet private var questionProgressView: UIProgressView!
    
    @IBOutlet private var singleStackView: UIStackView!
    @IBOutlet private var singleButtons: [UIButton]!
    
    @IBOutlet private var multipleStackView: UIStackView!
    @IBOutlet private var multipleLabels: [UILabel]!
    @IBOutlet private var multipleSwitches: [UISwitch]!
    
    @IBOutlet private var rangedStackView: UIStackView!
    @IBOutlet private var rangedLabels: [UILabel]!
    @IBOutlet private var rangedSlider: UISlider!
    
    // MARK: - Private properties
    private let questions = Question.questions
    private var questionIndex = 0
    private var selectedAnswers: [Answer] = []
    private var currentAnswers: [Answer] {
        questions[questionIndex].answers
    }
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        let answerCount = Float(currentAnswers.count - 1)
        rangedSlider.maximumValue = answerCount
        rangedSlider.value = answerCount / 2
        updateUI()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    // MARK: - IB Actions
    @IBAction private func singleAnswerButtonTapped(_ sender: UIButton) {
        
        guard let buttonIndex = singleButtons.firstIndex(of: sender) else { return }
        let currentAnswer = currentAnswers[buttonIndex]
        // Save single answers
        selectedAnswers.append(currentAnswer)
        nextQuestion()
    }
    
    @IBAction private func multipleButtonAnswerTapped() {
        
        for (multipleSwitch, answer) in zip(multipleSwitches, currentAnswers) {
            if multipleSwitch.isOn {
                // Save muliptle answers
                selectedAnswers.append(answer)
            }
        }
        
        nextQuestion()
    }
    
    @IBAction private func rangedAnswerButtonTapped() {
        
        let index = lrintf(rangedSlider.value)
        // Save ranged answers
        selectedAnswers.append(currentAnswers[index])
        
        var chars: [Character] = []
        
        for animals in selectedAnswers.sorted(
            by: {
                $0.animal.rawValue < $1.animal.rawValue }) {
            
            chars.append(animals.animal.rawValue)

            var dogCount = 0
            var catCount = 0
            var rabbitCount = 0
            var turtleCount = 0
            
            print(chars.count)
            
            for itarations in 0..<chars.count {
                if chars[itarations] == Animal.dog.rawValue {
                    dogCount += 1
                } else if chars[itarations] == Animal.cat.rawValue {
                    catCount += 1
                } else if chars[itarations] == Animal.rabbit.rawValue {
                    rabbitCount += 1
                } else if chars[itarations] == Animal.turtle.rawValue {
                    turtleCount += 1
                }
            }
            
            if dogCount > catCount &&
                dogCount > rabbitCount &&
                dogCount > turtleCount {
                print("Dog \(dogCount) \(Animal.dog.definition)")
            } else if catCount > dogCount &&
                        catCount > rabbitCount &&
                        catCount > turtleCount {
                print("Cat \(catCount) \(Animal.cat.definition)")
            } else if rabbitCount > dogCount &&
                        rabbitCount > catCount &&
                        rabbitCount > turtleCount {
                print("Rabbit \(rabbitCount) \(Animal.rabbit.definition)")
            } else  {
                print("Turtle \(turtleCount) \(Animal.turtle.definition)")
            }
        }
        
        print(chars)
        
        nextQuestion()
        
    }
}


// MARK: - Private methods
private extension QuestionsViewController {
    // Update UI
    func updateUI() {
        // Hide all
        for stackView in [singleStackView, multipleStackView, rangedStackView] {
            stackView?.isHidden = true
        }
        
        // Set navigation title
        title = "Вопрос № \(questionIndex + 1) из \(questions.count)"
        
        // Get current question
        let currentQuestion = questions[questionIndex]
        
        // Set current question for question label
        questionLabel.text = currentQuestion.title
        
        // Calculate current progress
        let currentProgress = Float(questionIndex) / Float(questions.count)
        
        // Set current progress for progressView
        questionProgressView.setProgress(currentProgress, animated: true)
        
        showCurrentAnswers(for: currentQuestion.category)
        
    }
    
    func showCurrentAnswers(for category: Category) {
        switch category {
        case .single: showSingleStackView(with: currentAnswers)
        case .multiple: showMultipleStackView(with: currentAnswers)
        case .ranged: showRangedStackView(with: currentAnswers)
        }
    }
    
    func showSingleStackView(with answers: [Answer]) {
        singleStackView.isHidden.toggle()
        
        for (button, answer) in zip(singleButtons, answers) {
            button.setTitle(answer.title, for: .normal)
        }
    }
    
    func showMultipleStackView(with answers: [Answer]) {
        multipleStackView.isHidden.toggle()
        
        for (label, answer) in zip(multipleLabels, answers) {
            label.text = answer.title
        }
    }
    
    func showRangedStackView(with answers: [Answer]) {
        rangedStackView.isHidden.toggle()
        
        rangedLabels.first?.text = answers.first?.title
        rangedLabels.last?.text = answers.last?.title
    }
    
    func nextQuestion() {
        questionIndex += 1
        
        if questionIndex < questions.count {
            updateUI()
            return
        }
        // Переход по сигвэю программно
        performSegue(withIdentifier: "showResult", sender: nil)
    }
}
