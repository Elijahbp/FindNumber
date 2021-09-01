//
//  RecordViewController.swift
//  FindNumber
//
//  Created by Илья Бучнев on 27.08.2021.
//

import UIKit

class RecordViewController: UIViewController {

    @IBOutlet weak var recordValueLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let record = UserDefaults.standard.integer(forKey: KeysUserDefaults.recordGame)
        if record != 0{
            recordValueLabel.text = "Your record: \(record)"
        }else {
            recordValueLabel.text = "Record not set"
        }
    }
    


}
