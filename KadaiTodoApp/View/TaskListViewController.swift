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
//        taskList.dataSource = self
        taskList.delegate = self
        taskList.tableFooterView = UIView(frame: .zero)
        
        let itemsController = TableViewItemsController<[[Task]]>(cellIdentifier: "TaskCell", cellType: TaskTableViewCell.self, cellConfig: { cell, indexPath, task in
            cell.titleText?.text = task.title
            cell.detailText?.text = task.detail
            print("called:" + task.title)
        })
        viewModel.tasksPublisher
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

//DEBUG: セクションやセル値を管理する
//extension TaskListViewController: UITableViewDataSource {
//
//    // セクション毎の行数を返す
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return tableData.count
//    }
//
//    // 各行に表示するセルを返す
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        // StoryBoradで定義したTableViewCellを取得する
//        let cell: TaskTableViewCell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as! TaskTableViewCell
//        cell.titleText?.text = tableData[indexPath.row]
//        cell.detailText?.text = tableData[indexPath.row]
//        return cell
//    }
//}

//テーブルのイベントを管理する
extension TaskListViewController: UITableViewDelegate {

}

//TableViewCell
class TaskTableViewCell: UITableViewCell {
    @IBOutlet var titleText: UILabel!
    @IBOutlet var detailText: UILabel!
}
