//
//  ViewController.swift
//  Yuda Ios 2
//
//  Created by ISYS Macbook air 1 on 28/05/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var score = 0 {
        didSet {
            navigationItem.rightBarButtonItem?.title = "Score: \(score)"
        }
    }
    
    var currentQuestion = 0{
        didSet{
            navigationItem.leftBarButtonItem?.title = "\(currentQuestion) / \(finalQuestion)"
        }
    }
    var finalQuestion = 10
    var correctAnswer = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Score: \(score)", style: .plain, target: self, action: nil)
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "\(currentQuestion) / \(finalQuestion)", style: .plain, target: self, action: nil)
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        askQuestion()
    }
    
    func askQuestion(action: UIAlertAction! = nil){
        if currentQuestion == finalQuestion {
            let ac = UIAlertController(title: "GameOver", message: "Your final score is : \(score)", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Try again", style: .default, handler: tryAgain))
            
            present(ac, animated: true)
        } else {
            currentQuestion += 1
            countries.shuffle()
            button1.setImage(UIImage(named: countries[0])?.withRenderingMode(.alwaysOriginal), for: .normal)
            button2.setImage(UIImage(named: countries[1])?.withRenderingMode(.alwaysOriginal), for: .normal)
            button3.setImage(UIImage(named: countries[2])?.withRenderingMode(.alwaysOriginal), for: .normal)
            
            correctAnswer = Int.random(in: 0...2)
            title = countries[correctAnswer].uppercased()
        }
        
    }
    
    func tryAgain(_: UIAlertAction){
        score = 0
        currentQuestion = 0
        askQuestion()
    }
    
    @IBAction func tapButton(_ sender: UIButton) {
        print(sender.tag)
        var title: String
        if currentQuestion <= finalQuestion {

            
            
            
            if sender.tag == correctAnswer {
                title = "Correct!"
                score += 1
                let ac = UIAlertController(title: title, message: "Your score is : \(score)", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
                
                present(ac, animated: true)
            }else{
                title = "Wrong!"
                score -= 1
                let ac = UIAlertController(title: title, message: "Why u choose \(countries[sender.tag].uppercased())?!", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
                
                present(ac, animated: true)
            }
        }
        
        
        
    }
    
    
}

