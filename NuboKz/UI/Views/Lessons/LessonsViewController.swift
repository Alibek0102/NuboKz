//
//  LessonsViewController.swift
//  NuboKz
//
//  Created by Алибек Аблайулы on 26.02.2024.
//

import UIKit

class LessonsViewController: UITableViewController, LessonsPresenterView {
    
    var presenter: LessonsPresenterProtocol!
    
    var subjects: [Subject] = []
    var stories: [Story] = []
    var sections: [Section] = []
    
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
        let segmentedController = UISegmentedControl()
        segmentedController.selectedSegmentIndex = 0
        
        segmentedController.translatesAutoresizingMaskIntoConstraints = false
        segmentedController.heightAnchor.constraint(equalToConstant: 35).isActive = true
        return segmentedController
    }()
    
    let myRefreshControl: UIRefreshControl = UIRefreshControl()
    
    @objc func updatePageWithRefresh(sender: UIRefreshControl) {
        self.presenter.getSubjects()
    }

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
        myRefreshControl.addTarget(self, action: #selector(updatePageWithRefresh(sender:)), for: .valueChanged)
        lessonsSegmentedController.addTarget(self, action: #selector(updateSectionsBySubject(sender:)), for: .valueChanged)
        tableView.refreshControl = myRefreshControl
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(LessonsCollectionViewCell.self, forCellWithReuseIdentifier: ListIds.stories.getId())
        
        presenterManager()
    }
    
    private func presenterManager() {
        presenter.getSubjects()
        presenter.getStories()
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
    
    func setSubjects(subjects: [Subject]) {
        DispatchQueue.main.async {
            self.myRefreshControl.endRefreshing()
            
            self.subjects = subjects
            self.lessonsSegmentedController.removeAllSegments()
            
            for (index, subject) in subjects.enumerated() {
                self.lessonsSegmentedController.insertSegment(withTitle: subject.name, at: index, animated: true)
            }
            
            self.lessonsSegmentedController.selectedSegmentIndex = 0
            
            if subjects.count != 0 {
                self.presenter.getSections(subject: self.subjects[0])
            }
        }
    }
    
    func setStories(stories: [Story]) {
        DispatchQueue.main.async {
            self.stories = stories
            self.collectionView.reloadData()
        }
    }
    
    func setSections(sections: [Section]) {
        DispatchQueue.main.async {
            self.sections = sections
            self.tableView.reloadData()
        }
    }
    
    @objc func updateSectionsBySubject(sender: UISegmentedControl) {
        let selectedIndex = sender.selectedSegmentIndex
        
        let subjectByIndex = subjects[selectedIndex]
        
        self.presenter.getSections(subject: subjectByIndex)
    }
    
    private func toKztTimeZone(date: Date) -> String {
        let kztTimeZone = TimeZone(identifier: "Asia/Almaty")
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = kztTimeZone
        dateFormatter.dateFormat = "dd.MM.yyyy"
        
        return dateFormatter.string(from: date)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sections.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListIds.lessonItem.getId(), for: indexPath) as! LessonsTableViewCell
        cell.lessonName.text = self.sections[indexPath.row].name
        cell.logoLabel.text = String(self.sections[indexPath.row].name.first!)
        cell.dateLabel.text = self.toKztTimeZone(date: self.sections[indexPath.row].createdAt)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 93
    }
}

extension LessonsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.stories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListIds.stories.getId(), for: indexPath) as! LessonsCollectionViewCell
        
        cell.story = stories[indexPath.row]
        return cell
    }
}

