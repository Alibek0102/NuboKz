//
//  MissionInfoViewController.swift
//  NuboKz
//
//  Created by Алибек Аблайулы on 03.03.2024.
//

import UIKit

class MissionInfoViewController: UIViewController {
    
    var startFlow: boolClosure?
    
    var mission: Mission? {
        didSet {
            guard let missionData = mission else { return }
            
            switch missionData {
            case .test( _, _, let text):
                infoLabel.text = "\(text)\n\nВы готовы пройти тестирование?"
            }
            
        }
    }
    
    var contentView: UIStackView = {
        let contentView = UIStackView()
        contentView.backgroundColor = .white
        contentView.axis = .vertical
        contentView.spacing = 25
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 15
        contentView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        contentView.isLayoutMarginsRelativeArrangement = true
        contentView.layoutMargins = UIEdgeInsets(top:  20, left: 20, bottom: 24, right: 20)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    var infoLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let customButton = CustomButton(title: "Начать тестирование")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black.withAlphaComponent(0.5)
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(closeModalView))
        view.addGestureRecognizer(gesture)
        
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(closeModalView))
        swipeGesture.direction = .down
        view.addGestureRecognizer(swipeGesture)
        
        customButton.addTarget(self, action: #selector(startTask), for: .touchUpInside)
        
        setupContentView()
    }
    
    @objc func startTask() {
        startFlow?(true)
        dismiss(animated: true)
    }
    
    @objc func closeModalView() {
        dismiss(animated: true)
    }
    
    private func setupContentView() {
        view.addSubview(contentView)
        
        contentView.addArrangedSubview(infoLabel)
        contentView.addArrangedSubview(customButton)
        
        
        NSLayoutConstraint.activate([
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            contentView.leftAnchor.constraint(equalTo: view.leftAnchor),
            contentView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
    
    private func setupCornerRadiusForTop( view: UIStackView ) {
        let path = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 20, height: 20))
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = UIColor.red.cgColor
        
        view.layer.mask = shapeLayer
    }
    
}
