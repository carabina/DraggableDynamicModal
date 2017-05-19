//
//  LabelModalViewController.swift
//  DecathlonDraggableView
//
//  Created by Ali ABBAS on 16/05/2017.
//  Copyright © 2017 Decathlon. All rights reserved.
//

import UIKit
import DraggableDynamicModal

protocol LabelModalViewControllerProtocol: class {
    func labelModalViewControllerProtocolSwitchMe()
}

class LabelModalViewController: UIViewController, ModalParentViewControllerProtocol {

    var delegate: LabelModalViewControllerProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func switchMe(_ sender: Any) {
        self.delegate?.labelModalViewControllerProtocolSwitchMe()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func shouldChangeContainerHeight() -> CGFloat? {
        return 400
    }
}
