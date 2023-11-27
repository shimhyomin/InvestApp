//
//  PopupViewController.swift
//  InvestApp
//
//  Created by shm on 2023/11/28.
//

import UIKit

class PopupViewController: UIViewController {

    @IBOutlet weak var msgTextView: UITextView!
    var msg: String = "오류"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //to do 오류 메세지!!!
        msgTextView.text = msg
    }
    @IBAction func closePopup(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
    
}
