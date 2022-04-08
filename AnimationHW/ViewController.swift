//
//  ViewController.swift
//  AnimationHW
//
//  Created by Marat Giniyatov on 08.04.2022.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet animationView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        UIView.animate(withDuration: 2.0) {
            self.animationView.
        } completion: { isFinish in
            print("Finished")
        }
    }


}

