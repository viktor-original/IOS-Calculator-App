//
//  ViewController.swift
//  Lesson#11.2 HW(Calculator)
//
//  Created by Viktor Krasilnikov on 27.04.22.
//

import UIKit

enum CalcAction: String {
    case zero = "0"
    case plus = "+"
    case minus = "-"
    case div = "/"
    case multi = "*"
    case percent
    case sign
}

class ViewController: UIViewController {
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var displayLabel: UILabel!
    @IBOutlet weak var clearAllButton: RoundButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayLabel.text = "0"
    }
    
    var firstNumber: Double?
    var secondNumber: Double?
    var result: Double?
    var commaUsed = false
    var newOperation = true
    var currentCalcAction:CalcAction = .zero
    

    @IBAction func numberTapped(_ sender: RoundButton) {
        guard var textNumber = displayLabel.text else { return }
        if textNumber.count <= 8 || (commaUsed && textNumber.count <= 9) {
            if newOperation {
                textNumber = ""
                newOperation = false
            }
        textNumber += "\(sender.tag)"
        displayLabel.text = textNumber
        }
    }
    
    @IBAction func commaTapped(_ sender: RoundButton) {
        if !commaUsed && displayLabel.text?.count ?? 0 <= 10 {
            guard var textNumberWithComma = displayLabel.text else { return }
            textNumberWithComma += "."
            displayLabel.text = textNumberWithComma
            commaUsed = true
        }
    }
        
    
    @IBAction func equalsTapped(_ sender: RoundButton) {
        
        secondNumber = Double(displayLabel.text!)
        
        switch currentCalcAction {
        case .div:
            result = firstNumber! / secondNumber!
        case .multi:
            result = firstNumber! * secondNumber!
        case .minus:
            result = firstNumber! - secondNumber!
        case .plus:
            result = firstNumber! + secondNumber!
        default:
            result = 0
        }
        
        if result!.truncatingRemainder(dividingBy: 1) == 0 {
            displayLabel.text = String(Int(result!))
            newOperation = true
            commaUsed = false
        } else {
            displayLabel.text = String(result!)
            newOperation = true
            commaUsed = true
        }
    }
    
    @IBAction func plusTapped(_ sender: RoundButton) {
        calcAction(action: .plus)
    }
    
    @IBAction func minusTapped(_ sender: RoundButton) {
        calcAction(action: .minus)
    }
    
    @IBAction func multiplyTapped(_ sender: RoundButton) {
        firstNumber = Double(displayLabel.text!)
        newOperation = true
        commaUsed = false
        currentCalcAction = .multi
    }
    
    @IBAction func divideTapped(_ sender: RoundButton) {
        firstNumber = Double(displayLabel.text!)
        newOperation = true
        commaUsed = false
        currentCalcAction = .div
    }
    
    @IBAction func clearTapped(_ sender: RoundButton) {
        displayLabel.text = "0"
        firstNumber = 0
        secondNumber = 0
        result = 0
        commaUsed = false
        newOperation = true
        currentCalcAction = .zero
    }
    
    @IBAction func signTapped(_ sender: RoundButton) {
        guard var textNumber = displayLabel.text else { return }
        let minusChar = "-"
        if textNumber.contains(minusChar) {
           textNumber = textNumber.replacingOccurrences(of: minusChar, with: "")
        } else {
            textNumber = "-" + textNumber
        }
        
        displayLabel.text = textNumber
    }
    
    @IBAction func percentTapped(_ sender: RoundButton) {
        guard var number = Double(displayLabel.text!) else { return }
        number /= 100
        displayLabel.text = String(number)
        newOperation = true
    }
    
    func calcAction(action: CalcAction) {
        firstNumber = Double(displayLabel.text!)
        newOperation = true
        commaUsed = false
        currentCalcAction = action
    }
}

//extension String {
//    static let numberFormatter = NumberFormatter()
//        var doubleValue: Double {
//            String.numberFormatter.decimalSeparator = "."
//            if let result =  String.numberFormatter.number(from: self) {
//                return result.doubleValue
//            } else {
//                String.numberFormatter.decimalSeparator = ","
//                if let result = String.numberFormatter.number(from: self) {
//                    return result.doubleValue
//                }
//            }
//            return 0
//        }
//}
