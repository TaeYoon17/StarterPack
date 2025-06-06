//
//  SceneDelegate.swift
//  tuist_practice
//
//  Created by Greem on 5/21/25.
//

import Foundation
import UIKit
 
final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
 
//        let viewController = ViewController()
        
        window?.rootViewController = UINavigationController(rootViewController: ShoppingSearchViewController())
        window?.makeKeyAndVisible()
    }
}
