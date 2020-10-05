//
//  ViewController.swift
//  KadaiTodoApp
//
//  Created by 松田尚也 on 2020/10/02.
//

import UIKit
import Combine

class TaskListViewController: UIViewController, ViewBase {
    @IBOutlet var taskList: UITableView!
//    @IBOutlet var newTaskButton: UIButton!
    
    //DEBUG: ↓追加　<テーブル表示データ>
    let tableData = ["水戸駅", "偕楽園駅", "日立駅", "土浦駅", "つくば駅", "研究学園駅"]
    
    typealias ViewModel = TaskListViewModel
    let viewModel: ViewModel = TaskListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //DEBUG: ↓追加　<tableview初期設定>
        taskList.frame = view.frame
        taskList.dataSource = self
        taskList.delegate = self
        taskList.tableFooterView = UIView(frame: .zero)
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
extension TaskListViewController: UITableViewDataSource {

    // セクション毎の行数を返す
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }

    // 各行に表示するセルを返す
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // StoryBoradで定義したTableViewCellを取得する
        let cell: TaskTableViewCell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as! TaskTableViewCell
        cell.titleText?.text = tableData[indexPath.row]
        cell.detailText?.text = tableData[indexPath.row]
        return cell
    }
}

//DEBUG: テーブルのイベントを管理する
extension TaskListViewController: UITableViewDelegate {

}

//DEBUG: TableViewCell
class TaskTableViewCell: UITableViewCell {
    @IBOutlet var titleText: UILabel!
    @IBOutlet var detailText: UILabel!
}
