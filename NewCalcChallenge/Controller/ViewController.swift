//
//  ViewController.swift
//  NewCalcChallenge
//
//  Created by Ryan Kanno on 6/17/21.
//

import UIKit

class ViewController: UIViewController {
   @IBOutlet weak var displayView: UIView!
   @IBOutlet weak var displayLabel: UILabel!
   @IBOutlet var gridButtons: [UIButton]!
   private var isFinishedTypingNum: Bool = true
   private var displayValue: Double {
      get {
         guard let number = Double(displayLabel.text!) else {
            fatalError("Unable to convert display label text to Double.")
         }
         return number
      }
      set {
         displayLabel.text = String(newValue)
      }
   }
   private var calculator = CalculatorLogic()
   
   override func viewDidLoad() {
      super.viewDidLoad()
      displayView.layer.borderColor = UIColor.black.cgColor
      displayView.layer.borderWidth = 0.5
      gridButtons.forEach { button in
         button.layer.borderColor = UIColor.black.cgColor
         button.layer.borderWidth = 0.5
      }
      
   }
   
   @IBAction func numbersTapped(_ sender: UIButton) {
      if let numValue = sender.currentTitle {
         if isFinishedTypingNum {
            displayLabel.text = numValue
            isFinishedTypingNum = false
         } else {
            if numValue == "." {
               let isInt = floor(Double(displayValue)) == displayValue
               if !isInt { return }
            }
            displayLabel.text! += numValue
         }
      }
   }
   
   @IBAction func operatorsTapped(_ sender: UIButton) {
      isFinishedTypingNum = true
      calculator.setNumber(displayValue)
      if let calcMethod = sender.currentTitle {         
         if let result = calculator.calculate(symbol: calcMethod) {
            displayValue = result
         }
      }
   }

   
   
}

