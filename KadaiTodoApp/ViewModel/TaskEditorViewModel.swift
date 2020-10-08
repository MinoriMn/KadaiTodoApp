//
//  TaskEditorViewModel.swift
//  KadaiTodoApp
//
//  Created by 松田尚也 on 2020/10/05.
//

import Combine

class TaskEditorViewModel: ViewModelBase{
    private let taskModel = TaskManager.shared
    
    @Published var title: String! = "title__"
    @Published var detail: String! = "detail__"
    
    @Published private(set) var canOK: Bool = false
    
    override init(){
        super.init()
    }
    
    func cancel() -> Bool{
        //TODO: cancel確認
        print("cancel")
        return true
    }
    
    func addNewTask(_title: String, _detail: String) -> AnyPublisher<[Task], Error> {
        return taskModel.addNewTask(title: _title, detail: _detail)
        .handleEvents(receiveCompletion: { [weak self] completion in
            switch completion {
            case .finished:
                print("finished")
            case .failure:
                print("failure")
            }
        })
        .eraseToAnyPublisher()
    }
}
