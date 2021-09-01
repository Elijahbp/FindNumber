//
//  GreenViewController.swift
//  FindNumber
//
//  Created by Илья Бучнев on 10.08.2021.
//

import UIKit

class GreenViewController: UIViewController {
    var textForLabel:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func goToRootMenu(_ sender: Any) {
        //navigationController?.popToRootViewController(animated: true)
        if let viewController = navigationController?.viewControllers{
            for vc in viewController{
                if vc is YellowViewController{
                    self.navigationController?.popToViewController(vc, animated: true)
                }

            }
        }
    }

}
