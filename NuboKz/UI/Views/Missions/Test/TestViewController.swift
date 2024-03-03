//
//  TestViewController.swift
//  NuboKz
//
//  Created by Алибек Аблайулы on 03.03.2024.
//

import UIKit

class TestViewController: UIViewController {
    
    var missionId: String?
    
    let testQuestions: [Question] = [
        Question(missionId: "1", questionId: "1", answers: [
            Answer(id: "1", answer: "Hello world"),
            Answer(id: "2", answer: "Hello world"),
            Answer(id: "3", answer: "Hello world"),
            Answer(id: "4", answer: "Hello world")
        ], question: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,"),
        Question(missionId: "1", questionId: "1", answers: [
            Answer(id: "1", answer: "Hello world 2"),
            Answer(id: "2", answer: "Hello world 2"),
            Answer(id: "3", answer: "Hello world 2"),
            Answer(id: "4", answer: "Hello world 2")
        ], question: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,222"),
    ]
    
    let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.isPagingEnabled = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    
    let goBackButton: UIView = {
        
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.backward")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 25).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 25).isActive = true
        
        let button = UIButton()
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        button.addSubview(imageView)
        
        imageView.centerXAnchor.constraint(equalTo: button.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: button.centerYAnchor).isActive = true
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColors.lightGreen
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(TestCollectionViewCell.self, forCellWithReuseIdentifier: ListIds.testId.getId())
        
        setupHeaderElements()
    }
    
    func setupHeaderElements() {
        view.addSubview(headerView)
        view.addSubview(collectionView)
        
        headerView.addSubview(goBackButton)
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.topAnchor),
            headerView.leftAnchor.constraint(equalTo: view.leftAnchor),
            headerView.rightAnchor.constraint(equalTo: view.rightAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 130),
            
            goBackButton.topAnchor.constraint(equalTo: headerView.safeAreaLayoutGuide.topAnchor),
            goBackButton.leftAnchor.constraint(equalTo: headerView.leftAnchor, constant: 20),
            
            collectionView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
}


extension TestViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return testQuestions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListIds.testId.getId(), for: indexPath) as! TestCollectionViewCell
        var question = testQuestions[indexPath.row]
        cell.setupQuestionElements(question: question)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.size.width
        let heigth = collectionView.frame.size.height
        
        return CGSize(width: width, height: heigth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
