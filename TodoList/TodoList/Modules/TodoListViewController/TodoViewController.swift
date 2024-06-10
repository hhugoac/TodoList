//
//  ViewController.swift
//  TodoList
//
//  Created by Hugo Alonzo on 25/05/24.
//

import UIKit

class TodoViewController: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    internal var items: [TodoListEntity] = []

    // MARK: - UI
     
    let tableview: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableview)
        getAllItems()
        tableview.delegate = self
        tableview.dataSource = self
        tableview.frame = view.bounds
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItemAlert))
        // Do any additional setup after loading the view.
    }

    @objc private func addItemAlert() {
        createOrUpdateItem(.create, nil)
    }
    
    // MARK: - CRUD methods for the database
    func getAllItems() {
        
        do {
            items = try context.fetch(TodoListEntity.fetchRequest())
            DispatchQueue.main.async {
                self.tableview.reloadData()
            }
        }catch{
            print("ERROR: cannot get the items")
        }
        
    } 
    
    func createItem(_ name: String) {
        let newItem = TodoListEntity(context: context)
        newItem.name = name
        newItem.createdAt = Date()
        saveContext()
    }
    
    func deleteItem(_ item: TodoListEntity) {
        context.delete(item)
        saveContext()
    }
    
    func updateItem(_ item: TodoListEntity, newName: String) {
        item.name = newName
        saveContext()
    }
    
    func saveContext() {
        do {
            try context.save()
            getAllItems()
        } catch {
            print("ERROR: cannot save the item")
        }
    }

}

