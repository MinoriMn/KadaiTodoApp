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
    }

    @IBAction private func onTapCancelButton (_ sender: UIButton) {
        //TODO: 画面遷移もViewModelに移動するべきか？
        let cancel: Bool = viewModel.tappedCancelButton()
        
        if cancel {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction private func onTapOKButton (_ sender: UIButton) {
        //Validation Check
        if titleTextField.text?.isEmpty ?? false {
            alert(viewController: self, title: "入力エラー", message: "タイトルを入力してください")
            return
        }
        
        //TODO: 画面遷移もViewModelに移動するべきか？
        let ok: Bool = viewModel.tappedOKButton()
        
        if ok {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

