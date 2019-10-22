//
//  CalcButton.swift
//  TripCalculator
//
//  Created by Yaroslav on 19.10.2019.
//  Copyright © 2019 Yaroslav. All rights reserved.
//

import UIKit

enum SizeOfButton {
    case square
    case largeHorizontal
    case largeVertical
}

class CalcButton: UIButton {
    
    let size:CGFloat = 50
    let largeSize:CGFloat = 115
        
//    var button = UIButton()
    var actionBlock:((_:UIButton) -> Void)?

    init(with title:String, size:SizeOfButton, actionBlock:@escaping (_:UIButton)->()) {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.setTitle(title, for: .normal)
        self.actionBlock = actionBlock
        
        switch size {
            case .square:
                self.heightAnchor.constraint(equalToConstant: self.size).isActive = true
                self.widthAnchor.constraint(equalToConstant: self.size).isActive = true
            case .largeHorizontal:
                self.heightAnchor.constraint(equalToConstant: self.size).isActive = true
                self.widthAnchor.constraint(equalToConstant: self.largeSize).isActive = true
            case .largeVertical:
                self.heightAnchor.constraint(equalToConstant: self.largeSize).isActive = true
                self.widthAnchor.constraint(equalToConstant: self.size).isActive = true
        }
        self.layer.cornerRadius = self.size / 2
        
        self.addTarget(self, action: #selector(executeBlock), for: .touchUpInside)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    func executeBlock(sender: UIButton) {
        actionBlock?(sender)
    }
    
}


