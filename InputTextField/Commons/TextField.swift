//
//  CustomTextField.swift
//  InputTextField
//
//  Created by Quang Công on 17/06/2021.
//

import Foundation
import UIKit

// MARK: - Define
private enum TitleButton {
    case buttonOne
    case buttonTwo
    case buttonThree
    
    var setTitileButton: String {
        switch self {
        case .buttonOne:
            if let listSuggest = UserDefaultHelper.suggestions {
                return listSuggest[0]
            }
        case .buttonTwo:
            if let listSuggest = UserDefaultHelper.suggestions {
                return listSuggest[1]
            }
        case .buttonThree:
            if let listSuggest = UserDefaultHelper.suggestions {
                return listSuggest[2]
            }
        }
        return ""
    }
}

// MARK: - UITextField
class TextField: UITextField {
    
    private let viewSuggest: UIView = {
        let accessoryView = UIView(frame: .zero)
        accessoryView.backgroundColor = .white
        return accessoryView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 5
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let button1: UIButton = {
        let title: TitleButton = .buttonOne
        let button = UIButton()
        button.backgroundColor = .gray
        button.setTitle(title.setTitileButton, for: .normal)
        button.layer.cornerRadius = Constans.BUTTON_CORNER_RADIUS
        return button
    }()
    
    private let button2: UIButton = {
        let title: TitleButton = .buttonTwo
        let button = UIButton()
        button.backgroundColor = .gray
        button.setTitle(title.setTitileButton, for: .normal)
        button.layer.cornerRadius = Constans.BUTTON_CORNER_RADIUS
        return button
    }()
    
    private let button3: UIButton = {
        let title: TitleButton = .buttonThree
        let button = UIButton()
        button.backgroundColor = .gray
        button.setTitle(title.setTitileButton, for: .normal)
        button.layer.cornerRadius = Constans.BUTTON_CORNER_RADIUS
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeUI()
        commonInit()
        addViewSuggest()
        saveListSuggest()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        makeUI()
        commonInit()
        addViewSuggest()
        saveListSuggest()
    }
    
    /// Init Data
    private func saveListSuggest() {
        UserDefaultHelper.suggestions = ["100.000", "300.000", "500.000"]
    }
    
    private func makeUI() {
        translatesAutoresizingMaskIntoConstraints = false
        keyboardType = .numberPad
        layer.borderColor = UIColor.systemGray4.cgColor
        textColor = .label
        tintColor = .label
        textAlignment = .left
        font = UIFont.preferredFont(forTextStyle: .title2)
        minimumFontSize = 12
        backgroundColor = .tertiarySystemBackground
        autocorrectionType = .no
        returnKeyType = .go
        clearButtonMode = .whileEditing
        placeholder = "0đ"
    }
    
    private func addViewSuggest() {
        viewSuggest.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 40)
        viewSuggest.translatesAutoresizingMaskIntoConstraints = false
        button1.translatesAutoresizingMaskIntoConstraints = false
        button2.translatesAutoresizingMaskIntoConstraints = false
        button3.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(button1)
        stackView.addArrangedSubview(button2)
        stackView.addArrangedSubview(button3)
        viewSuggest.addSubview(stackView)
        let padding: CGFloat = 5
               
        // contrain
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: viewSuggest.topAnchor, constant: padding),
            stackView.leadingAnchor.constraint(equalTo: viewSuggest.leadingAnchor, constant: padding),
            stackView.bottomAnchor.constraint(equalTo: viewSuggest.bottomAnchor, constant: -padding),
            stackView.trailingAnchor.constraint(equalTo: viewSuggest.trailingAnchor, constant: -padding)
        ])
        
        inputAccessoryView = viewSuggest
    }
    
    private func commonInit() {
        self.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        button1.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
        button2.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
        button3.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
    }
    
    @objc private func textDidChange() {
        guard var inputText = self.text else {
            return
        }
        
        // remove "đ" from text in textfield
        inputText.removeAll { $0 == "đ" }
        
        // remove "." from text in textfield
        inputText.removeAll { $0 == "." }
        
        // remove space from text in textfield
        inputText.removeAll { $0 == " " }

        // format currency text in textfield
        if let amountString = Int(inputText) {
            self.text = formatCurrency(amountString)
        }
        
        if let newPosition = self.position(from: self.endOfDocument, offset: -2) {
            self.selectedTextRange = self.textRange(from: newPosition, to: newPosition)
        }
        
        if inputText.count > 0 && inputText.count < 4 {
            guard let inputText = Int(inputText) else {
                return
            }
            
            let amountInput1 = df2so(inputText * 1000)
            let amountInput2 = df2so(inputText * 10000)
            let amountInput3 = df2so(inputText * 100000)
            
            button1.setTitle(String(amountInput1), for: .normal)
            button2.setTitle(String(amountInput2), for: .normal)
            button3.setTitle(String(amountInput3), for: .normal)
        }
    }
    
    @objc private func buttonAction(_ button: UIButton) {
        switch button {
        case button1:
            guard var inputText = button1.currentTitle else {
                return
            }
            inputText.removeAll { $0 == "." }
            
            if let text = Int(inputText) {
                return self.text = formatCurrency(text)
            }
        case button2:
            guard var inputText = button2.currentTitle else {
                return
            }
            inputText.removeAll { $0 == "." }
            
            if let text = Int(inputText) {
                return self.text = formatCurrency(text)
            }
        case button3:
            guard var inputText = button3.currentTitle else {
                return
            }
            
            inputText.removeAll { $0 == "." }

            if let text = Int(inputText) {
                return self.text = formatCurrency(text)
            }
        default:
            break
        }
    }
    
    /// Format input number to string
    /// - Parameter inputNumber: ext in textfield as Int
    /// - Parameter symbol: defaufl character  = "đ"
    /// - Returns: type currency
    private func formatCurrency(_ inputNumber: Int) -> String {
        let formatter = NumberFormatter()
        formatter.currencySymbol = Constans.SYMBOL
        formatter.currencyGroupingSeparator = "."
        formatter.locale = Locale(identifier: Constans.PRICE_LOCATION)
        formatter.positiveFormat = "#,##0 ¤"
        formatter.numberStyle = .currency
        return formatter.string(from: inputNumber as NSNumber)!
    }
    
    /// Format number
    /// - Parameter amount: text in textfied as Int
    /// - Returns: type decimal
    private func df2so(_ amount: Int) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.groupingSeparator = "."
        numberFormatter.groupingSize = 3
        numberFormatter.usesGroupingSeparator = true
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: amount as NSNumber)!
    }
}
