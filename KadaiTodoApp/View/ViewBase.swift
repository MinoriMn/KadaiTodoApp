//
//  ViewBase.swift
//  KadaiTodoApp
//
//  Created by 松田尚也 on 2020/10/05.
//
import UIKit
import Combine

protocol ViewBase {
    associatedtype ViewModel: ViewModelBase
    var viewModel: ViewModel { get }
    var cancellables: Set<AnyCancellable> { get }
}
