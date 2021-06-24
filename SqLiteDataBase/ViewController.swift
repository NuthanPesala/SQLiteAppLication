//
//  ViewController.swift
//  SqLiteDataBase
//
//  Created by Nuthan Raju Pesala on 11/06/21.
//

import UIKit
import SQLite

struct User {
    var name: String
    var email: String
}

class ViewController: UIViewController {

    var dataBase: Connection! = nil
    
    let usersTable = Table("Users")
    
    let id = Expression<Int>("Id")
    let name = Expression<String>("Name")
    let emailId = Expression<String>("Email Id")
    
    var users = [User]()
    
    private lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tv.dataSource = self
        tv.delegate = self
        tv.tableFooterView = UIView()
        return tv
    }()
    
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Users"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(didTapSelect))
        self.view.addSubview(tableView)
        tableView.frame = view.bounds
        
        do {
            let downloadDirectory = try FileManager.default.url(for: .downloadsDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileUrl = downloadDirectory.appendingPathComponent("Users").appendingPathExtension("sqlite3")
            let dataBase = try Connection(fileUrl.path)
            print(fileUrl.path)
            self.dataBase = dataBase
            self.createTable()
        }
        catch {
            print(error)
         }
        self.getAllUsers()
    }

    func createTable() {
        let createTable = self.usersTable.create { (table) in
            table.column(self.id, primaryKey: true)
            table.column(self.name)
            table.column(self.emailId, unique: true)
        }
        do {
            try dataBase.run(createTable)
            print("Table Created")
        }
        catch {
            print(error)
        }
    }
    
    @objc func didTapAdd() {
        let alertController = UIAlertController(title: "Add Person", message: "", preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "Enter UserName..."
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "Enter User Email..."
        }
        alertController.addAction(UIAlertAction(title: "Save", style: .default, handler: { (action) in
            guard let name = alertController.textFields?[0].text else {
                return
            }
            guard let email = alertController.textFields?[1].text else {
                return
            }
            let insertobject = self.usersTable.insert(self.name <- name, self.emailId <- email)
            do {
                try self.dataBase.run(insertobject)
                self.getAllUsers()
            }
            catch {
                print(error)
            }
            
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }

    func getAllUsers() {
        do {
        let users = try  self.dataBase.prepare(usersTable)
            self.users = [User]()
            for user in users {
                self.users.append(User(name: user[self.name], email: user[self.emailId]))
            }
            if self.users.count != 0 {
                self.tableView.reloadData()
            }
        }
        catch {
            print(error)
        }
    }
    
    func updateUser(name: String, email: String) {
        let alertController = UIAlertController(title: "Update Person", message: "", preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.text = name
        }
        alertController.addTextField { (textField) in
            textField.text = email
        }
        alertController.addAction(UIAlertAction(title: "Save", style: .default, handler: { (action) in
            guard let updateName = alertController.textFields?[0].text else {
                return
            }
            guard let updateEmail = alertController.textFields?[1].text else {
                return
            }
            let updateUser = self.usersTable.filter(self.name == name)
            let updateobject = updateUser.update(self.name <- updateName, self.emailId <- updateEmail)
            do {
                try self.dataBase.run(updateobject)
                self.getAllUsers()
            }
            catch {
                print(error)
            }
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    func deleteUser(name: String) {
        let deleteUser = self.usersTable.filter(self.name == name)
        let deleteObject = deleteUser.delete()
        do {
            try self.dataBase.run(deleteObject)
            self.getAllUsers()
        }
        catch {
            print(error)
        }
    }
    
    @objc func didTapSelect() {
      let vc = SecondViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension ViewController:  UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.users.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = self.users[indexPath.row].name
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let user = self.users[indexPath.row]
        let actionSheet = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        actionSheet.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { (action) in
            self.deleteUser(name: user.name)
        }))
        actionSheet.addAction(UIAlertAction(title: "Update", style: .default, handler: { (action) in
            self.updateUser(name: user.name, email: user.email)
        }))
        self.present(actionSheet, animated: true, completion: nil)
      
    }
    
}


