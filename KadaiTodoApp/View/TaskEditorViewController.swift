//
//  TaskEditorViewController.swift
//  KadaiTodoApp
//
//  Created by 松田尚也 on 2020/10/04.
//

import UIKit
import Combine

class TaskEditorViewController: UIViewController, ViewBase {
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var detailTextView: UITextView!
//    @IBOutlet var cancellButton: UIButton!
//    @IBOutlet var okButton: UIButton!
    
    var cancellables = Set<AnyCancellable>()

    typealias ViewModel = TaskEditorViewModel
    let viewModel: ViewModel = TaskEditorViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.$title
            .assign(to: \.text, on: titleTextField)
            .store(in: &cancellables)
        
        viewModel.$detail
        .assign(to: \.text, on: detailTextView)
        .store(in: &cancellables)
    }

    @IBAction private func onTapCancelButton (_ sender: UIButton) {
        //TODO: 画面遷移もViewModelに移動するべきか？
        let cancel: Bool = viewModel.cancel()
        
        if cancel {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction private func onTapOKButton (_ sender: UIButton) {
        //add new task
        viewModel.addNewTask(_title: titleTextField.text ?? "", _detail: detailTextView.text ?? "")
            .sink(receiveCompletion: { (completion) in
                switch completion {
                case .finished:
                    // ここでは値を受け取れないが完了したことを伝えることはできる
                    break
                case .failure(let error):
                    // エラーを受け取ることができる
                    switch error {
                    case TaskError.emptyTitle:
                        alert(viewController: self, title: "入力エラー", message: "タイトルを入力してください")
                        break
                    default:
                        print("Error:", error)
                    }
                    break
            }
        }, receiveValue: { tasks in
            self.dismiss(animated: true, completion: nil)
        })
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

