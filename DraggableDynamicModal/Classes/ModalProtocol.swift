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

struct ModalViewControllerManager: ModalContentHandlerProtocol {
    // MARK: - Public
    var parentViewController: UIViewController! = nil
    
    // MARK: - Private
    private weak var childController: UIViewController? = nil
    private weak var modalParentViewController: ModalParentViewController!
    
    init(parentViewController: UIViewController!) {
        self.parentViewController = parentViewController
    }
    
    mutating func presentModal(viewController: UIViewController) {
        if self.modalParentViewController == nil {
            self.modalParentViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ModalParentViewController") as! ModalParentViewController
            modalParentViewController.providesPresentationContextTransitionStyle = true
            modalParentViewController.definesPresentationContext = true
            //This option is verry important
            modalParentViewController.modalPresentationStyle = .overFullScreen
        }
        
        self.modalParentViewController.setup(controller: viewController)
        
        let shouldSwitch = (self.childController != nil)
        self.childController = viewController
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
