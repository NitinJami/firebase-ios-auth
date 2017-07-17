//
//  AppDelegate.swift
//  firebase-ios-auth
//
//  Created by Nitin Jami on 2/23/17.
//  Copyright © 2017 Nitin Jami. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Use Firebase library to configure APIs
        FIRApp.configure()
        
        if window == nil {
            window = UIWindow(frame: UIScreen.main.bounds)
        }
        
        if (FIRAuth.auth()?.currentUser != nil) {
            LaunchViewController.Balance.setAsRootviewController(animated: true)
        } else {
            LaunchViewController.Login.setAsRootviewController(animated: true)
        }
        return true
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

extension AppDelegate {
    
    enum LaunchViewController {
        case Login, Balance
        
        var viewController: UIViewController {
            switch self {
            case .Login: return StoryboardScene.Main.initialViewController()
            case .Balance: return StoryboardScene.Main.Balance.viewController()
            }
        }
        
        /// Sets `UIWindow().rootViewController` to the appropriate view controller, by default this runs without an animation.
        func setAsRootviewController(animated: Bool = false) {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let window = appDelegate.window!
            let launchViewController = viewController
            
            print("Setting \(type(of: launchViewController)) as rootViewController")
            if let rootViewController = window.rootViewController, type(of: rootViewController) != type(of: launchViewController) && animated {
                let overlayView = UIScreen.main.snapshotView(afterScreenUpdates: false)
                launchViewController.view.addSubview(overlayView)
                
                UIView.animate(withDuration: 0.3, animations: {
                    overlayView.alpha = 0.0
                },
                                           completion: { _ in
                                            overlayView.removeFromSuperview()
                });
            }
            
            window.rootViewController = launchViewController
            window.restorationIdentifier = String(describing: type(of: launchViewController))
            
            if window.isKeyWindow == false {
                window.makeKeyAndVisible()
            }
        }
    }
}

protocol StoryboardSceneType {
    static var storyboardName: String { get }
}

extension StoryboardSceneType {
    static func storyboard() -> UIStoryboard {
        return UIStoryboard(name: self.storyboardName, bundle: nil)
    }
    
    static func initialViewController() -> UIViewController {
        guard let vc = storyboard().instantiateInitialViewController() else {
            fatalError("Failed to instantiate initialViewController for \(self.storyboardName)")
        }
        return vc
    }
}

extension StoryboardSceneType where Self: RawRepresentable, Self.RawValue == String {
    func viewController() -> UIViewController {
        return Self.storyboard().instantiateViewController(withIdentifier: self.rawValue)
    }
    static func viewController(identifier: Self) -> UIViewController {
        return identifier.viewController()
    }
}

protocol StoryboardSegueType: RawRepresentable { }

extension UIViewController {
    func perform<S: StoryboardSegueType>(segue: S, sender: Any? = nil) where S.RawValue == String {
        performSegue(withIdentifier: segue.rawValue, sender: sender)
    }
}

enum StoryboardScene {
    enum LaunchScreen: StoryboardSceneType {
        static let storyboardName = "LaunchScreen"
    }
    enum Main: String, StoryboardSceneType {
        static let storyboardName = "Main"
        
        case Login = "Login"
        static func loginViewController() -> LoginViewController {
            return Main.Login.viewController() as! LoginViewController
        }
        
        case Balance = "Balance"
        static func balanceViewController() -> VendorBalanceViewController {
            return Main.Balance.viewController() as! VendorBalanceViewController
        }
    }
}
