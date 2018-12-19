//
//  AppDelegate.swift
//  Todoapp
//
//  Created by alex oviedo on 13/12/2018.
//  Copyright © 2018 alex oviedo. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
                
        do {
            _ = try Realm()
        } catch {
            print("Error init new realm \(error)")
        }
        
        return true
    }
}

