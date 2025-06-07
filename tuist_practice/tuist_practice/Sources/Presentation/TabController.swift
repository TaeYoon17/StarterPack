//
//  TabController.swift
//  tuist_practice
//
//  Created by Greem on 6/7/25.
//

import UIKit
import Combine


final class TabController: UITabBarController {
    
    private lazy var shoppingViewControllerTab: UIViewController = {
        let tabItem = UITabBarItem(title: "검색", image: UIImage(systemName: "magnifyingglass"), tag: 0)
        let vc = ShoppingSearchViewController()
        let nav = UINavigationController(rootViewController: vc)
        nav.tabBarItem = tabItem
        return nav
    }()
    
    private lazy var helloViewControllerTab: UIViewController = {
        let tabItem = UITabBarItem(title: "즐겨찾기", image: UIImage(systemName: "star.fill"), tag: 1)
        let vc = ShoppingSearchViewController()
        let nav = UINavigationController(rootViewController: vc)
        nav.tabBarItem = tabItem
        return nav
    }()
    
    private var cancellables: Set<AnyCancellable> = .init()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Don't use storyboard")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        viewControllers = [shoppingViewControllerTab, helloViewControllerTab]
    }
}
