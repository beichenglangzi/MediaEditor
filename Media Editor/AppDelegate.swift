//
//  AppDelegate.swift
//  Media Editor
//
//  Created by Baptiste on 08/03/2020.
//  Copyright © 2020 BM. All rights reserved.
//

import UIKit

enum inputType {
    
    case category,
    colorPicker,
    optionSelector,
    slider
    
    
    
}

protocol inputableItem {
    
    var parentInputType: inputType { get }
}

struct ColorInputableItem: inputableItem {
    
    enum attrs {
        case color
    }
    
    var parentInputType: inputType { return .colorPicker }
    
    var attributes = [attrs: AnyObject]()

    func getInputData() -> UIColor? {
        return attributes[.color] as? UIColor
    }
}

protocol InputableType {}

struct ColorInputSelector {
    
    typealias InputType = InputableType
    
    var items: [ColorInputableItem]
    
    var itemSelectedIndex: Int
    
//    var itemSelected
}


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}
