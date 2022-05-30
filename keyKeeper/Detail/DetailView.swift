//
//  DetailView.swift
//  keyKeeper
//
//  Created by Данил Менделев on 30.05.2022.
//

import UIKit

class DetailView: UIView {

    weak var delegate: DetailViewProtocolDelegate?
    
    private lazy var changeDetailKeyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.text = "Редактировать"
        label.textColor = .black
        return label
    }()
    
    private lazy var statusDateKeySwitch: UISwitch = {
        let switchStatus = UISwitch()
        switchStatus.translatesAutoresizingMaskIntoConstraints = false
        switchStatus.addTarget(self, action: #selector(switchStatusKey(_:)), for: .valueChanged)
        return switchStatus
    }()
    
    @objc private func switchStatusKey(_ sender: UISwitch) {
        if(sender.isOn) {
            print("On")
        }
        else{
            print("Off")
        }
    }
    
    private lazy var itemNameImage: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "person.text.rectangle.fill"))
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var itemNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
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
//        textField.delegate = DetailViewController()
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
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
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
//        textField.delegate = DetailViewController()
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
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
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
//        textField.delegate = DetailViewController()
        return textField
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 20
        button.setTitle("Сохранить", for: .normal)
        button.layer.backgroundColor = UIColor.blue.cgColor
        button.addTarget(self, action: #selector(closeDetailView), for: .touchUpInside)
        return button
    }()
    
    @objc private func closeDetailView(){
        delegate?.closeDetailViewController()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func layout(){
        [changeDetailKeyLabel, statusDateKeySwitch, itemNameImage, itemNameLabel, itemNameTextField, itemLoginImage, itemLoginLabel, itemLoginTextField, itemPasswordImage, itemPasswordLabel, itemPasswordTextField, saveButton].forEach{addSubview($0)}
        let inset: CGFloat = 10
        let insideInset: CGFloat = 5
        
        NSLayoutConstraint.activate([
            
            changeDetailKeyLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            changeDetailKeyLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: inset),
            
            statusDateKeySwitch.topAnchor.constraint(equalTo: changeDetailKeyLabel.topAnchor),
            statusDateKeySwitch.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -inset),
            
            itemNameImage.topAnchor.constraint(equalTo: changeDetailKeyLabel.bottomAnchor, constant: 20),
            itemNameImage.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: inset),
            itemNameImage.widthAnchor.constraint(equalToConstant: 50),
            itemNameImage.heightAnchor.constraint(equalToConstant: 50),
            
            itemNameLabel.topAnchor.constraint(equalTo: changeDetailKeyLabel.bottomAnchor, constant: 20),
            itemNameLabel.leadingAnchor.constraint(equalTo: itemNameImage.trailingAnchor, constant: inset),
            itemNameLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -inset),
            itemNameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            itemNameTextField.topAnchor.constraint(equalTo: itemNameLabel.bottomAnchor, constant: insideInset),
            itemNameTextField.leadingAnchor.constraint(equalTo: itemNameImage.trailingAnchor, constant: inset),
            itemNameTextField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -inset),
            itemNameTextField.heightAnchor.constraint(equalToConstant: 20),
            
        
            itemLoginImage.topAnchor.constraint(equalTo: itemNameTextField.bottomAnchor, constant: 20),
            itemLoginImage.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: inset),
            itemLoginImage.widthAnchor.constraint(equalToConstant: 50),
            itemLoginImage.heightAnchor.constraint(equalToConstant: 50),
            
            itemLoginLabel.topAnchor.constraint(equalTo: itemNameTextField.bottomAnchor, constant: 20),
            itemLoginLabel.leadingAnchor.constraint(equalTo: itemLoginImage.trailingAnchor, constant: inset),
            itemLoginLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -inset),
            itemLoginLabel.heightAnchor.constraint(equalToConstant: 20),
            
            itemLoginTextField.topAnchor.constraint(equalTo: itemLoginLabel.bottomAnchor, constant: insideInset),
            itemLoginTextField.leadingAnchor.constraint(equalTo: itemLoginImage.trailingAnchor, constant: inset),
            itemLoginTextField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -inset),
            itemLoginTextField.heightAnchor.constraint(equalToConstant: 20),
            
            
            itemPasswordImage.topAnchor.constraint(equalTo: itemLoginTextField.bottomAnchor, constant: 20),
            itemPasswordImage.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: inset),
            itemPasswordImage.widthAnchor.constraint(equalToConstant: 50),
            itemPasswordImage.heightAnchor.constraint(equalToConstant: 50),
            
            itemPasswordLabel.topAnchor.constraint(equalTo: itemLoginTextField.bottomAnchor, constant: 20),
            itemPasswordLabel.leadingAnchor.constraint(equalTo: itemPasswordImage.trailingAnchor, constant: inset),
            itemPasswordLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -inset),
            itemPasswordLabel.heightAnchor.constraint(equalToConstant: 20),
            
            itemPasswordTextField.topAnchor.constraint(equalTo: itemPasswordLabel.bottomAnchor, constant: insideInset),
            itemPasswordTextField.leadingAnchor.constraint(equalTo: itemPasswordImage.trailingAnchor, constant: inset),
            itemPasswordTextField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -inset),
            itemPasswordTextField.heightAnchor.constraint(equalToConstant: 20),
            
            
            saveButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -inset),
            saveButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -inset),
            saveButton.heightAnchor.constraint(equalToConstant: 50),
            saveButton.widthAnchor.constraint(equalToConstant: 130)
        ])
    }
    
}



