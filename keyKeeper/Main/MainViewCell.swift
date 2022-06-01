//
//  MainViewCell.swift
//  keyKeeper
//
//  Created by Данил Менделев on 30.05.2022.
//

import UIKit
import CoreData

class MainViewCell: UITableViewCell {

    private lazy var itemImage: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "key.fill"))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 8
        image.layer.borderWidth = 1.5
        image.layer.borderColor = UIColor.purple.cgColor
        return image
    }()
    
    private lazy var itemLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        label.text = "label name place from login/pass"
        label.textColor = .black
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCell(key: NSManagedObject) {
        itemLabel.text = key.value(forKey: "name") as? String
    }
    
    private func layout(){
        addSubview(itemImage)
        addSubview(itemLabel)
        let inset: CGFloat = 10
        
        NSLayoutConstraint.activate([
            itemImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: inset),
            itemImage.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: inset),
            itemImage.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -inset),
            itemImage.widthAnchor.constraint(equalToConstant: 20),
            itemImage.heightAnchor.constraint(equalToConstant: 20),
            
            itemLabel.centerYAnchor.constraint(equalTo: itemImage.centerYAnchor),
            itemLabel.leadingAnchor.constraint(equalTo: itemImage.trailingAnchor, constant: inset)
        ])
    }
}
