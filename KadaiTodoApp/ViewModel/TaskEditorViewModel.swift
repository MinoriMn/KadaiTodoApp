//
//  TaskEditorViewModel.swift
//  KadaiTodoApp
//
//  Created by 松田尚也 on 2020/10/05.
//

import Combine

class TaskEditorViewModel: ViewModelBase{
    private let taskModel = TaskManager.shared
    
    @Published var title: String! = ""
    @Published var detail: String! = ""
    
    var editTaskIdx: Int = 0 //既存編集時のタスクインデックス

//    @Published private(set) var canOK: Bool = false
    
    override init(){
        super.init()
    }
    
    func cancel() -> Bool{
        //TODO: cancel確認
        print("cancel")
        return true
    }
    
    //新規生成
    func addNewTask(title: String, detail: String) -> AnyPublisher<[Task], Error> {
        return taskModel.addNewTask(title: title, detail: detail)
            .handleEvents(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    print("add finished")
                case .failure:
                    print("add failure")
                }
            })
            .eraseToAnyPublisher()
    }

    //既存編集
    func editTask(title: String, detail: String) -> AnyPublisher<[Task], Error> {
        return taskModel.editTask(idx: editTaskIdx, title: title, detail: detail)
            .handleEvents(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    print("edit finished")
                case .failure:
                    print("edit failure")
                }
            })
            .eraseToAnyPublisher()
    }
    //既存編集時のタスク呼び出し
    func setEditTask(idx: Int){
        editTaskIdx = idx

        let task = taskModel.tasks[editTaskIdx]
        title = task.title
        detail = task.detail
    }
}
