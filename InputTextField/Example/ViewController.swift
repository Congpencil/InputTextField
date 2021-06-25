//
//  ViewController.swift
//  InputTextField
//
//  Created by Quang Công on 17/06/2021.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var textField: TextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.delegate = self
    }
}

// MARK: - UITextfield deleagate
extension ViewController: UITextFieldDelegate {
    
}
