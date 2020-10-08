//
//  TaskDetail.swift
//  KadaiTodoApp
//
//  Created by 松田尚也 on 2020/10/08.
//

import UIKit
import Combine

class TaskDetailViewController: UIViewController, ViewBase {
    var taskIdx: Int = 0
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var detailTextView: UITextView!
    
    var cancellables = Set<AnyCancellable>()

    typealias ViewModel = TaskDetailViewModel
    var viewModel: ViewModel = TaskDetailViewModel(taskIdx: 0)//TODO: storyboardを使っている為こうするしかないので、snapkitを使用し解消する
    
//    init(taskIdx: Int){
//        viewModel = TaskDetailViewModel(taskIdx: taskIdx)
//        super.init(nibName: nil, bundle: nil)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = TaskDetailViewModel(taskIdx: taskIdx)

        viewModel.setTaskIdx(idx: taskIdx)

        viewModel.$title
            .assign(to: \.text, on: titleLabel)
            .store(in: &cancellables)

        viewModel.$detail
            .assign(to: \.text, on: detailTextView)
            .store(in: &cancellables)
    }

    @IBAction private func onTapDeleteButton (_ sender: UIButton) {
        viewModel.deleteTask()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                     print("Error:", error)
                }
            }, receiveValue: { _ in
                self.dismiss(animated: true, completion: nil)
            })
    }
    
    @IBAction private func onTapEditButton (_ sender: UIButton) {
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
