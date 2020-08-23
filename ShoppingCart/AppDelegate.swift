//
//  AppDelegate.swift
//  ShoppingCart
//
//  Created by Aswani G on 7/25/20.
//  Copyright © 2020 pixycoders private limited. All rights reserved.
//

import UIKit
import FirebaseCrashlytics
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()

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

#if DEBUG
extension UIWindow {
    override open func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        #if !Production
        if motion == .motionShake {
            let ac = UIAlertController(title: "Tools", message: nil, preferredStyle: .actionSheet)
            ac.addAction(
                UIAlertAction(
                    title:"Mock Crash",
                    style: .default,
                    handler: { _ in
                        Crashlytics.crashlytics().setUserID("user_id")
                        fatalError()
                    }
                )
            )
            rootViewController?.present(ac, animated: true, completion: {
                ac.view.superview?.isUserInteractionEnabled = true
                ac.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.dismissOnTapOutside)))
            })
        }
        #endif
    }
    
    @objc private func dismissOnTapOutside()
    {
       rootViewController?.dismiss(animated: true, completion: nil)
    }
}
#endif
