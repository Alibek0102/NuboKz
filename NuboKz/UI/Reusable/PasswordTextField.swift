//
//  PasswordTextField.swift
//  NuboKz
//
//  Created by Алибек Аблайулы on 26.02.2024.
//

import UIKit

class PasswordTextField: UITextField {
    init() {
        super.init(frame: .zero)
        borderStyle = .roundedRect
        isSecureTextEntry = true
        layer.cornerRadius = 10
        placeholder = "********"
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = AppColors.lightSilver
        
        heightAnchor.constraint(equalToConstant: 45).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
