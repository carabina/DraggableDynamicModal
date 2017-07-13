//
//  ModalProtocol.swift
//  Decathlon
//
//  Created by Ali ABBAS on 24/04/2017.
//  Copyright © 2017 Oxylane. All rights reserved.
//

import Foundation
import ZFDragableModalTransition

protocol ModalViewControllerProtocol {
    func updateHeight(newValue: CGFloat)
}

protocol ModalContentHandlerProtocol {
    associatedtype T: Any
    var parentViewController: T { get }
    mutating func presentModal(viewController: UIViewController)
}

public struct ModalViewControllerManager: ModalContentHandlerProtocol {
    // MARK: - Public
    var parentViewController: UIViewController! = nil
    
    // MARK: - Private
    private weak var childController: UIViewController? = nil
    private weak var modalParentViewController: ModalParentViewController!
    
    public init(parentViewController: UIViewController!) {
        self.parentViewController = parentViewController
    }
    
    public mutating func presentModal(viewController: UIViewController) {
        if self.modalParentViewController == nil {
            let storyboardBundle = Bundle(for: ModalParentViewController.self)
            let bundleUrl = storyboardBundle.url(forResource: "DraggableDynamicModal", withExtension: "bundle")
            let bundle = Bundle(url: bundleUrl!)
            self.modalParentViewController = UIStoryboard(name: "DraggableDynamicModal", bundle: bundle).instantiateViewController(withIdentifier: "ModalParentViewControllerID") as! ModalParentViewController
            modalParentViewController.providesPresentationContextTransitionStyle = true
            modalParentViewController.definesPresentationContext = true
            //This option is verry important
            modalParentViewController.modalPresentationStyle = .overFullScreen
        }
        
        self.modalParentViewController.setup(controller: viewController)
        
        let shouldSwitch = (self.childController != nil)
        self.childController = viewController
        assert(self.childController is ModalParentViewControllerProtocol, "The child should conform to protocol ModalParentViewControllerProtocol")
        self.modalParentViewController.delegate = self.childController as! ModalParentViewControllerProtocol?
        if !shouldSwitch {
            self.parentViewController.present(modalParentViewController, animated: true, completion: nil)
        }else {
            self.modalParentViewController.switchTo(controller: self.childController!)
        }
    }
    
    func dismiss(completion: (() -> Void)?) {
        self.modalParentViewController.dismiss(animated: true, completion: completion)
    }
}
