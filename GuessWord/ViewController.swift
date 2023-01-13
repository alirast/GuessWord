//
//  ViewController.swift
//  GuessWord
//
//  Created by n on 22.08.2022.
//

import UIKit

class ViewController: UIViewController {
//MARK: - properties
    var levelLabel: UILabel!
    var correctLabel: UILabel!
    var wrongLabel: UILabel!
    var currentAnswer: UITextField!
    var gameName: UILabel!
    var charButtons = [UIButton]()
    var positiveEmoji: UILabel!
    var negativeEmoji: UILabel!
    
    var wordToGuess = "guess"
    
    var keyboard = "abcdefghijklmnopqrstuvwxyz"
    
    var level = 1 {
        willSet {
            levelLabel.text = "Level: \(newValue)"
        }
    }
    var correctAnswerScore = 0 {
        willSet {
            correctLabel.text = "Correct guesses: \(newValue)"
        }
    }
    var wrongAnswerScore = 0 {
        willSet {
            wrongLabel.text = "Wrong guesses: \(newValue)"
        }
    }
//MARK: - loadView
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
//MARK: - addingGameNameLabel
        gameName = UILabel()
        gameName.translatesAutoresizingMaskIntoConstraints = false
        gameName.textAlignment = .center
        gameName.text = "Make me smile"
        gameName.font = UIFont.systemFont(ofSize: 44)
        view.addSubview(gameName)
        
//MARK: - addingLevelLabel
        levelLabel = UILabel()
        levelLabel.translatesAutoresizingMaskIntoConstraints = false
        levelLabel.textAlignment = .right
        levelLabel.text = "Level: 1"
        levelLabel.font = UIFont.systemFont(ofSize: 25)
        view.addSubview(levelLabel)
        
//MARK: - addingCorrectGuessLabel
        correctLabel = UILabel()
        correctLabel.translatesAutoresizingMaskIntoConstraints = false
        correctLabel.font = UIFont.systemFont(ofSize: 25)
        correctLabel.text = "Correct guesses: \(correctAnswerScore)"
        view.addSubview(correctLabel)
        
//MARK: - addingWrongGuessLabel
        wrongLabel = UILabel()
        wrongLabel.translatesAutoresizingMaskIntoConstraints = false
        wrongLabel.font = UIFont.systemFont(ofSize: 25)
        wrongLabel.text = "Wrong guesses: \(wrongAnswerScore)"
        view.addSubview(wrongLabel)
        
//MARK: - addingPositiveEmojiLabel
        positiveEmoji = UILabel()
        positiveEmoji.translatesAutoresizingMaskIntoConstraints = false
        positiveEmoji.text = "😐"
        positiveEmoji.font = UIFont.systemFont(ofSize: 140)
        view.addSubview(positiveEmoji)
        
//MARK: - addingNegativeEmojiLabel
        negativeEmoji = UILabel()
        negativeEmoji.translatesAutoresizingMaskIntoConstraints = false
        negativeEmoji.text = "😐"
        negativeEmoji.font = UIFont.systemFont(ofSize: 140)
        view.addSubview(negativeEmoji)
        
//MARK: - addingCurrentAnswer
        currentAnswer = UITextField()
        currentAnswer.translatesAutoresizingMaskIntoConstraints = false
        currentAnswer.text = String.init(repeating: "*", count: wordToGuess.count)
        currentAnswer.textAlignment = .center
        currentAnswer.font = UIFont.systemFont(ofSize: 50)
        currentAnswer.isUserInteractionEnabled = false
        view.addSubview(currentAnswer)
        
//MARK: - addingKeyboard
        let characterButtonsGroup = UIView()
        characterButtonsGroup.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(characterButtonsGroup)
        
        NSLayoutConstraint.activate([
//MARK: - constraintsForGameNameLabel
            gameName.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            gameName.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            gameName.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.5),
            
//MARK: - constraintsForLevelLabel
            levelLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            levelLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            
//MARK: - constraintsForCorrectLabel
            correctLabel.topAnchor.constraint(equalTo: gameName.bottomAnchor, constant: 30),
            correctLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 80),
            
//MARK: - constraintsForWrongLabel
            wrongLabel.topAnchor.constraint(equalTo: gameName.bottomAnchor, constant: 30),
            wrongLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -80),
            wrongLabel.heightAnchor.constraint(equalTo: correctLabel.heightAnchor),
            
//MARK: - constraintsForPositiveEmoji
            positiveEmoji.topAnchor.constraint(equalTo: correctLabel.bottomAnchor, constant: 50),
            positiveEmoji.centerXAnchor.constraint(equalTo: correctLabel.centerXAnchor),
            
//MARK: - constraintsForNegativeEmoji
            negativeEmoji.topAnchor.constraint(equalTo: wrongLabel.bottomAnchor, constant: 50),
            negativeEmoji.centerXAnchor.constraint(equalTo: wrongLabel.centerXAnchor),
            negativeEmoji.heightAnchor.constraint(equalTo: positiveEmoji.heightAnchor),
            
