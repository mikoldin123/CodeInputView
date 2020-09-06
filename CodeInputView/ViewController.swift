//
//  ViewController.swift
//  CodeInputView
//
//  Created by Michael Dean Villanda on 25/06/2020.
//  Copyright © 2020 Michael Dean Villanda. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    lazy var test: CodeInputView = {
        let test = CodeInputView()
        test.backgroundColor = .lightGray
        test.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(test)
        
        NSLayoutConstraint.activate([
            test.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 32.0),
            test.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100.0),
            test.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -32.0)
        ])
        
        return test
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        test.configureInputField(6)
    }


}

