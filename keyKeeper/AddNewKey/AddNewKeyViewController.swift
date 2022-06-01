//
//  AddNewKeyViewController.swift
//  keyKeeper
//
//  Created by Данил Менделев on 30.05.2022.
//

import UIKit
import CoreData

class AddNewKeyViewController: UIViewController {
    
    var keys = [NSManagedObject]()
    
    private lazy var addNewKeyView: AddNewKeyView = {
        let addNewKeyView = AddNewKeyView()
        addNewKeyView.translatesAutoresizingMaskIntoConstraints = false
        return addNewKeyView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.addNewKeyView.delegate = self
//        hideKeyboardWhenTappedAround()
        layout()
    }
    
    private func layout() {
        view.addSubview(addNewKeyView)
        let constraint: CGFloat = 10
        
        NSLayoutConstraint.activate([
            addNewKeyView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: constraint),
            addNewKeyView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: constraint),
            addNewKeyView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -constraint),
            addNewKeyView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -constraint)
        ])
    }

}
// MARK: - UITextFieldDelegate
extension AddNewKeyViewController: UITextFieldDelegate {
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        view.endEditing(true)
//        return true
//    }
//
//    func hideKeyboardWhenTappedAround() {
//        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
//        tap.cancelsTouchesInView = false
//        view.addGestureRecognizer(tap)
//    }
//
//    @objc func dismissKeyboard() {
//        view.endEditing(true)
//    }
}

// MARK: - AddNewKeyProtocolDelegate

extension AddNewKeyViewController: AddNewKeyProtocolDelegate {
    func getDataForTableKeys(data: [String: Any]) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Keys", in: managedContext)!
        let key = NSManagedObject(entity: entity, insertInto: managedContext)
        key.setValue(data["id"], forKeyPath: "id")
        key.setValue(data["name"], forKeyPath: "name")
        key.setValue(data["login"], forKeyPath: "login")
        key.setValue(data["password"], forKeyPath: "password")
        do {
          try managedContext.save()
          keys.append(key)
        } catch let error as NSError {
          print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func closeAddNewKeyViewController() {
        self.dismiss(animated: true)
    }
    
}
