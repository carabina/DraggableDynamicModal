//
//  ModalParentViewController.swift
//  DecathlonDraggableView
//
//  Created by Ali ABBAS on 16/05/2017.
//  Copyright © 2017 Decathlon. All rights reserved.
//

import Foundation
import UIKit
import ZFDragableModalTransition

public protocol ModalParentViewControllerProtocol: class {
    func shouldChangeContainerHeight() -> CGFloat?
}

public protocol ModalParentViewControllerLifecyleProtocol: class {
    func willDismissed()
}

public class ModalParentViewController: UIViewController {
    
    //MARK: Public
    var delegate: ModalParentViewControllerProtocol?
    var childDelegate: ModalParentViewControllerLifecyleProtocol?
    
    // MARK: Private
    private var draggableAnimator: ZFModalTransitionAnimator! = ZFModalTransitionAnimator()
    private var childController: UIViewController?
    private var needUpdateContainerHeight: Bool = false
    
    // MARK: IBOutlets - UIView
    @IBOutlet weak var containerView: UIView!
    
    // MARK: IBOutlets - NSLayoutConstraint
    @IBOutlet weak var childHeightConstraint: NSLayoutConstraint!
    
    // MARK: View Lifecycle
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.clear
        self.draggableAnimator = ZFModalTransitionAnimator(modalViewController: self)
        self.draggableAnimator.bounces = false
        self.draggableAnimator.isDragable = true
        self.draggableAnimator.direction = .bottom
        self.transitioningDelegate = self.draggableAnimator
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let childController = self.childController {
            self.addNewChild(viewController: childController)
        }
    }
    
    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override public func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if let delegate = self.delegate, let newHeight = delegate.shouldChangeContainerHeight(), self.needUpdateContainerHeight {
            self.updateContainerHeight(newValue: newHeight)
        }
    }
    
    deinit {
        print("deinit ModalParentViewController")
    }
    
    // MARK: Func
    func setup(controller: UIViewController) {
        self.childController = controller
    }
    
    func switchTo(controller: UIViewController) {
        for controller in self.childViewControllers {
            controller.willMove(toParentViewController: self)
            controller.view.removeFromSuperview()
            controller.removeFromParentViewController()
        }

        self.addNewChild(viewController: controller)
    }
    

    private func addNewChild(viewController: UIViewController) {
        self.childController = viewController
        self.addChildViewController(viewController)
        self.containerView.addSubview(viewController.view)
        self.constrainViewEqual(holderView: self.containerView, view: viewController.view)
        viewController.didMove(toParentViewController: self)
        //Set need container height update
        if let _ = self.delegate?.shouldChangeContainerHeight() {
            self.needUpdateContainerHeight = true
        }
    }
    
    private func updateContainerHeight(newValue: CGFloat = 0.0) {
        self.childHeightConstraint.constant = newValue
        UIView.animate(withDuration: 0.75, delay: 0.0, usingSpringWithDamping: 10, initialSpringVelocity: 10.0, options: UIViewAnimationOptions.curveEaseIn, animations: {[weak self] _ in
            self?.view.layoutIfNeeded()
        }) { _ in
          
        }
 
    }
    
    // MARK: Helpers 
    func constrainViewEqual(holderView: UIView, view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        //pin 100 points from the top of the super
        let pinTop = NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal,
                                        toItem: holderView, attribute: .top, multiplier: 1.0, constant: 0)
        let pinBottom = NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal,
                                           toItem: holderView, attribute: .bottom, multiplier: 1.0, constant: 0)
        let pinLeft = NSLayoutConstraint(item: view, attribute: .left, relatedBy: .equal,
                                         toItem: holderView, attribute: .left, multiplier: 1.0, constant: 0)
        let pinRight = NSLayoutConstraint(item: view, attribute: .right, relatedBy: .equal,
                                          toItem: holderView, attribute: .right, multiplier: 1.0, constant: 0)
        
        holderView.addConstraints([pinTop, pinBottom, pinLeft, pinRight])
    }
}
