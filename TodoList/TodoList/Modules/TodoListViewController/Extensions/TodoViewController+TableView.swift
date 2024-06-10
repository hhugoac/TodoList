//
//  TodoViewController+TableView.swift
//  TodoList
//
//  Created by Hugo Alonzo on 25/05/24.
//

import UIKit

@frozen enum States{
    case none
    case update
    case create
}

extension TodoViewController: UITableViewDelegate {

    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = items[indexPath.row]
        
        sheetActions(items[indexPath.row])
    }
    
    func sheetActions(_ item: TodoListEntity) {
        DispatchQueue.main.async {
            let sheet = UIAlertController(title: "Enter a new task", message: "New item ", preferredStyle: .actionSheet)
            sheet.addAction(UIAlertAction(title: "Edit", style: .default){
                [weak self] _ in
                self?.createOrUpdateItem(.create, item)
            })
            sheet.addAction(UIAlertAction(title: "Delete", style: .default){
                [weak self] _ in
                self?.deleteItem(item)
            })
            sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            self.present(sheet, animated: true)
            
        }
    }
    
    /*func editItem(_ item: TodoListEntity) {
        let alert = UIAlertController(title: "Edit item", message: "", preferredStyle: .alert)
        alert.addTextField()
        alert.textFields?.first?.text = item.name
        alert.addAction(UIAlertAction(title: "Save", style: .default){
            [weak self] _ in
            guard let field = alert.textFields?.first, let newName = field.text, !newName.isEmpty else {
                return
            }
            self?.updateItem(item, newName: newName)
        })
        self.present(alert, animated: true)
        print("Enter into edit")
    }
    
    func updateItem(_ item: TodoListEntity) {
        let alert = UIAlertController(title: "Are you sure to delete?", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "No", style: .cancel))
        alert.addAction(UIAlertAction(title: "Yes", style: .default){
            [weak self] _ in
            self?.deleteItem(item)
        })
        self.present(alert, animated: true)
        print("Enter into delete")
    }*/

    func createOrUpdateItem(_ state: States, _ item: TodoListEntity?) {
        DispatchQueue.main.async {
            let title = state == .update ? "Upadate item" : "Create a new item"
            let alert = UIAlertController(title: title, message: "New item ", preferredStyle: .alert)
            
            alert.addTextField()
            if state == .update {
                alert.textFields?.first?.text = item?.name
            }
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            alert.addAction(UIAlertAction(title: "Save", style: .default){
                [weak self] _ in
                guard let field = alert.textFields?.first, let text = field.text,
                      !text.isEmpty else {
                    return
                }
                
                if state == .update {
                    if let item = item {
                        self?.updateItem(item, newName: text)}
                } else {
                    self?.createItem(text)
                }
            })
            /*sheet.addAction(UIAlertAction(title: "Edit", style: .default){
                [weak self] _ in
                self?.editItem(item)
            })
            sheet.addAction(UIAlertAction(title: "Delete", style: .default){
                [weak self] _ in
                
            })
            sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))*/
            //self.present(sheet, animated: true)
            
        }
    }
    
}

extension TodoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row].name
        return cell
    }
}
