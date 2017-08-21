//
//  AppDelegate.swift
//  Restaurant Jacobsen
//
//  Created by int0x80 on 17/07/2017.
//  Copyright © 2017 int0x80. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, FirebaseDatabaseReference {

    var window: UIWindow?
    var ref: DatabaseReference!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        
        let tabBarController = self.window!.rootViewController as! UITabBarController
        let splitViewController = tabBarController.viewControllers?[3] as! UISplitViewController
        let leftNavigationController = splitViewController.viewControllers.first as! UINavigationController
        let masterViewController = leftNavigationController.topViewController as! MasterViewController
        
        let rightNavigationController = splitViewController.viewControllers.last as! UINavigationController
        let detailTableViewController = rightNavigationController.topViewController as! DetailTableViewController
        
        masterViewController.delegate = detailTableViewController
        
        /*let detailCollectionViewController = splitViewController.viewControllers.last as! DetailCollectionViewController
        
        masterViewController.delegate = detailCollectionViewController
        */
        downloadMenu()
        
        // MARK: Color theme for app
        UIApplication.shared.statusBarStyle = .lightContent
        let navigationBarAppearance = UINavigationBar.appearance()
        // TODO: Need to find a reasonable tint color
        navigationBarAppearance.tintColor = UIColor.yellow
        navigationBarAppearance.barTintColor = UIColor.init(rgb: 0x191919)
        navigationBarAppearance.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white]
        
        return true
    }
    
    func downloadMenu(){
        var menu = Menu()
        ref.child("MenuCategories").observe(.value, with: { snapshot in
            for (index, child) in snapshot.children.enumerated() {
                menu.menuCategories[index+1] = (Menu.Category.init(snapshot: child as! DataSnapshot))
                print(menu.menuCategories[index+1]?.name ?? "doh")
            }
        })
    }
    

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

