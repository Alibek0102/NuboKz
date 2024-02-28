//
//  EmailTextField.swift
//  NuboKz
//
//  Created by Алибек Аблайулы on 26.02.2024.
//

import UIKit

class EmailTextField: UITextField {
    init() {
        super.init(frame: .zero)
        borderStyle = .roundedRect
        layer.cornerRadius = 10
        placeholder = "alibek.yesetov@mail.ru"
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = AppColors.lightSilver
        tag = 10
        heightAnchor.constraint(equalToConstant: 45).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
