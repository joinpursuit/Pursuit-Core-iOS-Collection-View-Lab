//
//  ViewController+Extensions.swift
//  Pursuit-Core-iOS-Collection-View-Lab
//
//  Created by Bienbenido Angeles on 1/15/20.
//  Copyright © 2020 Bienbenido Angeles. All rights reserved.
//

import UIKit

extension ViewController{
    func showAlert(title: String, message: String, completion: ((UIAlertAction)-> Void)? = nil){
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: completion)
        alertVC.addAction(action)
        present(alertVC, animated: true, completion: nil)
    }
}
