//
//  ViewModelBase.swift
//  KadaiTodoApp
//
//  Created by 松田尚也 on 2020/10/05.
//

import Combine

class ViewModelBase {
    var cancellables: Set<AnyCancellable>!
    
    init() {
        cancellables = Set<AnyCancellable>()
    }
}
