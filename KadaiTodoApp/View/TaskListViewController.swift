//
//  ViewController.swift
//  KadaiTodoApp
//
//  Created by 松田尚也 on 2020/10/02.
//

import UIKit
import Combine
import CombineDataSources

class TaskListViewController: UIViewController, ViewBase {
    var cancellables = Set<AnyCancellable>()
    
    @IBOutlet var taskList: UITableView!
//    @IBOutlet var newTaskButton: UIButton!
    
    typealias ViewModel = TaskListViewModel
    let viewModel: ViewModel = TaskListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //table list
        taskList.frame = view.frame
        taskList.delegate = self
        taskList.tableFooterView = UIView(frame: .zero)
        
        let itemsController = TableViewItemsController<[[Task]]>(cellIdentifier: "TaskCell", cellType: TaskTableViewCell.self, cellConfig: { cell, indexPath, task in
            cell.titleText?.text = task.title
            cell.detailText?.text = task.detail
        })
        viewModel.$tasks
            .bind(subscriber: taskList.rowsSubscriber(itemsController))
            .store(in: &cancellables)
    }
    
    override func viewWillDisappear(_ animated: Bool){
        viewModel.saveTasks()
        super.viewWillDisappear(animated)
    }
    
    @IBAction private func onTapNewTaskButton (_ sender: UIButton) {
        let taskEditorStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = taskEditorStoryBoard.instantiateViewController(withIdentifier: "TaskEditor")
        viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: true, completion: nil)
    }
}

//テーブルのイベントを管理する
extension TaskListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // タップされたセルの行番号を出力
        let taskDetailStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = taskDetailStoryBoard.instantiateViewController(identifier: "TaskDetail")//TODO: snapkitを使用してstoryboardを廃止する
//        let viewController = TaskDetailViewController(taskIdx: indexPath.row)
        //TODO: ↓多分良くないので要改善
        (viewController as! TaskDetailViewController).taskIdx = indexPath.row
        self.present(viewController, animated: true, completion: nil)
    }
}

//TableViewCell
class TaskTableViewCell: UITableViewCell {
    @IBOutlet var titleText: UILabel!
    @IBOutlet var detailText: UILabel!
}
