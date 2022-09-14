//
//  MainListViewControllerDependencies.swift
//  ProjectManager
//
//  Created by 이시원 on 2022/09/14.
//

import UIKit

protocol MainListViewDependencies: AnyObject {
    func presentEditViewController(item: TodoModel?)
    func popoverMoveViewController(cell: UITableViewCell?, item: TodoModel)
    func popoverHistoryViewController(button: UIBarButtonItem)
    func showErrorAlert(message: String)
}
