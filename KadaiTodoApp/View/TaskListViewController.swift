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
    
    //DEBUG: ↓追加　<テーブル表示データ>
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
    
    @IBAction private func onTapNewTaskButton (_ sender: UIButton) {
        //TODO: 画面遷移もViewModelに移動するべきか？
        let taskEditorStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = taskEditorStoryBoard.instantiateViewController(withIdentifier: "TaskEditor")
        viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: true, completion: nil)
    }
}

//テーブルのイベントを管理する
extension TaskListViewController: UITableViewDelegate {

}

//TableViewCell
class TaskTableViewCell: UITableViewCell {
    @IBOutlet var titleText: UILabel!
    @IBOutlet var detailText: UILabel!
}
