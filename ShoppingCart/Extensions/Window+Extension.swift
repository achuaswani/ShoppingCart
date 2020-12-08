//
//  Window+Extension.swift
//  GiftHunteriOS
//
//  Created by Aswani G on 8/6/20.
//

import UIKit
import FirebaseCrashlytics

#if DEBUG
extension UIWindow {
    override open func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            let ac = UIAlertController(title: "Tools", message: nil, preferredStyle: .actionSheet)
            let mockCrashAction = UIAlertAction(title:"Mock Crash", style: .default, handler: { _ in
                Crashlytics.crashlytics().setUserID("user_id")
                fatalError("Mock crash")
            })
            let openWebKit = UIAlertAction(title: "Web Kit Test", style: .default, handler: { _ in
                self.rootViewController?.present(WebViewController(), animated: true)
            } )
            
            ac.addAction(mockCrashAction)
            ac.addAction(openWebKit)
            rootViewController?.present(ac, animated: true, completion: {
                guard let rootView = ac.view.superview?.subviews[0] else { return }
                rootView.isUserInteractionEnabled = true
                rootView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.dismissOnTapOutside)))
            })
        }
    }
    
    @objc private func mockCrash() {
        
    }
    
    @objc private func dismissOnTapOutside()
    {
        rootViewController?.dismiss(animated: true, completion: nil)
    }
}
#endif