//MARK: - constraintsForCurrentAnswer
            currentAnswer.topAnchor.constraint(equalTo: gameName.bottomAnchor, constant: 500),
            currentAnswer.centerXAnchor.constraint(equalTo: gameName.centerXAnchor),
            
//MARK: - constraintsForKeyboard
            characterButtonsGroup.widthAnchor.constraint(equalToConstant: 650),
            characterButtonsGroup.heightAnchor.constraint(equalToConstant: 320),
            characterButtonsGroup.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            characterButtonsGroup.topAnchor.constraint(equalTo: currentAnswer.bottomAnchor, constant: 30),
            characterButtonsGroup.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -20)
        ])
        
//MARK: - keyboardSetting
        let width = 50
        let height = 100
        
        for row in 0..<2 {
            for column in 0..<13 {
                let letterButton = UIButton(type: .system)
                letterButton.tintColor = .black
                
                letterButton.titleLabel?.font = UIFont.systemFont(ofSize: 36)
                letterButton.setTitle("W", for: .normal)
                
                letterButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
                let frame = CGRect(x: column * width, y: row * height, width: width, height: height)
                letterButton.frame = frame
                characterButtonsGroup.addSubview(letterButton)
                charButtons.append(letterButton)
            }
        }
        
        for (index, character) in keyboard.enumerated() {
            charButtons[index].setTitle(String(character).uppercased(), for: .normal)
        }
    }
    
//MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        startGame()
    }
    
//MARK: - startGameFunc
    func startGame() {
        level = 1
        wrongAnswerScore = 0
        correctAnswerScore = 0
        changeNegativeEmoji()
        changePositiveEmoji()
        loadWord()
    }
//MARK: - loadWordFunc
    func loadWord() {
        if let wordFileURL = Bundle.main.url(forResource: "words", withExtension: "txt") {
            if let content = try? String(contentsOf: wordFileURL) {
                var lines = content.components(separatedBy: "\n")
                
                if level == lines.count {
                    let ac = UIAlertController(title: "Win!", message: "You made me smile.", preferredStyle: .alert)
                    ac.addAction(UIAlertAction(title: "OK", style: .cancel) {
                        [weak self] _ in
                        self?.startGame()
                    })
                    ac.addAction(UIAlertAction(title: "Play again", style: .default) {
                        [weak self] _ in
                        self?.startGame()
                    })
                    present(ac, animated: true)
                }
                
                wordToGuess = lines[level - 1]
                
                for button in charButtons {
                    button.tintColor = .black
                }
                currentAnswer.text = String.init(repeating: "*", count: wordToGuess.count)
            }
        }
    }
    
//MARK: - buttonTappedFunc
    @objc func buttonTapped(_ sender: UIButton) {
        guard let character = sender.titleLabel?.text else { return }
        
        if wordToGuess.contains(character.lowercased()) {
            var lines = currentAnswer.text?.map { $0.uppercased() }
            
            for (index, item) in wordToGuess.enumerated() {
                if String(item) == character.lowercased() {
                    lines![index] = character.uppercased()
                }
            }

            currentAnswer.text = lines?.joined()
            sender.tintColor = .green
            
            if currentAnswer.text?.lowercased() == wordToGuess {
                level += 1
                correctAnswerScore += 1
                wrongAnswerScore = 0
                changePositiveEmoji()
                changeNegativeEmoji()
                loadWord()
            }
        } else {
            wrongAnswerScore += 1
            sender.tintColor = .red
            changeNegativeEmoji()
        }
        
        if wrongAnswerScore > 6 {
            let ac = UIAlertController(title: "Lose", message: "You made me angry.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Try again", style: .default) { [weak self] _ in
                self?.wrongAnswerScore = 0
                self?.changeNegativeEmoji()
                self?.loadWord()
            })
            present(ac, animated: true)
        }
    }
    
//MARK: - changePositiveEmojiFunc
    func changePositiveEmoji() {
        switch correctAnswerScore {
        case 1:
            positiveEmoji.text = "😏"
        case 2:
            positiveEmoji.text = "🙃"
        case 3:
            positiveEmoji.text = "🙂"
        case 4:
            positiveEmoji.text = "😌"
        case 5:
            positiveEmoji.text = "😉"
        case 6:
            positiveEmoji.text = "😊"
        case 7:
            positiveEmoji.text = "😃"
        case 8...10:
            positiveEmoji.text = "☺️"
        default:
            positiveEmoji.text = "😐"
        }
    }
    
//MARK: - setNegativeEmojiFunc
    func changeNegativeEmoji() {
        switch wrongAnswerScore {
        case 1:
            negativeEmoji.text = "😕"
        case 2:
            negativeEmoji.text = "🙁"
        case 3:
            negativeEmoji.text = "☹️"
        case 4:
            negativeEmoji.text = "😣"
        case 5:
            negativeEmoji.text = "😓"
        case 6...10:
            negativeEmoji.text = "😠"
        default:
            negativeEmoji.text = "😐"
        }
    }
}
