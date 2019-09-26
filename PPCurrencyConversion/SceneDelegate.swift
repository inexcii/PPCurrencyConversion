//
//  SceneDelegate.swift
//  PPCurrencyConversion
//
//  Created by Yuan Zhou on 2019/09/25.
//  Copyright © 2019 Yuan Zhou. All rights reserved.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).

        var userData: UserData
        
        if let currencies = DBUtil.shared.readCurrencies(), currencies.count > 0 {
            // if currency exists
            userData = UserData(currencies: ModelHandler.getModels(from: currencies))
        } else {
            NSLog("no currency exists in DB, must to fetch from API")
            // use empty data to construct UI
            userData = UserData(currencies: [Currency]())
            
            let loader = Loader()
            let parser = JsonParser()
            
            // fetch name-abbr-rate values of the currencies from API
            loader.load(url: URL(string: Constants.ApiName)!) { data in
                guard let data = data else { return }
                let namesDic = parser.parseName(data: data)
                let namesDicSortedKeys = Array(namesDic.keys).sorted()
                loader.load(url: URL(string: Constants.ApiRate)!) { data in
                    guard let data = data else { return }
                    let ratesDic = parser.parseRates(data: data)
                    DispatchQueue.main.async {
                        // save to DB
                        let currencies = DBUtil.shared.createCurrencies(keys: namesDicSortedKeys,
                                                                        namesDic: namesDic,
                                                                        ratesDic: ratesDic)
                        // update models so as to refresh UI
                        if let currencies = currencies {
                            userData.currencies = ModelHandler.getModels(from: currencies)
                        } else {
                            print("no currencies found in DB after being saved")
                        }
                    }
                }
            }
        }
        
        // Get the managed object context from the shared persistent container.
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

        // Create the SwiftUI view and set the context as the value for the managedObjectContext environment keyPath.
        // Add `@Environment(\.managedObjectContext)` in the views that will need the context.
        let listView = ListView()
            .environment(\.managedObjectContext, context)
            .environmentObject(userData)

        // Use a UIHostingController as window root view controller.
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: listView)
            self.window = window
            window.makeKeyAndVisible()
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}

