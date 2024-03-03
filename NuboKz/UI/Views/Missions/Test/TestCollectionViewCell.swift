//
//  TestCollectionViewCell.swift
//  NuboKz
//
//  Created by Алибек Аблайулы on 03.03.2024.
//

import UIKit

class TestCollectionViewCell: UICollectionViewCell {
    
    let questionContainer: UIStackView = {
        let container = UIStackView()
        container.backgroundColor = AppColors.lightSilver
        container.layer.cornerRadius = 12
        container.axis = .vertical
        container.isLayoutMarginsRelativeArrangement = true
        container.layoutMargins = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    let questionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let answersContainer: UIStackView = {
        let container = UIStackView()
        container.spacing = 10
        container.axis = .vertical
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupTestElements()
        
        contentView.layer.zPosition = 10
    }
    
    func setupTestElements() {
        contentView.addSubview(questionContainer)
        contentView.addSubview(answersContainer)
        
        questionContainer.addArrangedSubview(questionLabel)
        
        NSLayoutConstraint.activate([
            questionContainer.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            questionContainer.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            questionContainer.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20),
            
            answersContainer.topAnchor.constraint(equalTo: questionContainer.bottomAnchor, constant: 20),
            answersContainer.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            answersContainer.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20)
        ])
    }
    
    func setupQuestionElements(question: Question) {
        questionLabel.text = question.question
        
        let questionAlphabet = ["A", "B", "C", "D", "E"]
        
        question.answers.enumerated().forEach{ index, answer in
            let alphabetLabel: UILabel = {
                let label = UILabel()
                label.textColor = .white
                label.text = questionAlphabet[index]
                label.font = Fonts.fontCreator(font: .medium, size: 10)
                label.translatesAutoresizingMaskIntoConstraints = false
                return label
            }()
            
            let alphabetIndexView: UIView = {
                let container = UIView()
                container.backgroundColor = AppColors.textGray
                container.layer.cornerRadius = 15
                container.translatesAutoresizingMaskIntoConstraints = false
                container.heightAnchor.constraint(equalToConstant: 30).isActive = true
                container.widthAnchor.constraint(equalToConstant: 30).isActive = true
                
                container.addSubview(alphabetLabel)
                
                NSLayoutConstraint.activate([
                    alphabetLabel.centerXAnchor.constraint(equalTo: container.centerXAnchor),
                    alphabetLabel.centerYAnchor.constraint(equalTo: container.centerYAnchor)
                ])
                
                return container
            }()
            
            let answerLabel: UILabel = {
                let label = UILabel()
                label.text = answer.answer
                label.textColor = AppColors.textGray
                label.font = Fonts.fontCreator(font: .bold, size: 14)
                label.translatesAutoresizingMaskIntoConstraints = false
                return label
            }()
            
            let answerButton: UIButton = {
                let button = UIButton()
                button.backgroundColor = AppColors.lightSilver
                button.translatesAutoresizingMaskIntoConstraints = false
                button.layer.cornerRadius = 12
                button.heightAnchor.constraint(equalToConstant: 50).isActive = true
                
                button.addSubview(alphabetIndexView)
                button.addSubview(answerLabel)
                
                NSLayoutConstraint.activate([
                    alphabetIndexView.leftAnchor.constraint(equalTo: button.leftAnchor, constant: 12),
                    alphabetIndexView.centerYAnchor.constraint(equalTo: button.centerYAnchor),
                    answerLabel.centerYAnchor.constraint(equalTo: button.centerYAnchor),
                    answerLabel.leftAnchor.constraint(equalTo: alphabetIndexView.rightAnchor, constant: 12),
                    answerLabel.rightAnchor.constraint(equalTo: button.rightAnchor, constant: -10)
                ])
                
                return button
            }()
            
            answersContainer.addArrangedSubview(answerButton)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
