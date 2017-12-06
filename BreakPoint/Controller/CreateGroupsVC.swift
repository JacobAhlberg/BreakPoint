//
//  CreateGroupsVC.swift
//  BreakPoint
//
//  Created by Jacob Ahlberg on 2017-12-05.
//  Copyright © 2017 Jacob Ahlberg. All rights reserved.
//

import UIKit

class CreateGroupsVC: UIViewController {
    
    @IBOutlet weak var titleTextField: InsetTextField!
    @IBOutlet weak var descriptionTextField: InsetTextField!
    @IBOutlet weak var emailsSearchTextField: InsetTextField!
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var groupMemberLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var emailArray = [String]()
    var chosenArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        emailsSearchTextField.delegate = self
        emailsSearchTextField.addTarget(self, action: #selector(textFieldDidChanged), for: .editingChanged)
        
    }
    
    @objc func textFieldDidChanged() {
        if emailsSearchTextField.text == "" {
            emailArray = []
            tableView.reloadData()
        } else {
            DataService.instance.getEmailForSearchQuery(forSearchQuery: emailsSearchTextField.text!, handler: { (returnedEmailArray) in
                self.emailArray = returnedEmailArray
                self.tableView.reloadData()
            })
        }
    }
    
    @IBAction func doneBtnWasPressed(_ sender: Any) {
        
    }
    @IBAction func closeBtnWasPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension CreateGroupsVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emailArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as? UserCell else { return UITableViewCell() }
        let profileImage = UIImage(named: "defaultProfileImage")
        
        cell.configureCell(profileImage: profileImage!, email: emailArray[indexPath.row], isSelected: false)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "userCell") as? UserCell else { return }
        if !chosenArray.contains(cell.emailLbl.text!) {
            chosenArray.append(cell.emailLbl.text!)
            groupMemberLbl.text = chosenArray.joined(separator: ", ")
        }
    }
}

extension CreateGroupsVC: UITextFieldDelegate {

}


