//
//  AppDelegate.swift
//  realm-demo1
//
//  Created by 杜哲 on 2018/8/21.
//  Copyright © 2018年 duzhe. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    initializeRealm()
    return true
  }
  
  func initializeRealm() {
    let realm = try! Realm()
    guard realm.isEmpty else { return }
    
    try? realm.write {
      realm.add( ToDoItem("买早餐") )
      realm.add( ToDoItem("读书") )
    }
    
  }
  
  
  
}

