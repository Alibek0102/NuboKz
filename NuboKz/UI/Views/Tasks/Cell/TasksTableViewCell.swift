//
//  TasksCell.swift
//  NuboKz
//
//  Created by Алибек Аблайулы on 29.02.2024.
//

import Foundation
import UIKit


class TasksTableViewCell: UITableViewCell {
    
    let colors: [String] = ["#abc4eb", "#cc98d6", "#b3e3a1", "#e3b596"]
    
    func randomInRange(min: Int, max: Int) -> Int {
        return Int.random(in: min...max)
    }
    
    var taskNameLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.fontCreator(font: .bold, size: 16)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var taskLevelLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.fontCreator(font: .medium, size: 10)
        label.textColor = AppColors.lightSilver
        return label
    }()
    
    let taskItem: UIView = {
        let item = UIView()
        item.backgroundColor = .red
        item.layer.cornerRadius = 12
        item.translatesAutoresizingMaskIntoConstraints = false
        return item
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupItem()
        
        selectionStyle = .none
    }
    
    func setupItem() {
        addSubview(taskItem)
        
        taskItem.backgroundColor = UIColor(hexString: colors[randomInRange(min: 0, max: colors.count - 1)])
        
        let stackView: UIStackView = {
            let stackView  = UIStackView(arrangedSubviews: [taskNameLabel, taskLevelLabel])
            stackView.axis = .vertical
            stackView.spacing = 2
            stackView.translatesAutoresizingMaskIntoConstraints = false
            return stackView
        }()
        
        taskItem.addSubview(stackView)
        
        
        NSLayoutConstraint.activate([
            taskItem.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            taskItem.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            taskItem.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            taskItem.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            
            stackView.centerYAnchor.constraint(equalTo: taskItem.centerYAnchor),
            stackView.leftAnchor.constraint(equalTo: taskItem.leftAnchor, constant: 16)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
