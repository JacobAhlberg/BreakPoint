//
//  FirstViewController.swift
//  BreakPoint
//
//  Created by Jacob Ahlberg on 2017-11-28.
//  Copyright © 2017 Jacob Ahlberg. All rights reserved.
//

import UIKit

class FeedVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var messageArray = [Message]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DataService.instance.getAllFeedMessages { (returnedMessages) in
            self.messageArray = returnedMessages.reversed()
            self.tableView.reloadData()
        }
    }
}

extension FeedVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell") as? FeedCell else { return UITableViewCell() }
        let image = UIImage(named: "defaultProfileImage")
        let message = messageArray[indexPath.row]
        let content = message.content
        
        DataService.instance.getUsername(forUID: message.senderId) { (returnedUsername) in
            cell.configureCell(profileImage: image!, email: returnedUsername, content: content)
        }
        return cell
    }
    
    
}
