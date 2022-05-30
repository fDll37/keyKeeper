//
//  MainView.swift
//  keyKeeper
//
//  Created by Данил Менделев on 30.05.2022.
//

import UIKit

class MainView: UIView {
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 30
        button.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        button.layer.backgroundColor = UIColor.green.cgColor
        return button
    }()
    
    private lazy var tableOfKeys: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.dataSource = self
        return table
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        addSubview(button)
        addSubview(tableOfKeys)
        
        NSLayoutConstraint.activate([
            tableOfKeys.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableOfKeys.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            tableOfKeys.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            tableOfKeys.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -20),
            
            button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            button.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            button.heightAnchor.constraint(equalToConstant: 60),
            button.widthAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    
}



// MARK: - UITableViewDelegate
extension MainView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}


// MARK: - UITableViewDataSource
extension MainView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        UITableViewCell()
    }
}
