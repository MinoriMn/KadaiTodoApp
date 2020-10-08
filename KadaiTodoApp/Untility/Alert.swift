//
//  Alert.swift
//  KadaiTodoApp
//
//  Created by 松田尚也 on 2020/10/08.
//

import Foundation
import UIKit

func alert(viewController: UIViewController, title: String, message: String) {
    let alertController = UIAlertController(title: title,
                               message: message,
                               preferredStyle: .alert)
    alertController.addAction(UIAlertAction(title: "OK",
                                   style: .default,
                                   handler: nil))
    viewController.present(alertController, animated: true)
}
