//
//  ViewController.swift
//  KadaiTodoApp
//
//  Created by 松田尚也 on 2020/10/02.
//

import UIKit
import Combine

class TaskListViewController: UIViewController, ViewBase {
    @IBOutlet var taskLTableView: UITableView!
//    @IBOutlet var newTaskButton: UIButton!
    
    typealias ViewModel = TaskListViewModel
    let viewModel: ViewModel = TaskListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction private func onTapNewTaskButton (_ sender: UIButton) {
        //TODO: 画面遷移もViewModelに移動するべきか？
        let taskEditorStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = taskEditorStoryBoard.instantiateViewController(withIdentifier: "TaskEditor")
        viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: true, completion: nil)
    }
}

