//
//  CodeInputView.swift
//  CodeInputView
//
//  Created by Michael Dean Villanda on 25/06/2020.
//  Copyright © 2020 Michael Dean Villanda. All rights reserved.
//

import Foundation
import UIKit

class CodeInputView: UITextField {
    
    var didEnterLastDigit: ((String) -> Void)?
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 8.0
        stackView.backgroundColor = .blue
        stackView.distribution = .fillEqually
        self.addSubview(stackView)
         
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            stackView.topAnchor.constraint(equalTo: self.topAnchor)
        ])
        
        return stackView
    }()
 
    lazy var accessoryView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)
        
        let height: CGFloat = 24.0
        
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: self.stackView.trailingAnchor, constant: 8.0),
            view.topAnchor.constraint(equalTo: self.stackView.centerYAnchor, constant: -8.0),
            view.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16.0),
            view.widthAnchor.constraint(equalToConstant: height),
            view.heightAnchor.constraint(equalToConstant: height)
        ])
        
        return view
    }()
    
    lazy var helperLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .red
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.numberOfLines = 2
        self.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5.0),
            label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5.0),
            label.topAnchor.constraint(equalTo: self.stackView.bottomAnchor, constant: (12.0 + 12.0)),
            label.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5.0)
            ])
        
        return label
    }()
    
    var fieldArray: [CodeInputField] = []
    
    private var isConfigured = false
    
    func configureInputField(_ count: Int, withPlaceholder placeHolder: String = "•") {
        guard isConfigured == false else { return }
        isConfigured.toggle()
        
        configureTextField()
        
        var tempArray: [CodeInputField] = []

        for idx in 0..<count{
            let field = CodeInputField("", withPlaceHolderImage: #imageLiteral(resourceName: "Oval"))
            field.tag = idx
            field.becomeResponder = {
                self.becomeFirstResponder()
            }
            tempArray.append(field)
        }
        
        setupInputFields(fields: tempArray)
    }
    
    private func configureTextField() {
        textColor = .clear
        tintColor = .clear
        keyboardType = .numberPad
        delegate = self

        addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
    
    private func setupInputFields(fields: [CodeInputField]) {
        self.fieldArray = fields
        
        self.setupFields()
        
        helperLabel.text = ""
    }
    
    func setupFields() {
        for (idx, field) in fieldArray.enumerated() {
            field.backgroundColor = .red
            stackView.insertArrangedSubview(field, at: idx)
        }
    }
}

extension CodeInputView {
    @objc
    private func textDidChange() {
        guard
            let text = self.text,
            text.count <= fieldArray.count else {
            return
        }
        
        for idx in 0..<fieldArray.count {
            let field = fieldArray[idx]
            
            if idx < text.count {
                let index = text.index(text.startIndex, offsetBy: idx)
                field.setText(String(text[index]))
            } else {
                field.setText("")
            }
        }
        
        if text.count == fieldArray.count {
            didEnterLastDigit?(text)
        }
    }
}

extension CodeInputView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let charCount = textField.text?.count else {
            return false
        }
        
        return charCount < fieldArray.count || string == ""
    }
}
