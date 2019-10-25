//
//  CalcListTableViewCell.swift
//  TripCalculator
//
//  Created by Yaroslav on 22.10.2019.
//  Copyright © 2019 Yaroslav. All rights reserved.
//

import UIKit


protocol CalcListTableViewCellDelegate: class {
    
    func markerViewTaped(cell: CalcListTableViewCell)
}

class  CalcListTableViewCell: UITableViewCell {
    
    weak var delegate: CalcListTableViewCellDelegate?
    
    let markerColor = UIColor(hex: 0xB8B8B8)
    let sourceTextColor = UIColor(hex: 0xD8D8D8)
    let cellBackgroundColor = UIColor(hex: 0x474C50)
    let rowStackView = UIStackView()
    
    let markerView = UILabel()
    var sourceTextLabel = UILabel()
    
    func configure(with text: String) {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        sourceTextLabel.text = text
        sourceTextLabel.textColor = sourceTextColor
        sourceTextLabel.textAlignment = .right
        
        let tapMarker = UITapGestureRecognizer(target: self, action: #selector(markerViewTaped))
        
        markerView.text = "x"
        markerView.textColor = markerColor
        markerView.isUserInteractionEnabled = true
        markerView.addGestureRecognizer(tapMarker)
        
        rowStackView.axis = .horizontal
        rowStackView.distribution = .equalCentering
        rowStackView.translatesAutoresizingMaskIntoConstraints = false
        [markerView, sourceTextLabel].forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false
//            self.contentView.addSubview($0)
            rowStackView.addArrangedSubview($0)
        })
        contentView.addSubview(rowStackView)
        contentView.backgroundColor = cellBackgroundColor
        NSLayoutConstraint.activate([
            rowStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            rowStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            rowStackView.heightAnchor.constraint(equalTo: contentView.heightAnchor),
        ])
    }
    
    @objc
    func markerViewTaped() {
        delegate?.markerViewTaped(cell:self)
    }
}
