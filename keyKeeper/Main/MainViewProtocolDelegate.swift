//
//  MainViewProtocolDelegate.swift
//  keyKeeper
//
//  Created by Данил Менделев on 30.05.2022.
//

import UIKit

protocol MainViewProtocolDelegate: AnyObject {
    func openDetailItemViewController(id: Int)
    func openAddNewKeyViewController()
}
