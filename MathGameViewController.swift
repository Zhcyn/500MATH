//
//  MathGameViewController.swift
//  Math4Kids
//
//  Created by summer on 2019/7/30.
//  Copyright © 2019 summer. All rights reserved.
//

import UIKit

enum GameMode: CaseIterable {
    case addition
    case subtraction
    case multiplication
    case division
    
    var operatorString: String {
        switch self {
        case .addition: return "+"
        case .subtraction: return "-"
        case .multiplication: return "x"
        case .division: return "÷"
        }
    }
}


enum QuizType {
    case timed
    case questionCount
}

class MathGameViewController: MathBaseViewController {
    
    // MARK: - Outlets
    
    @IBOutlet var beginEndLabel: UILabel!
    @IBOutlet var endOKButton: CustomButtom!
    @IBOutlet var quitButton: UIButton!
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var answer1Button: UIButton!
    @IBOutlet var answer2Button: UIButton!
    @IBOutlet var answer3Button: UIButton!
    @IBOutlet var answer4Button: UIButton!
    @IBOutlet var scoreLabel: UILabel!
    
    
    
    // MARK: - Properties
    
    var isRandomMode = false
    var gameMode: GameMode = .addition
    var quizType: QuizType = .timed
    
    var firstNumber = 0
    var secondNumber = 0
    var correctAnswer = 0
    var answer1 = 0
    var answer2 = 0
    var answer3 = 0
    var answer4 = 0
    var answerArray: [Int] = []
    var totalCorrect = 0
    var totalAnswered = 0
    
    
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    
    
    // MARK: - Setup & Tear Down
    
    func setupUI() {
        beginEndLabel.font = UIFont(name: FontNames.chalkduster, size: 50.0)
        beginEndLabel.adjustsFontSizeToFitWidth = true
        beginEndLabel.textColor = .white
        
        endOKButton.isHidden = true
        endOKButton.titleLabel?.font = UIFont(name: FontNames.chalkduster, size: 50.0)
        endOKButton.transform = CGAffineTransform(translationX: 0, y: 200)
        endOKButton.layer.cornerRadius = 25
        
        hideGameButtons()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.showGame()
        }
    }
    
    
    func hideGameButtons() {
        quitButton.isHidden = true
        questionLabel.isHidden = true
        answer1Button.isHidden = true
        answer2Button.isHidden = true
        answer3Button.isHidden = true
        answer4Button.isHidden = true
        scoreLabel.isHidden = true
        
        switch quizType {
        case .timed:
            beginEndLabel.text = """
            1 minute...
            
            Go!
            """
        case .questionCount:
            beginEndLabel.text = """
            10 questions...
            
            Good luck!
            """
        }
    }
    
    
    func showGame() {
        beginEndLabel.isHidden = true
        
        quitButton.isHidden = false
        questionLabel.isHidden = false
        answer1Button.isHidden = false
        answer2Button.isHidden = false
        answer3Button.isHidden = false
        answer4Button.isHidden = false
        scoreLabel.isHidden = false
        
        quitButton.titleLabel?.font = UIFont(name: FontNames.chalkduster, size: 20.0)
        quitButton.tintColor = .white
        
        questionLabel.font = UIFont(name: FontNames.chalkduster, size: 80.0)
        questionLabel.adjustsFontSizeToFitWidth = true
        questionLabel.textColor = .white
        
        scoreLabel.font = UIFont(name: FontNames.chalkduster, size: 20.0)
        scoreLabel.textColor = .white
        
        scoreLabel.text = "0 / 0"
        updateQuestion()
        updateAnswers()
        
        answerArray = [answer1, answer2, answer3, answer4]
        
        if quizType == .timed {
            DispatchQueue.main.asyncAfter(deadline: .now() + 60) {
                self.hideGameButtons()
                self.endGame()
            }
        }
    }
    
    
    func endGame() {
        beginEndLabel.text = """
        You got:
        \(totalCorrect) right
        \(totalAnswered - totalCorrect) wrong
        """
        
        beginEndLabel.isHidden = false
        endOKButton.isHidden = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: [], animations: {
                self.endOKButton.transform = .identity
            })
        }
    }
    
    
    
    // MARK: - Game Logic Methods
    
    func check(_ selectedAnswer: Int) {
        let isCorrect = correctAnswer == selectedAnswer
        updateScore(isCorrect: isCorrect)
    }
    
    
    func updateScore(isCorrect: Bool) {
        if isCorrect {
            totalCorrect += 1
        }
        
        totalAnswered += 1
        
        let rightWrongText = isCorrect ? "Right!" : "Wrong!"
        let rightWrongColor: UIColor = isCorrect ? Colors.rightLabelColor : Colors.wrongLabelColor
        
        
        let rightWrongLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        rightWrongLabel.textAlignment = .center
        rightWrongLabel.textColor = rightWrongColor
        rightWrongLabel.font = UIFont(name: FontNames.chalkduster, size: 80.0)
        rightWrongLabel.shadowColor = .white
        rightWrongLabel.adjustsFontSizeToFitWidth = true
        rightWrongLabel.text = rightWrongText
        rightWrongLabel.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        view.addSubview(rightWrongLabel)
        
        UIView.animate(withDuration: 1, animations: {
            rightWrongLabel.transform = CGAffineTransform(scaleX: 1, y: 1)
            rightWrongLabel.transform = CGAffineTransform(translationX: 0, y: -150)
        }) { _ in
            rightWrongLabel.removeFromSuperview()
        }
        
        
        scoreLabel.text = "\(totalCorrect) / \(totalAnswered)"
    }
    
    
    func updateQuestion() {
        firstNumber = Int.random(in: 1...500)
        secondNumber = Int.random(in: 1...500)
        
        switch gameMode {
        case .addition:
            correctAnswer = firstNumber + secondNumber
            
        case .subtraction:
            if firstNumber < secondNumber {
                swap(&firstNumber, &secondNumber)
            }
            correctAnswer = firstNumber - secondNumber
            
        case .multiplication:
            correctAnswer = firstNumber * secondNumber
            
        case .division:
            firstNumber *= secondNumber
            correctAnswer = firstNumber / secondNumber
        }
        
        questionLabel.text = """
        What is...
        \(firstNumber) \(gameMode.operatorString) \(secondNumber)
        """
    }
    
    
    func updateAnswers() {
        var answers = [correctAnswer]
        var randomAnswer = 0
        
        while answers.count < 4 {
            repeat {
                randomAnswer = Int.random(in: (correctAnswer - 5)...(correctAnswer + 5))
            } while answers.contains(randomAnswer)
            
            answers.append(randomAnswer)
        }
        
        answers.shuffle()
        
        answer1 = answers[0]
        answer2 = answers[1]
        answer3 = answers[2]
        answer4 = answers[3]
        
        answerArray = answers
        
        answer1Button.setTitle(String(answer1), for: .normal)
        answer2Button.setTitle(String(answer2), for: .normal)
        answer3Button.setTitle(String(answer3), for: .normal)
        answer4Button.setTitle(String(answer4), for: .normal)
    }
    
    
    
    // MARK: - Actions
    
    @IBAction func quit(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    
    @IBAction func tapAnswer(_ sender: UIButton) {
        let selectedAnswer = answerArray[sender.tag]
        
        check(selectedAnswer)
        
        if quizType == .questionCount && totalAnswered == 10 {
            self.hideGameButtons()
            self.endGame()
        }
        
        if isRandomMode {
            gameMode = GameMode.allCases.randomElement()!
        }
        
        updateQuestion()
        updateAnswers()
    }
}
