//
//  TaskEditorViewModel.swift
//  KadaiTodoApp
//
//  Created by 松田尚也 on 2020/10/05.
//

import Combine

class TaskEditorViewModel: ViewModelBase{
    override init(){
        super.init()
    }
    
    func tappedCancelButton() -> Bool{
        //TODO: cancel確認
        print("cancel")
        return true
    }
    
    func tappedOKButton() -> Bool{
        //TODO: OK確認
        print("ok")
        return true
    }
}
