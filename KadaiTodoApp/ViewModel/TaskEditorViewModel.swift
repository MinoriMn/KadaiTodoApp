//
//  TaskEditorViewModel.swift
//  KadaiTodoApp
//
//  Created by 松田尚也 on 2020/10/05.
//

import Combine

class TaskEditorViewModel: ViewModelBase{
//    let cancel: Subscribers.Sink<Void, Never>
//    let ok: Subscribers.Sink<Void, Never>
    
    override init(){
//        let _cancel = PassthroughSubject<Void, Never>()
//        let _ok = PassthroughSubject<Void, Never>()
//
//        self.cancel = .init(receiveCompletion: { _cancel.send(completion: $0) }, receiveValue: { _cancel.send($0) })
//        self.ok = .init(receiveCompletion: { _ok.send(completion: $0) }, receiveValue: { _ok.send($0) })
        
        super.init()
        
//        let cancel = _cancel.sink{ _ in
//
//        }
//        .store(in: &cancellables)
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
