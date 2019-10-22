//
//  CalcActionKeyboard.swift
//  TripCalculator
//
//  Created by Yaroslav on 19.10.2019.
//  Copyright © 2019 Yaroslav. All rights reserved.
//

import UIKit

class CalcActionKeyboard: UIView {
    
    let actionColor:UIColor = .init(hex: 0x83DADF)
    let enterColor:UIColor = .init(hex: 0xD9F2B4)
    let textColor:UIColor = .init(hex: 0x474C50)
    let spacing:CGFloat = 15
    
    var actionTitlesArray = Array<String>(arrayLiteral: "x", "/", "+", "-", "%")
    var actionButtonsArray = Array<CalcButton>()
    
    var enterAction: ((_: UIButton) -> ())?
    var defAction: ((_: UIButton) -> ())?
    
    var stackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(enterAction: @escaping (_: UIButton) -> (), defAction: @escaping (_: UIButton) -> ()) {
        super.init(frame: .zero)
        self.defAction = defAction
        self.enterAction = enterAction
        
        self.translatesAutoresizingMaskIntoConstraints = false
        createButtons()
        self.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.widthAnchor.constraint(equalTo: self.widthAnchor),
            stackView.heightAnchor.constraint(equalTo: self.heightAnchor)
        ])
    }
    
    func createButtons() {
        let devideButton = CalcButton(with: "/", size: .square, actionBlock: executeDefAction)
        let multiplyButton = CalcButton(with: "x", size: .square, actionBlock: executeDefAction)
        let plusButton = CalcButton(with: "+", size: .largeVertical, actionBlock: executeDefAction)
        let minusButton = CalcButton(with: "-", size: .square, actionBlock: executeDefAction)
        let percentButton = CalcButton(with: "%", size: .square, actionBlock: executeDefAction)
        let enterButton = CalcButton(with:"", size: .largeHorizontal, actionBlock: executeEnterAction)

        [devideButton, plusButton, multiplyButton, percentButton, minusButton].forEach { (button) in
            button.backgroundColor = actionColor
            button.setTitleColor(textColor, for: .normal)
        }
        enterButton.backgroundColor = enterColor
        
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = spacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let firstLine = UIStackView(arrangedSubviews: [devideButton, multiplyButton])
        firstLine.spacing = spacing
        firstLine.axis = .horizontal
        
        let verticalStack = UIStackView(arrangedSubviews: [minusButton, percentButton])
        verticalStack.spacing = spacing
        verticalStack.axis = .vertical
        verticalStack.distribution = .fillProportionally
        let secondStack = UIStackView(arrangedSubviews: [plusButton,verticalStack])
        secondStack.spacing = spacing
        secondStack.distribution = .fillProportionally
        
        stackView.addArrangedSubview(firstLine)
        stackView.addArrangedSubview(secondStack)
        stackView.addArrangedSubview(enterButton)
    }

    func executeEnterAction(sender: UIButton) {
        enterAction?(sender)
    }
    func executeDefAction(sender: UIButton) {
        defAction?(sender)
    }
    
    
}
