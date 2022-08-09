//
//  AddNewKeyViewController.swift
//  keyKeeper
//
//  Created by Данил Менделев on 30.05.2022.
//

import UIKit
import CoreData

class AddNewKeyViewController: UIViewController {
    
    var keys:[Any] = []
    
    weak var delegateToMainView: MainViewFromAddViewProtocolDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        layout()
    }
    
    private lazy var itemNameImage: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "person.text.rectangle.fill"))
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var itemNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        label.text = "Имя учетной записи"
        label.textColor = .black
        return label
    }()
    
    private lazy var itemNameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont.systemFont(ofSize: 20)
        textField.placeholder = "Введите имя места откуда логин/пароль"
        textField.textColor = .black
//        textField.delegate = AddNewKeyViewController()
        return textField
    }()
    
    private lazy var itemLoginImage: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "person.fill"))
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var itemLoginLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        label.text = "Логин учетной записи"
        label.textColor = .black
        return label
    }()
    
    private lazy var itemLoginTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont.systemFont(ofSize: 20)
        textField.placeholder = "Введите логин учетной записи"
        textField.textColor = .black
//        textField.delegate = AddNewKeyViewController()
        return textField
    }()
    
    private lazy var itemPasswordImage: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "key.fill"))
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var itemPasswordLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        label.text = "Пароль учетной записи"
        label.textColor = .black
        return label
    }()
    
    private lazy var itemPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont.systemFont(ofSize: 20)
        textField.placeholder = "Введите пароль учетной записи"
        textField.textColor = .black
//        textField.delegate = AddNewKeyViewController()
        return textField
    }()
    
    private lazy var createButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 20
        button.setTitle("Создать", for: .normal)
        button.layer.backgroundColor = UIColor.blue.cgColor
        button.addTarget(self, action: #selector(closeAddNewKey), for: .touchUpInside)
        return button
    }()
    
    @objc private func closeAddNewKey() {
        self.getDataForTableKeys(data: getDataFromForm())
        self.delegateToMainView?.refreshTable()
        self.dismiss(animated: true)
    }
    
    private func getDataFromForm() -> [String: Any] {
        var needData:[String: Any] = [:]
        needData["id"] = (0...1000).randomElement()
        needData["name"] = itemNameTextField.text
        needData["login"] = itemLoginTextField.text
        needData["password"] = itemPasswordTextField.text
        return needData
    }
    
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

    private func layout(){
        [itemNameImage, itemNameLabel, itemNameTextField, itemLoginImage, itemLoginLabel, itemLoginTextField, itemPasswordImage, itemPasswordLabel, itemPasswordTextField, createButton].forEach{view.addSubview($0)}
        let inset: CGFloat = 10
        let insideInset: CGFloat = 5
        
        NSLayoutConstraint.activate([
            itemNameImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: inset),
            itemNameImage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: inset),
            itemNameImage.widthAnchor.constraint(equalToConstant: 50),
            itemNameImage.heightAnchor.constraint(equalToConstant: 50),
            
            itemNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: inset),
            itemNameLabel.leadingAnchor.constraint(equalTo: itemNameImage.trailingAnchor, constant: inset),
            itemNameLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -inset),
            itemNameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            itemNameTextField.topAnchor.constraint(equalTo: itemNameLabel.bottomAnchor, constant: insideInset),
            itemNameTextField.leadingAnchor.constraint(equalTo: itemNameImage.trailingAnchor, constant: inset),
            itemNameTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -inset),
            itemNameTextField.heightAnchor.constraint(equalToConstant: 20),
            
        
            itemLoginImage.topAnchor.constraint(equalTo: itemNameTextField.bottomAnchor, constant: 20),
            itemLoginImage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: inset),
            itemLoginImage.widthAnchor.constraint(equalToConstant: 50),
            itemLoginImage.heightAnchor.constraint(equalToConstant: 50),
            
            itemLoginLabel.topAnchor.constraint(equalTo: itemNameTextField.bottomAnchor, constant: 20),
            itemLoginLabel.leadingAnchor.constraint(equalTo: itemLoginImage.trailingAnchor, constant: inset),
            itemLoginLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -inset),
            itemLoginLabel.heightAnchor.constraint(equalToConstant: 20),
            
            itemLoginTextField.topAnchor.constraint(equalTo: itemLoginLabel.bottomAnchor, constant: insideInset),
            itemLoginTextField.leadingAnchor.constraint(equalTo: itemLoginImage.trailingAnchor, constant: inset),
            itemLoginTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -inset),
            itemLoginTextField.heightAnchor.constraint(equalToConstant: 20),
            
            
            itemPasswordImage.topAnchor.constraint(equalTo: itemLoginTextField.bottomAnchor, constant: 20),
            itemPasswordImage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: inset),
            itemPasswordImage.widthAnchor.constraint(equalToConstant: 50),
            itemPasswordImage.heightAnchor.constraint(equalToConstant: 50),
            
            itemPasswordLabel.topAnchor.constraint(equalTo: itemLoginTextField.bottomAnchor, constant: 20),
            itemPasswordLabel.leadingAnchor.constraint(equalTo: itemPasswordImage.trailingAnchor, constant: inset),
            itemPasswordLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -inset),
            itemPasswordLabel.heightAnchor.constraint(equalToConstant: 20),
            
            itemPasswordTextField.topAnchor.constraint(equalTo: itemPasswordLabel.bottomAnchor, constant: insideInset),
            itemPasswordTextField.leadingAnchor.constraint(equalTo: itemPasswordImage.trailingAnchor, constant: inset),
            itemPasswordTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -inset),
            itemPasswordTextField.heightAnchor.constraint(equalToConstant: 20),
            
            
            createButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -inset),
            createButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -inset),
            createButton.heightAnchor.constraint(equalToConstant: 50),
            createButton.widthAnchor.constraint(equalToConstant: 130)
        ])
    }
}
