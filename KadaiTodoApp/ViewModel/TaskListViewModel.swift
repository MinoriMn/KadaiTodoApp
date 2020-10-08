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
        tasks = taskModel.getTasks()
    }
    
    
}
