//
//  CalcKeyboard.swift
//  TripCalculator
//
//  Created by Yaroslav on 19.10.2019.
//  Copyright © 2019 Yaroslav. All rights reserved.
//

import UIKit

class CalcNumKeyboard: UIView {
    
    let spacing:CGFloat = 15
    
    let defColor:UIColor = .init(hex: 0x474C50)

    
    var keyboardButtonsList = Array<CalcButton>()
    let stackView = UIStackView()
    var delAction: ((_: UIButton) -> ())?
    var numAction: ((_: UIButton) -> ())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(delAction: @escaping (_:UIButton) ->(), numAction: @escaping (_:UIButton) -> ()) {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.delAction = delAction
        self.numAction = numAction
        
        createButtons()
        createStackView()
        
        self.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.widthAnchor.constraint(equalTo: self.widthAnchor),
            stackView.heightAnchor.constraint(equalTo: self.heightAnchor)
        ])
    }
    
    func createButtons() {
        
        for i in 0 ... 9 {
            let button = CalcButton(with:"\(i)", size: .square, actionBlock: numActionBlock)
            button.backgroundColor = defColor
            keyboardButtonsList.append(button)
        }
        
        let dotButton = CalcButton(with:".", size: .square, actionBlock: numActionBlock)
        dotButton.backgroundColor = defColor
        let delButton = CalcButton(with:"", size: .square, actionBlock: delActionBlock)
        delButton.backgroundColor = defColor
        
        keyboardButtonsList.insert(delButton, at: 1)
        keyboardButtonsList.insert(dotButton, at: 1)

    }
    
    func delActionBlock(sender: UIButton) {
        delAction?(sender)
    }
    
    func numActionBlock(sender: UIButton) {
        numAction?(sender)
    }
    
    func createStackView() {
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = spacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        var i = 0
        for _ in 0...3 {
            let arrangedView = UIStackView()
            arrangedView.axis = .horizontal
            arrangedView.distribution = .fillEqually
            arrangedView.spacing = spacing
            for _ in 0...2 {
                arrangedView.addArrangedSubview(keyboardButtonsList[i])
                i += 1
            }
            stackView.addArrangedSubview(arrangedView)
        }
    }
    
}
