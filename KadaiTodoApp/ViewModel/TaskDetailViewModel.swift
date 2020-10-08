//
//  TaskDetailViewModel.swift
//  KadaiTodoApp
//
//  Created by 松田尚也 on 2020/10/08.
//

import Combine

class TaskDetailViewModel: ViewModelBase{
    private let taskModel = TaskManager.shared
    
    @Published var title: String! = "title__"
    @Published var detail: String! = "detail__"
    
    @Published var taskIdx: Int = 0
    
    private var deleteFlag = false
    
    private override init(){}
    
    init(taskIdx: Int){
        super.init()
        
        self.taskIdx = taskIdx
        
        taskModel.$tasks
            .sink(receiveValue: { tasks in
                if !self.deleteFlag {//Delete時のout of index対策
                    self.title = tasks[self.taskIdx].title
                    self.detail = tasks[self.taskIdx].detail
                }
            })
            .store(in: &cancellables)
    }
    
    public func setTaskIdx(idx: Int){
        self.taskIdx = idx
    }
    
//    func editTask() {
//        
//    }
    
    func deleteTask() -> AnyPublisher<Void, Error> {
        deleteFlag = true
        return taskModel.deleteTask(idx: taskIdx)
        .handleEvents(receiveCompletion: { [weak self] completion in
            switch completion {
            case .finished:
                print("finished")
            case .failure:
                self?.deleteFlag = false
                print("failure")
            }
        })
        .eraseToAnyPublisher()
    }
}
