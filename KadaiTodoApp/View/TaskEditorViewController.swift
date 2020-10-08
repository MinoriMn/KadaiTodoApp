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

    var isNewTask = true //新規生成か否(既存編集)か

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 枠のカラー
        detailTextView.layer.borderColor = UIColor.gray.cgColor
        // 枠の幅
        detailTextView.layer.borderWidth = 1.0
        // 枠を角丸にする
        detailTextView.layer.cornerRadius = 5.0
        detailTextView.layer.masksToBounds = true


        //DataBinding
        viewModel.$title
            .assign(to: \.text, on: titleTextField)
            .store(in: &cancellables)
        
        viewModel.$detail
        .assign(to: \.text, on: detailTextView)
        .store(in: &cancellables)
    }

    func setEditTask(idx: Int){
        isNewTask = false
        viewModel.setEditTask(idx: idx)
    }

    @IBAction private func onTapCancelButton (_ sender: UIButton) {
        let cancel: Bool = viewModel.cancel()
        
        if cancel {
            self.dismiss(animated: true, completion: nil)
        }
    }

    @IBAction private func onTapOKButton (_ sender: UIButton) {
        let receiveCompletion: ((Subscribers.Completion<Error>) -> Void) = { (completion) in
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
        }

        let receiveValue: (([Task]) -> Void) = { tasks in
            self.dismiss(animated: true, completion: nil)
        }

        //add new task
        if isNewTask{
            //新規生成
            viewModel.addNewTask(title: titleTextField.text ?? "", detail: detailTextView.text ?? "")
                .sink(receiveCompletion: receiveCompletion, receiveValue: receiveValue)
        }else{
            //既存編集
            viewModel.editTask(title: titleTextField.text ?? "", detail: detailTextView.text ?? "")
                .sink(receiveCompletion: receiveCompletion, receiveValue: receiveValue)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

