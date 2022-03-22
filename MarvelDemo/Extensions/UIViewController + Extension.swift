//
//  UIViewController + Extension.swift
//  CoreDataRelationShip
//
//  Created by Yogesh Patel on 20/01/22.
//

import UIKit

extension UIViewController{
    
    class func instantiateFromStoryboard(_ name: String = "Main") -> Self
    {
        return instantiateFromStoryboardHelper(name)
    }
    
    fileprivate class func instantiateFromStoryboardHelper<T>(_ name: String) -> T
    {
        let storyboard = UIStoryboard(name: name, bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "\(Self.self)") as! T
        return controller
    }
    
}


extension UIViewController {
    
    static func topMostViewController() -> UIViewController? {
        if #available(iOS 13.0, *) {
            let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            return keyWindow?.rootViewController?.checkingViewController()
        }
        
        return UIApplication.shared.keyWindow?.rootViewController?.checkingViewController()
    }
    
    func checkingViewController() -> UIViewController? {
        if let navigationController = self as? UINavigationController {
            return navigationController.topViewController?.checkingViewController()
        }
        
        else if let tabBarController = self as? UITabBarController {
            if let selectedViewController = tabBarController.selectedViewController {
                return selectedViewController.checkingViewController()
            }
            return tabBarController.checkingViewController()
        }
            
        else if let presentedViewController = self.presentedViewController {
            return presentedViewController.checkingViewController()
        }
        
        else {
            return self
        }
    }
}
