//
//  MissionsTableViewCell.swift
//  NuboKz
//
//  Created by Алибек Аблайулы on 02.03.2024.
//

import UIKit

class MissionsTableViewCell: UITableViewCell {
    
    var indexPath: IndexPath? {
        didSet {
            guard let indexPath = indexPath else { return }
            numberLabelOfMission.text = "\((indexPath.item) + 1)"
        }
    }
    
    let numberContainerOfMission: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = AppColors.lightSilver
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.layer.cornerRadius = 15
        containerView.clipsToBounds = true
        containerView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        containerView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        return containerView
    }()
    
    let numberLabelOfMission: UILabel = {
        let label = UILabel()
        label.textColor = AppColors.textGray
        label.font = Fonts.fontCreator(font: .bold, size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descriptionOfMission: UILabel = {
        let label = UILabel()
        label.text = "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."
        label.font = Fonts.fontCreator(font: .medium, size: 14)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let performMissionButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 7
        button.setTitleColor(AppColors.textGray, for: .normal)
        button.titleLabel?.font = Fonts.fontCreator(font: .bold, size: 12)
        button.backgroundColor = AppColors.lightSilver
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
        setupInterfaceItems()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupInterfaceItems() {
        addSubview(numberContainerOfMission)
        addSubview(descriptionOfMission)
        addSubview(performMissionButton)
        
        numberContainerOfMission.addSubview(numberLabelOfMission)
        
        NSLayoutConstraint.activate([
            numberContainerOfMission.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            numberContainerOfMission.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            
            performMissionButton.heightAnchor.constraint(equalToConstant: 25),
            performMissionButton.widthAnchor.constraint(equalToConstant: 120),
            performMissionButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            performMissionButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
            
            descriptionOfMission.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            descriptionOfMission.leftAnchor.constraint(equalTo: numberContainerOfMission.rightAnchor, constant: 12),
            descriptionOfMission.bottomAnchor.constraint(equalTo: performMissionButton.topAnchor, constant: -12),
            descriptionOfMission.rightAnchor.constraint(equalTo: rightAnchor, constant: -12),
            
            numberLabelOfMission.centerXAnchor.constraint(equalTo: numberContainerOfMission.centerXAnchor),
            numberLabelOfMission.centerYAnchor.constraint(equalTo: numberContainerOfMission.centerYAnchor)
        ])
    }
    
    func setupButtonTitle() {
        performMissionButton.setTitle("Выполнить", for: .normal)
    }
    
    func blockPerformButton() {
        performMissionButton.alpha = 0.5
        performMissionButton.isEnabled = false
        performMissionButton.setTitle("Заблокировано", for: .normal)
    }
    
}
