//
//  ViewController.swift
//  TripCalculator
//
//  Created by Yaroslav on 19.10.2019.
//  Copyright © 2019 Yaroslav. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let reuseIdentifier = "listItem"
    let backgroundCOlor = UIColor(hex: 0x474C50)
    let markerColor = UIColor(hex: 0xB8B8B8)
    let textViewtextcolor = UIColor(hex: 0xD8D8D8)
    let listTableView = UITableView()
    var list = Array<String>()
    
    let inputLabel = UILabel()
    
    override func loadView() {
        super.loadView()
        self.view.translatesAutoresizingMaskIntoConstraints = false
                        
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
        
        listTableView.delegate = self
        listTableView.dataSource = self
        listTableView.register(CalcListTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        self.view.addSubview(listTableView)
        listTableView.translatesAutoresizingMaskIntoConstraints = false
        listTableView.separatorStyle = .none
        listTableView.backgroundColor = backgroundCOlor
        listTableView.allowsSelection = false
        
        let keyboard = CalcKeyboard()
        keyboard.setup()
        keyboard.inputLabel = inputLabel
        keyboard.delegate = self
        self.view.addSubview(keyboard)
        guard let guide = self.view?.safeAreaLayoutGuide else { return }
        NSLayoutConstraint.activate([
//TODO: Rewrite leading&trailing constraints
            keyboard.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 30),
            keyboard.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -30),
            keyboard.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: -10),

            inputRow.bottomAnchor.constraint(equalTo: keyboard.topAnchor, constant: -31),
            inputRow.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 32),
            inputRow.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -32),

            listTableView.bottomAnchor.constraint(equalTo: inputRow.topAnchor, constant: -16),
            listTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 32),
            listTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -32),
            listTableView.topAnchor.constraint(equalTo: guide.topAnchor)
            
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

extension ViewController: CalcListTableViewCellDelegate {
    func markerViewTaped(cell: CalcListTableViewCell) {
       
        guard let indexPath = self.listTableView.indexPath(for: cell) else { return }
        list.remove(at: indexPath.row)
        listTableView.reloadData()
    }
    
    
}

extension ViewController: UITableViewDelegate {
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! CalcListTableViewCell
        cell.configure(with: list[indexPath.row])
        cell.delegate = self
        cell.contentView.backgroundColor = backgroundCOlor
        return cell
    }
}

extension ViewController: CalcKeyboardDelegate {
    func insertIntoList() {
        list.append(self.inputLabel.text ?? "")
        inputLabel.text = "0"
        listTableView.reloadData()
    }
    
    func insertIntoInput(text: String) {
        //
    }
    
    
    
}

