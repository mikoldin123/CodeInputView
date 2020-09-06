//
//  CodeInputField.swift
//  CodeInputView
//
//  Created by Michael Dean Villanda on 25/06/2020.
//  Copyright © 2020 Michael Dean Villanda. All rights reserved.
//

import Foundation
import UIKit

class CodeInputField: UIView {
    
    var becomeResponder: (() -> Void)?
    
    lazy var placeHolderImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16.0),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16.0),
            imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 24.0),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -25.0),
            imageView.heightAnchor.constraint(equalToConstant: 12.0),
            imageView.widthAnchor.constraint(equalToConstant: 12.0)
        ])
        
        return imageView
    }()
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .green
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 24.0, weight: .medium)
        self.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        
        return label
    }()
    
    lazy var underlineLayer: CALayer = {
        let layer = CALayer()
        layer.frame = CGRect(x: 0, y: frame.size.height - 1.0, width: frame.size.width, height: 1.0)
        layer.borderWidth = 1.0
        self.layer.addSublayer(layer)

        return layer
    }()
    
    private lazy var tapRecognizer: UITapGestureRecognizer = {
        let recognizer = UITapGestureRecognizer()
        recognizer.addTarget(self, action: #selector(shouldBecomeResponder))
        return recognizer
    }()
    
    convenience init(_ text: String, withPlaceHolderImage image: UIImage?) {
        self.init()
        
        label.text = text
        
        if image == nil {
            placeHolderImage.backgroundColor = .orange
        }
        placeHolderImage.image = image
        
        addGestureRecognizer(tapRecognizer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        underlineLayer.frame = CGRect(x: 0, y: frame.size.height - 1.0, width: frame.size.width, height: 1.0)
    }
    
    func setUnderlineColor(_ color: UIColor) {
        underlineLayer.borderColor = color.cgColor
    }
    
    func setText(_ text: String) {
        label.text = text
        
        placeHolderImage.isHidden = !text.isEmpty
    }
    
    @objc
    func shouldBecomeResponder() {
        becomeResponder?()
    }
}
