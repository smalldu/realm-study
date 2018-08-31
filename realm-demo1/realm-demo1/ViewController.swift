//
//  ViewController.swift
//  realm-demo1
//
//  Created by 杜哲 on 2018/8/21.
//  Copyright © 2018年 duzhe. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
  
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var tableView: UITableView!
  private var items: Results<ToDoItem>?
  private var itemsToken: NotificationToken?
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setup()
  }
  
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    itemsToken = items?.observe({ [weak tableView] (changes) in
      guard let tableView = tableView else{  return }
      switch changes {
      case .initial:
        tableView.reloadData()
      case .update(_,let deletions,let insertions,let modifications):
        tableView.applyChanges(deletions: deletions, insertions: insertions, updates: modifications)
      case .error:
        break
      }
    })
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    itemsToken?.invalidate()
  }
  
  @IBAction func add(_ sender: Any) {
    userInputAlert("Add Todo Item") { text in
      ToDoItem.add(text: text)
    }
  }
  
  func toggleItem(_ item: ToDoItem) {
    item.toggleComplate()
  }
  func deleteItem(_ item: ToDoItem){
    item.delete()
  }
}


// MARK: - setup

extension ViewController{
  
  func setup(){
    tableView.delegate = self
    tableView.dataSource = self
    tableView.rowHeight = 50
    tableView.separatorInset = .zero
    tableView.tableFooterView = UIView()
    items = ToDoItem.all()
  }
  
}


// MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource{
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? ToDoCell ,
      let item = items?[indexPath.row] else {
        return ToDoCell(frame: .zero)
    }
    
    cell.configureWith(item) { [weak self] item in
      self?.toggleItem(item)
    }
    return cell
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return items?.count ?? 0
  }
  
}


// MARK: - Table View Delegate

extension ViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    if let cell = tableView.cellForRow(at: indexPath) as? ToDoCell{
      cell.toggleComplate()
    }
  }
  
  func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return true
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    guard let item = items?[indexPath.row],
      editingStyle == .delete else { return }
    deleteItem(item)
  }
  

}
