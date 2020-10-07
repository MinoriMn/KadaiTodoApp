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
    @Published var tasksPublisher: AnyPublisher<[Task], Never>
    
    override init() {
        print("called2")
        tasksPublisher = taskModel.tasks
            .eraseToAnyPublisher()
            
        super.init()
        
        tasksPublisher.sink(receiveValue: {tasks in
            for task in tasks{
                print("t:" + task.title)
            }
        })
    }
    
    
}
