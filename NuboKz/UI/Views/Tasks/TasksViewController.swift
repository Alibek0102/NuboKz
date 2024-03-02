//
//  TasksViewController.swift
//  NuboKz
//
//  Created by Алибек Аблайулы on 29.02.2024.
//

import UIKit

class TasksViewController: UITableViewController, TasksPresenterView {
    
    let tasksId: String = "tasksId"
    
    var presenter: TasksPresenterProtocol?
    
    var tasks: [Task] = []
    
    var section: Section?
    
    var delegate: LessonsViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TasksTableViewCell.self, forCellReuseIdentifier: tasksId)
        tableView.separatorStyle = .none
        title = section?.name
        getDataManager()
        
    }
    
    func getDataManager() {
        presenter?.getTasksBySectionId(sectionId: section?.sectionId)
    }
    
    func setTasks(tasks: [Task]) {
        DispatchQueue.main.async {
            self.tasks = tasks
            self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tasksId, for: indexPath) as! TasksTableViewCell
        cell.taskNameLabel.text = self.tasks[indexPath.row].name
        cell.taskLevelLabel.text = "Уровень: \(self.tasks[indexPath.row].level)"
        cell.indexPath = indexPath
        cell.bonusLabel.text = "\(self.tasks[indexPath.row].bonus)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let task = self.tasks[indexPath.row]
        delegate?.eventPlay(event: .description(id: task.taskId))
    }
    
}
