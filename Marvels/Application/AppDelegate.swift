//
//  AppDelegate.swift
//  Marvels
//
//  Created by Vikas on 02/06/19.
//  Copyright © 2019 Vikas. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        NetworkManager.shared.set(server: .development)
        /* Create module with navigation*/
        let charactersModule = CharacterListWireframe.createModule()
        let navigationController = MNavigationController(rootViewController: charactersModule)
        
        /* Initioal view controller */
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        // Override point for customization after application launch.
        return true
    }
}

