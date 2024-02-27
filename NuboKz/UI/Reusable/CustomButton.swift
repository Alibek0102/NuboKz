//
//  CustomButton.swift
//  NuboKz
//
//  Created by Алибек Аблайулы on 26.02.2024.
//

import UIKit

class CustomButton: UIButton {
    
    init(title: String?) {
        super.init(frame: .zero)
        backgroundColor = AppColors.lightGreen.withAlphaComponent(0.55)
        setTitle(title ?? "", for: .normal)
        setTitleColor(AppColors.screenColor, for: .normal)
        titleLabel?.font = Fonts.fontCreator(font: .bold, size: 16)
        heightAnchor.constraint(equalToConstant: 52).isActive = true
        layer.cornerRadius = 10
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
