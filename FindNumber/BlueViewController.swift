//
//  BlueViewController.swift
//  FindNumber
//
//  Created by Илья Бучнев on 10.08.2021.
//

import UIKit

class BlueViewController: UIViewController {

    @IBOutlet weak var testLabel: UILabel!
    var textForLabel = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        testLabel.text = textForLabel
        // Do any additional setup after loading the view.
    }
    
    @IBAction func goToGreenController(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "greenVC") as? GreenViewController{
            vc.textForLabel = "Text for green view controller"
            vc.title = "Зеленый"
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
