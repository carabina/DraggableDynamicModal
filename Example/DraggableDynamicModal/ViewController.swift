//
//  ViewController.swift
//  DecathlonDraggableView
//
//  Created by Ali ABBAS on 12/05/2017.
//  Copyright © 2017 Decathlon. All rights reserved.
//

import UIKit
import ZFDragableModalTransition
import DraggableDynamicModal

class ViewController: UIViewController {
    
    var draggableAnimator: ZFModalTransitionAnimator! = ZFModalTransitionAnimator()
    var modalManager: ModalViewControllerManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.modalManager = ModalViewControllerManager(parentViewController: self)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func openModal(_ sender: Any) {
        let modal = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Modal") as! LabelModalViewController
        modalManager.presentModal(viewController: modal)
        modal.delegate = self
    }
}

extension ViewController: LabelModalViewControllerProtocol {
    func labelModalViewControllerProtocolSwitchMe() {
        let validate = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ValidateViewController") as! ValidateViewController
        self.modalManager.presentModal(viewController: validate)
    }
}
