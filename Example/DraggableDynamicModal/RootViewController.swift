//
//  RootViewController.swift
//  DraggableDynamicModal
//
//  Created by Ali ABBAS on 13/07/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

class RootViewController: UIViewController {
    
    
    @IBAction func openModal(_ sender: Any) {
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as! ViewController
        self.present(viewController, animated: true, completion: nil)
    }
    
    
}
