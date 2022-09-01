//
//  DetailViewController.swift
//  keyKeeper
//
//  Created by Данил Менделев on 30.05.2022.
//

import UIKit
import CoreData

class DetailViewController: UIViewController {

    var id: Int?
    
    var keys:[Any] = []
    
    
    private lazy var detailView: DetailView = {
        let detailView = DetailView()
        detailView.translatesAutoresizingMaskIntoConstraints = false
        return detailView
    }()
    
    convenience init() {
         self.init(id: nil)
     }
     init(id: Int?) {
         self.id = id
         super.init(nibName: nil, bundle: nil)
     }
     required init?(coder aDecoder: NSCoder) {
         super.init(coder: aDecoder)
     }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.detailView.delegate = self
        layout()
        fetchRequest()
        hideKeyboardWhenTappedAround()
        view.backgroundColor = .white

    }
    
    private func fetchRequest(){
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
        navigationItem.title = "Детальный просмотр ключа"
        view.addSubview(detailView)
        let constraint: CGFloat = 10
        
        NSLayoutConstraint.activate([
            detailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: constraint),
            detailView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: constraint),
            detailView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -constraint),
            detailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -constraint)
        ])
    }
    
}

// MARK: - UITextFieldDelegate
extension DetailViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}


// MARK: - DetailViewProtocolDelegate
extension DetailViewController: DetailViewProtocolDelegate {
    func closeDetailViewController() {
        navigationController?.popViewController(animated: true)
    }
    
    
}
