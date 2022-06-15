//
//  MainViewController.swift
//  keyKeeper
//
//  Created by Данил Менделев on 30.05.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    private lazy var mainView: MainView = {
        let mainView = MainView()
        mainView.translatesAutoresizingMaskIntoConstraints = false
        return mainView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        self.mainView.delegateToVC = self
        layout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mainView.fetchRequest()
        mainView.reloadDataTableOfKeys()
    }
    
    private func layout() {
        navigationItem.title = "Ключница"
        view.addSubview(mainView)
        let constraint: CGFloat = 10
        
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: constraint),
            mainView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: constraint),
            mainView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -constraint),
            mainView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -constraint)
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
extension MainViewController: MainViewProtocolDelegate {
    func openAddNewKeyViewController() {
        let addNewKeyVC = AddNewKeyViewController()
        present(addNewKeyVC, animated: true)
    }
    
    func openDetailItemViewController(id: Int) {
        let detailVC = DetailViewController(id: id)
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
}
