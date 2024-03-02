//
//  TaskDescriptionViewController.swift
//  NuboKz
//
//  Created by Алибек Аблайулы on 01.03.2024.
//

import UIKit

class TaskDescriptionViewController: UIViewController, TaskDescriptionPresenterView, Coordinating, MissionCoordinating {

    var finishFlow: boolClosure?
    var performEvent: performMissionCoordinatorEvents?
    
    var taskId: String? {
        didSet {
            guard let taskId = taskId else { return }
            self.presenter?.getTaskDescription(id: taskId)
        }
    }
    
    var presenter: TaskDescriptionPresenter?
    
    var taskDescription: TaskDescription? {
        didSet {
            guard let taskDescription = taskDescription else { return }
            let url = URL(string: taskDescription.image)
            let queue = DispatchQueue.global(qos: .utility)
            queue.async {
                guard let url = url, let data = try? Data(contentsOf: url) else { return }
                DispatchQueue.main.async {
                    self.descriptionImage.image = UIImage(data: data)
                }
            }
            
            DispatchQueue.main.async {
                self.descriptionTitle.text = taskDescription.title
                self.descriptionText.text = taskDescription.text
            }
        }
    }
    
    var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    var containerView: UIView = {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }()
    
    var descriptionImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var descriptionTitle: UILabel = {
        let label = UILabel()
        label.textColor = AppColors.textGray
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = Fonts.fontCreator(font: .bold, size: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var descriptionText: UILabel = {
        let label = UILabel()
        label.textColor = AppColors.textGray
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = Fonts.fontCreator(font: .medium, size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var dissmisButton: UIButton = {
        let imageView = UIImageView(image: UIImage(systemName: "xmark"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        let button = UIButton(type: .system)
        button.backgroundColor = .white
        button.tintColor = AppColors.textGray
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: button.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: button.centerYAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 20),
            imageView.widthAnchor.constraint(equalToConstant: 20)
        ])
        
        button.widthAnchor.constraint(equalToConstant: 40).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return button
    }()
    
    var customButton = CustomButton(title: "Продолжить")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.setNavigationBarHidden(true, animated: false)
        dissmisButton.addTarget(self, action: #selector(closeViewController), for: .touchUpInside)
        setupScrollView()
        customButton.addTarget(self, action: #selector(executeCoordinatorEvent), for: .touchUpInside)
    }
    
    @objc func closeViewController() {
        self.finishFlow?(true)
        self.descriptionImage.image = nil
        self.descriptionText.text = nil
        self.descriptionTitle.text = nil
    }
    
    @objc func executeCoordinatorEvent() {
        performEvent?(.missionsViewController)
    }
    
    func setupScrollView() {
        view.addSubview(scrollView)
        view.addSubview(dissmisButton)
        view.addSubview(customButton)
        customButton.backgroundColor = AppColors.buttonColor
        
        scrollView.addSubview(containerView)
        
        containerView.addSubview(descriptionImage)
        
        let hConst = containerView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        hConst.isActive = true
        hConst.priority = UILayoutPriority(50)
        
        let gradient = ImageGradient.shared.createGradientLayer(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 600), endColor: UIColor.white)
        descriptionImage.layer.addSublayer(gradient)
        
        containerView.addSubview(descriptionTitle)
        containerView.addSubview(descriptionText)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            containerView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            descriptionImage.topAnchor.constraint(equalTo: containerView.topAnchor),
            descriptionImage.leftAnchor.constraint(equalTo: containerView.leftAnchor),
            descriptionImage.rightAnchor.constraint(equalTo: containerView.rightAnchor),
            descriptionImage.heightAnchor.constraint(equalToConstant: 600),
            
            descriptionTitle.topAnchor.constraint(equalTo: descriptionImage.bottomAnchor, constant: 15),
            descriptionTitle.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 20),
            descriptionTitle.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -20),
            
            descriptionText.topAnchor.constraint(equalTo: descriptionTitle.bottomAnchor, constant: 10),
            descriptionText.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 20),
            descriptionText.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -20),
            descriptionText.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -80),
            
            dissmisButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            dissmisButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            
            customButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -34),
            customButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            customButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20)
        ])
    }
    
    func setTaskDescription(description: TaskDescription) {
        DispatchQueue.main.async {
            self.taskDescription = description
        }
    }
    
}
