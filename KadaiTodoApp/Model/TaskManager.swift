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
    
    @Published var tasks = [Task]()
    
    private init() {
        let _tasks = loadTasksFromDB()
        tasks.append(contentsOf: _tasks)
    }
    
    deinit{
        print("deinit called")
    }
    
    private func loadTasksFromDB() -> [Task]{
        //DEBUG
//        var _tasks: [Task] = []
//
//        let tableData = ["水戸駅", "偕楽園駅", "日立駅", "土浦駅", "つくば駅", "研究学園駅"]
//        var dt: Date = Date()
//        for data in tableData {
//            dt = Calendar.current.date(byAdding: .day, value: -1, to: dt)!
//            let task = Task(creationTime: dt, title: data, detail: data + "_detail")
//            _tasks.append(task)
//        }

        // storageからのTaskデータのロード
        guard let data = UserDefaults.standard.data(forKey: "tasks")
            else { return [] }
        guard let _tasks = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [Task]
            else { return [] }
        return _tasks
    }
    
    func saveTasksToDB(){
        guard let data = try? NSKeyedArchiver.archivedData(withRootObject: tasks, requiringSecureCoding: false)
            else { return }
        UserDefaults.standard.set(data, forKey: "tasks")
        UserDefaults.standard.synchronize()
    }
    
    public func getTasks() -> [Task] {
        return tasks
    }
    
    public func addNewTask(title: String, detail: String) -> Future<[Task], Error>{
        return Future<[Task], Error>{ promise in
            if title.isEmpty || title == "" {
                promise(.failure(TaskError.emptyTitle))
            }else{
                let dt: Date = Date()
                self.tasks.append(Task(creationTime: dt, title: title, detail: detail))
                promise(.success(self.tasks))
//                print("count:", self.tasks.count)
            }
        }
    }
    
    public func editTask(idx: Int, title: String, detail: String) -> Future<[Task], Error>{
        return Future<[Task], Error>{ promise in
            if title.isEmpty || title == "" {
                promise(.failure(TaskError.emptyTitle))
            }else{
                var task = self.tasks[idx]
                task.title = title
                task.detail = detail
                self.tasks[idx] = task
                promise(.success(self.tasks))
            }
        }
    }
    
    public func deleteTask(idx: Int) -> Future<Void, Error>{
        return Future<Void, Error>{ promise in
            if idx >= self.tasks.count {
                promise(.failure(TaskError.notExsitIdx))
            }else{
                self.tasks.remove(at: idx)
                promise(.success(Void()))
            }
        }
    }
}

protocol TaskManagerProtocol {
    var tasks: [Task] { get set }
}

class Task: NSObject, NSCoding {
    let creationTime: Date!
    var title: String = ""
    var detail: String = ""
    
    init(creationTime: Date, title: String, detail: String) {
        self.creationTime = creationTime
        self.title = title
        self.detail = detail
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.creationTime, forKey: "creationTime")
        aCoder.encode(self.title, forKey: "title")
        aCoder.encode(self.detail, forKey: "detail")
    }

    required init?(coder aDecoder: NSCoder) {
        self.creationTime = aDecoder.decodeObject(forKey: "creationTime") as? Date
        self.title = aDecoder.decodeObject(forKey: "title") as! String
        self.detail = aDecoder.decodeObject(forKey: "detail") as! String
    }
}

enum TaskError: Error{
    case emptyTitle
    case notExsitIdx
}
