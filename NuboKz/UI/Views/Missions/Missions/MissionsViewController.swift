//
//  MissionsViewController.swift
//  NuboKz
//
//  Created by Алибек Аблайулы on 02.03.2024.
//

import UIKit

protocol MissionsTappedDelegate {
    func getTappedMission(indexPath: IndexPath?)
}

class MissionsViewController: UITableViewController, MissionCoordinating, MissionPresenterView {
    
    var finishFlow: boolClosure?
    var performEvent: performMissionCoordinatorEvents?
    var taskId: String?
    
    var allMissions: [Mission] = []
    
    var presenter: MissionPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backButtonTitle = "artqa"
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MissionsTableViewCell.self, forCellReuseIdentifier: ListIds.missionsItem.getId())
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        title = "Задачи"
        
        getMissions()
    }
    
    func getMissions() {
        self.presenter?.getMissionsByTaskId(taskId: self.taskId)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListIds.missionsItem.getId(), for: indexPath) as! MissionsTableViewCell
        cell.indexPath = indexPath
        cell.delegate = self
        
        let mission = self.allMissions[indexPath.row]
        
        switch mission {
        case .test(let step, let missionId, let text):
            cell.setupButtonTitle()
            cell.descriptionOfMission.text = text
            cell.missionId = missionId
        }
        
        
//        cell.blockPerformButton()
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.allMissions.count
    }
    
    func setMissions(data: [Mission]) {
        DispatchQueue.main.async {
            self.allMissions = data
            self.tableView.reloadData()
        }
    }
    
}

extension MissionsViewController: MissionsTappedDelegate {
    func getTappedMission(indexPath: IndexPath?) {
        guard let indexPath = indexPath else { return }
        
        let sendMission = allMissions[indexPath.row]
        
        let viewController = MissionInfoViewController()
        viewController.modalPresentationStyle = .overCurrentContext
        
        viewController.mission = sendMission
        
        viewController.startFlow = { result in
            if result == true {
                print("start task")
            }
        }
        
        present(viewController, animated: true)
    }

}
