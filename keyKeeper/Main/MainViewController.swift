//
//  MainViewController.swift
//  keyKeeper
//
//  Created by Данил Менделев on 30.05.2022.
//

import UIKit
import CoreData

class MainViewController: UIViewController {

    var keys:[Any] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        layout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchRequest()
        tableOfKeys.reloadData()
    }

    
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
        let addNewKeyVC = AddNewKeyViewController()
        addNewKeyVC.delegateToMainView = self
        present(addNewKeyVC, animated: true)
    }
    
    private lazy var tableOfKeys: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.dataSource = self
        table.register(MainViewCell.self, forCellReuseIdentifier: MainViewCell.identifier)
        return table
    }()

    private func fetchRequest(){
        keys = []
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Keys")
        fetchRequest.returnsObjectsAsFaults = false
        let keysBD = try! managedContext.fetch(fetchRequest)
        for key in keysBD {
            keys.append(key)
        }
    }
    
    private func layout() {
        view.addSubview(button)
        view.addSubview(tableOfKeys)
        navigationItem.title = "Ключница"
        
        NSLayoutConstraint.activate([
            tableOfKeys.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableOfKeys.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableOfKeys.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableOfKeys.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -20),
            
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            button.heightAnchor.constraint(equalToConstant: 60),
            button.widthAnchor.constraint(equalToConstant: 60)
        ])
    }
}


// MARK: - UIView
extension UIView {
    static var identifier: String {
        return String(describing: self)
    }
}


// MARK: - Delegate
extension MainViewController: MainViewFromAddViewProtocolDelegate {
    func refreshTable() {
        fetchRequest()
        tableOfKeys.reloadData()
    }
}

// MARK: - UITableViewDelegate
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailViewController(id: indexPath.row)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}


// MARK: - UITableViewDataSource
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return keys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainViewCell.identifier) as? MainViewCell else {
            return UITableViewCell()
        }
        
        cell.selectionStyle = .none
        cell.setCell(key: keys[indexPath.row] as! NSManagedObject)
        return cell
    }
}
