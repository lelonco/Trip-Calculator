//
//  CalcKeyboard.swift
//  TripCalculator
//
//  Created by Yaroslav on 19.10.2019.
//  Copyright © 2019 Yaroslav. All rights reserved.
//

import UIKit

class CalcKeyboard: UIView {
    
    var inputLabel: UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        self.translatesAutoresizingMaskIntoConstraints = false
        let numKeyboard = CalcNumKeyboard(delAction: delAction, numAction: numAction)
        let actionsKeyboard = CalcActionKeyboard(enterAction: enterAction, defAction: numAction)
        
        self.addSubview(numKeyboard)
        self.addSubview(actionsKeyboard)
        
        NSLayoutConstraint.activate([
            numKeyboard.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            numKeyboard.heightAnchor.constraint(equalTo: self.heightAnchor),
            actionsKeyboard.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            actionsKeyboard.heightAnchor.constraint(equalTo: self.heightAnchor),
//            actionsKeyboard.widthAnchor.constraint(equalTo: self.widthAnchor)
        ])
    }
    
    func numAction(sender:UIButton) {
        if inputLabel?.text?.count == 1 && inputLabel?.text?.first == "0" {
            inputLabel?.text? = sender.titleLabel?.text ?? "0"
        } else {
            inputLabel?.text?.append(sender.titleLabel?.text ?? "")
        }
    }
    
    func delAction(sender:UIButton) {
        if inputLabel?.text?.count ?? 0 > 1  {
            _ = inputLabel?.text?.removeLast()
        } else {
            inputLabel?.text? = "0"
        }
    }
    func enterAction(sender: UIButton) {
        print("Enter")
    }

}
