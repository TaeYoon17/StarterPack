//
//  JudgmentTransitionaler.swift
//  RxCollectionViewStart
//
//  Created by Greem on 4/3/25.
//

import Foundation
import UIKit

class JudgmentTransitionaler: NSObject, UIViewControllerTransitioningDelegate {
  let transition = JudgmentTransition()
  
  func animationController(
    forPresented presented: UIViewController,
    presenting: UIViewController,
    source: UIViewController
  ) -> UIViewControllerAnimatedTransitioning? {
    transition.direction = .present
    transition.judgmentReadyView = (source as? JudgmentReadyViewController)?.view as? JudgmentReadyView
    transition.judgmentView = (presented as? JudgmentCompletedViewController)?.view as? JudgmentView
    return transition
  }
  
  func animationController(
    forDismissed dismissed: UIViewController
  ) -> UIViewControllerAnimatedTransitioning? {
    transition.direction = .dismiss
    return transition
  }
}
