//
//  CalcKeyboard.swift
//  TripCalculator
//
//  Created by Yaroslav on 19.10.2019.
//  Copyright © 2019 Yaroslav. All rights reserved.
//

import UIKit

protocol CalcKeyboardDelegate: class {
    func insertIntoList()
    func insertIntoInput(text: String)
}

class CalcKeyboard: UIView {
    
    var inputLabel: UILabel?
    weak var delegate:CalcKeyboardDelegate?
    
    var actionsKeyboard = CalcActionKeyboard()
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        self.translatesAutoresizingMaskIntoConstraints = false
        let numKeyboard = CalcNumKeyboard(delAction: delAction, numAction: numAction, dotAction: actionForAction)
        actionsKeyboard = CalcActionKeyboard(enterAction: enterAction, defAction: actionForAction)
        
        let bracketsStack = UIStackView()

        let leftBrackets = UIButton()
        let rightBrackets = UIButton()
        leftBrackets.setTitle("[", for: .normal)
        rightBrackets.setTitle("]", for: .normal)
        [leftBrackets,rightBrackets].forEach({ (bracket) in
            bracket.layer.cornerRadius = 5
            bracket.layer.borderColor = UIColor(hex: 0x5D656B).cgColor
            bracket.layer.borderWidth = 1
            bracket.addTarget(self, action: #selector(bracketsAction), for: .touchUpInside)
            bracketsStack.addArrangedSubview(bracket)
        })
        bracketsStack.axis = .horizontal
        bracketsStack.spacing = 9
        bracketsStack.distribution = .fillProportionally
        bracketsStack.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(bracketsStack)
        self.addSubview(numKeyboard)
        self.addSubview(actionsKeyboard)

        
        NSLayoutConstraint.activate([
            bracketsStack.topAnchor.constraint(equalTo: self.topAnchor),
            bracketsStack.widthAnchor.constraint(equalTo: self.widthAnchor),
            numKeyboard.topAnchor.constraint(equalTo: bracketsStack.bottomAnchor, constant: 22),
            numKeyboard.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            actionsKeyboard.topAnchor.constraint(equalTo: numKeyboard.topAnchor),
            actionsKeyboard.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            actionsKeyboard.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
        
    }
    @objc
    func numAction(sender:UIButton) {
        if inputLabel?.text?.count == 1 && inputLabel?.text?.first == "0" {
            inputLabel?.text? = sender.titleLabel?.text ?? "0"
        } else {
            inputLabel?.text?.append(sender.titleLabel?.text ?? "")
        }
    }
    @objc
    func bracketsAction(sender:UIButton) {
        if inputLabel?.text?.count == 1 && inputLabel?.text?.first == "0" {
            var senderText = sender.titleLabel?.text
            if senderText == "]" {
                return
            }
            
            senderText?.append(inputLabel?.text ?? "")
            inputLabel?.text = senderText
        } else {
            if isPreviousBracketOrAction() {
                return
            }
            inputLabel?.text?.append(sender.titleLabel?.text ?? "")
        }
    }
    
    func actionForAction(sender:UIButton) {
        if isPreviousAction() { return }
        inputLabel?.text?.append(sender.titleLabel?.text ?? "")
    }
    
    func delAction(sender:UIButton) {
        if inputLabel?.text?.count == 2 && inputLabel?.text?.first == "[" {
            inputLabel?.text? = "0"
        } else if inputLabel?.text?.count ?? 0 > 1  {
            _ = inputLabel?.text?.removeLast()
        } else {
            inputLabel?.text? = "0"
        }
    }
    func enterAction(sender: UIButton) {
        delegate?.insertIntoList()
    }
    
    func isPreviousBracketOrAction() ->Bool {
        return inputLabel?.text?.last == "]" || isPreviousAction()
    }
    
    func isPreviousAction() -> Bool {
        let lastCh =  String(inputLabel?.text?.last ?? Character(""))
        return actionsKeyboard.actionTitlesArray.contains(lastCh) || lastCh == "."
    }

}
