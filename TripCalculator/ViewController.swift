//
//  ViewController.swift
//  TripCalculator
//
//  Created by Yaroslav on 19.10.2019.
//  Copyright © 2019 Yaroslav. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let backgroundCOlor = UIColor(hex: 0x474C50)
    let markerColor = UIColor(hex: 0xB8B8B8)
    let textViewtextcolor = UIColor(hex: 0xD8D8D8)
    var bracketsStack = UIStackView()
    
    override func loadView() {
        super.loadView()
        self.view.translatesAutoresizingMaskIntoConstraints = false
        
        let leftBrackets = UIButton()
        let rightBrackets = UIButton()
        
        let inputLabel = UILabel()
        
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
        self.view.addSubview(bracketsStack)
        
        inputLabel.textAlignment = .right
        inputLabel.textColor = textViewtextcolor
        inputLabel.text = "0"
        inputLabel.font = .monospacedDigitSystemFont(ofSize: 14, weight: .regular)
        let markerView = UILabel()
        markerView.text = "x"
        markerView.textColor = markerColor
        
        let inputRow = UIStackView(arrangedSubviews: [markerView, inputLabel])
        inputRow.axis = .horizontal
        inputRow.distribution = .equalCentering
        inputRow.subviews.forEach({ $0.translatesAutoresizingMaskIntoConstraints = false })
        inputRow.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(inputRow)
        
        let keyboard = CalcKeyboard()
        keyboard.setup()
        keyboard.inputLabel = inputLabel
        self.view.addSubview(keyboard)
        NSLayoutConstraint.activate([
            
            keyboard.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 32),
            keyboard.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -32),
            keyboard.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -67),
            keyboard.heightAnchor.constraint(equalToConstant: 245),
            
            bracketsStack.bottomAnchor.constraint(equalTo: keyboard.topAnchor, constant: -22),
            bracketsStack.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 32),
            bracketsStack.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -32),
            bracketsStack.heightAnchor.constraint(equalToConstant: 31),
            
            inputRow.bottomAnchor.constraint(equalTo: bracketsStack.topAnchor, constant: -31),
            inputRow.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 32),
            inputRow.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -32),

            
        ])
    
        self.view.backgroundColor = backgroundCOlor
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }    

    
    @objc
    func bracketsAction() {
        print("Brackets")
    }
}

