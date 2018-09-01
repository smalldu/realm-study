//
//  ToDoItem.swift
//  realm-demo1
//
//  Created by 杜哲 on 2018/8/22.
//  Copyright © 2018年 duzhe. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers class ToDoItem: Object {
  
  enum Property: String {
    case id, text, isCompleted , createAt
  }
  
  dynamic var id = UUID().uuidString
  dynamic var text = ""
  dynamic var isCompleted = false
  dynamic var createAt = Date()
  
  override static func primaryKey() -> String? {
    return ToDoItem.Property.id.rawValue
  }
  
  convenience init(_ text: String) {
    self.init()
    self.text = text
  }
}

// MARK: - 增删改查

extension ToDoItem {
  
  static func all(in realm: Realm = try! Realm()) -> Results<ToDoItem>{
    return realm.objects(ToDoItem.self)
      .sorted(byKeyPath: ToDoItem.Property.isCompleted.rawValue)
  }
  
  @discardableResult
  static func add(text: String,in realm: Realm = try! Realm()) -> ToDoItem {
    let item = ToDoItem(text)
    try? realm.write {
      realm.add(item)
    }
    return item
  }
  
  // 每个对象都有一个realm属性，返回这个对象当前存储的realm
  func toggleComplate(){
    guard let realm = realm else {
      return
    }
    try? realm.write {
      isCompleted = !isCompleted
    }
  }
  
  // 删除
  func delete(){
    guard let realm = realm else {
      return
    }
    try? realm.write {
      realm.delete(self)
    }
  }
  
}


