//
//  ViewController.swift
//  KadaiTodoApp
//
//  Created by 松田尚也 on 2020/10/02.
//

import UIKit
import Combine

class ViewController: UIViewController {
    @IBOutlet var label: UILabel!
    let viewModel = ViewModel()
    
    private var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        label = UILabel()
//        label.frame = CGRect(x:100, y:200, width:160, height:30)
//        self.view.addSubview(label)
        
        viewModel.$labelText
            .map({ Optional($0) })
            .receive(on: DispatchQueue.main)
            .assign(to: \UILabel.text, on:label)
            .store(in: &cancellables)
    }


}

