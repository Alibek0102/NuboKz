//
//  MissionsViewController.swift
//  NuboKz
//
//  Created by Алибек Аблайулы on 02.03.2024.
//

import UIKit

class MissionsViewController: UITableViewController, MissionCoordinating {
    var finishFlow: boolClosure?
    var performEvent: performMissionCoordinatorEvents?
    var taskId: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backButtonTitle = "artqa"
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MissionsTableViewCell.self, forCellReuseIdentifier: ListIds.missionsItem.getId())
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        title = "Задачи"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListIds.missionsItem.getId(), for: indexPath) as! MissionsTableViewCell
        cell.indexPath = indexPath
        
//        cell.setupButtonTitle()
        cell.blockPerformButton()
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
}
