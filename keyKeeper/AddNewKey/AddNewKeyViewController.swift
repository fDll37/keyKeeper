//
//  AddNewKeyViewController.swift
//  keyKeeper
//
//  Created by Данил Менделев on 30.05.2022.
//

import UIKit

class AddNewKeyViewController: UIViewController {

    private lazy var addNewKeyView: AddNewKeyView = {
        let addNewKeyView = AddNewKeyView()
        addNewKeyView.translatesAutoresizingMaskIntoConstraints = false
        return addNewKeyView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.addNewKeyView.delegate = self
        hideKeyboardWhenTappedAround()
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

// MARK: - AddNewKeyProtocolDelegate

extension AddNewKeyViewController: AddNewKeyProtocolDelegate {
    func closeAddNewKeyViewController() {
        self.dismiss(animated: true)
    }
    
}
