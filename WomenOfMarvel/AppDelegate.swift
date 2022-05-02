//
//  AppDelegate.swift
//  WomenOfMarvel
//
//  Created by fmustafa on 5/2/22.
//

import UIKit
import SwiftKeychainWrapper

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        // Add API keys into the Keychain
        if KeychainWrapper.standard.string(forKey: "privateKey") == nil {
            KeychainWrapper.standard.set(CONFIG.privateKey,
                                         forKey: "privateKey")
        }

        if KeychainWrapper.standard.string(forKey: "publicKey") == nil {
            KeychainWrapper.standard.set(CONFIG.publicKey,
                                         forKey: "publicKey")
        }

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

