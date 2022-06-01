//
//  MainView.swift
//  keyKeeper
//
//  Created by Данил Менделев on 30.05.2022.
//

import UIKit
import CoreData

class MainView: UIView {
    
    var keys: [NSManagedObject] = []
    
    weak var delegate: MainViewProtocolDelegate?
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 30
        button.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        button.layer.backgroundColor = UIColor.green.cgColor
        button.addTarget(self, action: #selector(openAddNewKey), for: .touchUpInside)
        return button
    }()
    
    @objc private func openAddNewKey() {
        delegate?.openAddNewKeyViewController()
    }
    
    private lazy var tableOfKeys: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.dataSource = self
        table.register(MainViewCell.self, forCellReuseIdentifier: MainViewCell.identifier)
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.openDetailItemViewController(id: indexPath.row)
    }
}


// MARK: - UITableViewDataSource
extension MainView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return keys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainViewCell.identifier) as? MainViewCell else { return UITableViewCell()}
        cell.selectionStyle = .none
        cell.setCell(key: keys[indexPath.row])
        return cell
    }
}
