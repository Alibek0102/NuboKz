//
//  LessonsTableViewCell.swift
//  NuboKz
//
//  Created by Алибек Аблайулы on 27.02.2024.
//

import UIKit

class LessonsTableViewCell: UITableViewCell {
    
    let colors: [String] = ["#abc4eb", "#cc98d6", "#b3e3a1", "#e3b596"]
    
    func randomInRange(min: Int, max: Int) -> Int {
        return Int.random(in: min...max)
    }
    
    let lessonItem: UIView = {
        let lessonItem = UIView()
        lessonItem.backgroundColor = AppColors.lightSilver
        lessonItem.layer.cornerRadius = 12
        lessonItem.translatesAutoresizingMaskIntoConstraints = false
        return lessonItem
    }()
    
    let lessonLogo: UIView = {
        let logo = UIView()
        logo.layer.cornerRadius = 25
        logo.translatesAutoresizingMaskIntoConstraints = false
        return logo
    }()
    
    let logoLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.fontCreator(font: .bold, size: 28)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var lessonName: UILabel = {
        let label = UILabel()
        label.font = Fonts.fontCreator(font: .medium, size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var dateLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.fontCreator(font: .regular, size: 12)
        label.textColor = AppColors.textGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        setupItem()
    }
    
    private func setupItem() {
        addSubview(lessonItem)
        
        let stackView = UIStackView(arrangedSubviews: [lessonName, dateLabel])
        stackView.axis = .vertical
        stackView.spacing = 2
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        lessonItem.addSubview(lessonLogo)
        lessonItem.addSubview(stackView)
        
        lessonLogo.backgroundColor = UIColor(hexString: colors[randomInRange(min: 0, max: colors.count - 1)])
        
        lessonLogo.addSubview(logoLabel)
        
        NSLayoutConstraint.activate([
            lessonItem.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            lessonItem.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            lessonItem.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            lessonItem.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            
            lessonLogo.leftAnchor.constraint(equalTo: lessonItem.leftAnchor, constant: 16),
            lessonLogo.heightAnchor.constraint(equalToConstant: 50),
            lessonLogo.widthAnchor.constraint(equalToConstant: 50),
            lessonLogo.centerYAnchor.constraint(equalTo: lessonItem.centerYAnchor),
            
            stackView.centerYAnchor.constraint(equalTo: lessonItem.centerYAnchor),
            stackView.leftAnchor.constraint(equalTo: lessonLogo.rightAnchor, constant: 17),
            
            logoLabel.centerXAnchor.constraint(equalTo: lessonLogo.centerXAnchor),
            logoLabel.centerYAnchor.constraint(equalTo: lessonLogo.centerYAnchor)
            
        ])
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
