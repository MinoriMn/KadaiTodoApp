//
//  ViewModel.swift
//  KadaiTodoApp
//
//  Created by 松田尚也 on 2020/10/02.
//

import UIKit
import Combine

class TaskListViewModel: ViewModelBase{
    private let taskModel = TaskManager.shared
    @Published var tasks = [Task]()
    
    override init() {
        super.init()
        getTasks()
    }
    
    private func getTasks(){
        //apply model tasks (include updating)
        taskModel.$tasks
            .sink(receiveValue: { tasks in
                self.tasks = tasks //TODO: tasksには変更分だけ伝播させるのが望ましい
            })
            .store(in: &cancellables)
    }
    
    public func saveTasks(){
        taskModel.saveTasksToDB()
    }
}
