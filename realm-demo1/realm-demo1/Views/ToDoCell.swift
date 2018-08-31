//
//  ToDoCell.swift
//  realm-demo1
//
//  Created by 杜哲 on 2018/8/22.
//  Copyright © 2018年 duzhe. All rights reserved.
//

import UIKit

class ToDoCell: UITableViewCell {
  
  private var onToggleCompleted: ((ToDoItem) -> Void)?
  
  private var item: ToDoItem?
  
  @IBOutlet var label: UILabel!
  @IBOutlet var button: UIButton!
  
  @IBAction func toggleComplate(){
    guard let item = item else { fatalError("Missing Todo Item") }
    
    onToggleCompleted?(item)
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    label.font = UIFont.systemFont(ofSize: 15)
  }
  
  func configureWith(_ item: ToDoItem, onToggleCompleted: ((ToDoItem) -> Void)? = nil) {
    self.item = item
    self.onToggleCompleted = onToggleCompleted
    
    label.attributedText = NSAttributedString(string: item.text,
                                              attributes: item.isCompleted ? [.strikethroughStyle: true] : [:])
    button.setImage(item.isCompleted ? #imageLiteral(resourceName: "check"):#imageLiteral(resourceName: "uncheck") , for: .normal)
  }
  
}

