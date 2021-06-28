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
        textField.setButtonCornerRadius(cornerRadius: 10)
        textField.setButtonBackGroundColor(backgroudColor: .gray)
    }
    
    @IBAction func checkAmout(_ sender: Any) {
        let amount = textField.getAmount()
        print(amount)
    }
}

// MARK: - UITextfield deleagate
extension ViewController: UITextFieldDelegate {
    
}
