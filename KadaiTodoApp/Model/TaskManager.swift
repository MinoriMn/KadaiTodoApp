//
//  TaskModel.swift
//  KadaiTodoApp
//
//  Created by 松田尚也 on 2020/10/06.
//

import Foundation
import Combine

final class TaskManager: TaskManagerProtocol{
    static let shared = TaskManager()
    
    var tasks = PassthroughSubject<[Task], Never>()
    
    private init() {
        loadTasksFromDB()
    }
    
    private func loadTasksFromDB(){
        //TODO: storageからのTaskデータのロード
        var _task: [Task] = []
        
        let tableData = ["水戸駅", "偕楽園駅", "日立駅", "土浦駅", "つくば駅", "研究学園駅"]
        var dt: Date = Date()
        for data in tableData {
            dt = Calendar.current.date(byAdding: .day, value: 1, to: dt)!
            let task = Task(creationTime: dt, title: data, detail: data + "_detail")
            _task.append(task)
        }
        tasks.append([_task])
    }
    
    public func addNewTask(title: String, detail: String){
        
    }
    
    public func editTask(id: Int, title: String, detail: String){
        
    }
}

protocol TaskManagerProtocol {
    var tasks: PassthroughSubject<[Task], Never> { get set }
}

struct Task: Hashable {
    let creationTime: Date!
    var title: String = ""
    var detail: String = ""
}
