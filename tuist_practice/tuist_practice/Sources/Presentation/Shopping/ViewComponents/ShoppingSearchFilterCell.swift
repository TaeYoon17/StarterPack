//
//  ShoppingSearchFilterCell.swift
//  tuist_practice
//
//  Created by Greem on 6/7/25.
//

import UIKit
import Combine

final class ShoppingSearchFilterCell: UICollectionViewCell {
    // MARK: -- View Components...
    private let rootContainer = UIView()
    
    private let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "heart.fill")
        return imageView
    }()
    
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title3)
        return label
    }()
    
    private let heartMarkButton: UIButton = .heartButton
    
    private let descLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    
    // MARK: -- Private Properties...
    
    
    
    // MARK: -- Init...
    required init?(coder: NSCoder) {
        fatalError("Don't use storyboard.")
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    
    init(viewModel: ShoppingViewModel) {
        super.init(frame: .zero)
        
        self.contentView.addSubview(rootContainer)
        rootContainer.flex.define { [weak self] flex in
            guard let self else { return }
            
            flex.addItem(thumbnailImageView).addItem(heartMarkButton)
            flex.addItem(titleLabel).horizontally(2)
            flex.addItem(descLabel)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        rootContainer.pin.all() // PinLayout으로 위치/크기 지정
        rootContainer.flex.layout(mode: .adjustWidth) // FlexLayout으로 내부 레이아웃
//        rootContainerView.pin.all(view.safeAreaInsets)
//        rootContainerView.flex.layout(mode: .adjustHeight)
    }
    
    func configureLayout() {
        
    }
}


fileprivate extension UIButton {
    static var heartButton: UIButton {
        let button = UIButton()
        
         var config = UIButton.Configuration.plain()
         
         config.image = UIImage(systemName: "heart")
         config.background.backgroundColor = UIColor.lightGray
         config.cornerStyle = .capsule
         config.imagePlacement = .all
         config.background.strokeWidth = 1.5
         config.background.strokeColor = .white
         config.baseForegroundColor = .white
         
         button.configuration = config
         
         return button
    }
}
