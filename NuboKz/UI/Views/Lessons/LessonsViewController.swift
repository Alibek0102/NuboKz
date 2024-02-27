//
//  LessonsViewController.swift
//  NuboKz
//
//  Created by Алибек Аблайулы on 26.02.2024.
//

import UIKit

class LessonsViewController: UITableViewController {
    
    var presenter: LessonsPresenterProtocol!
    
    let rightView: UIStackView = {
        let rightView = UIStackView()
        rightView.axis = .horizontal
        rightView.distribution = .equalSpacing
        rightView.translatesAutoresizingMaskIntoConstraints = false
        rightView.widthAnchor.constraint(equalToConstant: 90).isActive = true
        rightView.heightAnchor.constraint(equalToConstant: 35).isActive = true
        return rightView
    }()
    
    let notificationButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(.notificationIcon, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        button.widthAnchor.constraint(equalToConstant: 37).isActive = true
        return button
    }()
    
    let infoButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(.infoIcon, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        button.widthAnchor.constraint(equalToConstant: 37).isActive = true
        return button
    }()
    
    let tableHeaderView: UIView = {
        let headerView = UIView()
        return headerView
    }()
    
    let collectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .horizontal
        collectionViewLayout.itemSize = CGSize(width: 105, height: 125)
        collectionViewLayout.headerReferenceSize = CGSize(width: 20, height: 0)
        collectionViewLayout.footerReferenceSize = CGSize(width: 20, height: 0)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    let lessonsSegmentedController: UISegmentedControl = {
        let segmentedController = UISegmentedControl(items: ["Программирование", "Информатика"])
        segmentedController.selectedSegmentIndex = 0
        
        segmentedController.translatesAutoresizingMaskIntoConstraints = false
        segmentedController.heightAnchor.constraint(equalToConstant: 35).isActive = true
        return segmentedController
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        title = "Предметы"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        setRightHeaderlement()
        setTableViewHeader()
        setupStoriesCollectionView()
        
        tableView.register(LessonsTableViewCell.self, forCellReuseIdentifier: ListIds.lessonItem.getId())
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(LessonsCollectionViewCell.self, forCellWithReuseIdentifier: ListIds.stories.getId())
        
        presenterManager()
    }
    
    private func presenterManager() {
        presenter.getSubjects()
    }
    
    private func setRightHeaderlement() {
        rightView.addArrangedSubview(notificationButton)
        rightView.addArrangedSubview(infoButton)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightView)
    }
    
    private func setTableViewHeader() {
        tableHeaderView.frame = .init(x: 0, y: 0, width: self.view.frame.width, height: 200)
        self.tableView.tableHeaderView = tableHeaderView
        
        tableHeaderView.addSubview(lessonsSegmentedController)
        
        NSLayoutConstraint.activate([
            lessonsSegmentedController.bottomAnchor.constraint(equalTo: tableHeaderView.bottomAnchor, constant: -10),
            lessonsSegmentedController.leftAnchor.constraint(equalTo: tableHeaderView.leftAnchor, constant: 20),
            lessonsSegmentedController.rightAnchor.constraint(equalTo: tableHeaderView.rightAnchor, constant: -20)
        ])
    }
    
    private func setupStoriesCollectionView() {
        tableHeaderView.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: tableHeaderView.topAnchor),
            collectionView.rightAnchor.constraint(equalTo: tableHeaderView.rightAnchor),
            collectionView.leftAnchor.constraint(equalTo: tableHeaderView.leftAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 140)
        ])
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListIds.lessonItem.getId(), for: indexPath) as! LessonsTableViewCell
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 93
    }
}

extension LessonsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListIds.stories.getId(), for: indexPath) as! LessonsCollectionViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! LessonsCollectionViewCell
        cell.createLayer()
    }
}

