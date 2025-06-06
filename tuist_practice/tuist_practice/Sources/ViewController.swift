//
//  ViewController.swift
//  tuist_practice
//
//  Created by Greem on 5/25/25.
//

import UIKit
import PinLayout
import FlexLayout


final class ViewController: UIViewController {
    
    let avatarImage = UIImageView()
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Hello Flexlayout"
        return label
    }()
    let idLabel = UILabel()
    let jobLabel = UILabel()
    let ageLabel = UILabel()
    let descLabel = UILabel()
    
    let rootFlexCountainer = UIView()
    init() {

        super.init(nibName: nil, bundle: nil)
        view.addSubview(rootFlexCountainer)
        rootFlexCountainer.flex.direction(.column).alignItems(.center).define { flex in
            flex.addItem(avatarImage)
            flex.addItem(nameLabel)
            flex.addItem(descLabel)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        
        configureView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.rootFlexCountainer.pin.all(view.safeAreaInsets)
        self.rootFlexCountainer.flex.layout(mode: .adjustHeight)
    }
    
    func configureNavigation() {
        
        
        
    }
    
    func configureView() {
        
        
    }
}
