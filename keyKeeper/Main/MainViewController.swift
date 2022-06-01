//
//  MainViewController.swift
//  keyKeeper
//
//  Created by Данил Менделев on 30.05.2022.
//

import UIKit
import CoreData

class MainViewController: UIViewController {

    var keys = [NSManagedObject]()
    
    private lazy var mainView: MainView = {
        let mainView = MainView()
        mainView.translatesAutoresizingMaskIntoConstraints = false
        return mainView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        self.mainView.delegate = self
        layout()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Шаг 1. Получение общего агента и диспетчера управляемых объектов
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let managedObectContext = appDelegate.persistentContainer.viewContext
        
        // Шаг 2. Создайте запрос на получение
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        
        // Шаг 3: Выполните запрос
        do {
            let fetchedResults = try managedObectContext.fetch(fetchRequest) as? [NSManagedObject]
            if let results = fetchedResults {
                keys = results
            }
            
        } catch  {
            fatalError("Получить не удалось")
            
        }
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
        let detailVC = DetailViewController()
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
}
