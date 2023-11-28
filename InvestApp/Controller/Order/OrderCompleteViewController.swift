//
//  OrderCompleteViewController.swift
//  InvestApp
//
//  Created by shm on 2023/11/28.
//

import UIKit

class OrderCompleteViewController: UIViewController {

    @IBOutlet weak var stockNameLabel: UILabel!
    @IBOutlet weak var stockIDLabel: UILabel!
    @IBOutlet weak var odnoLabel: UILabel!
    @IBOutlet weak var ordTMDLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "주문완료"
        self.navigationItem.hidesBackButton = true
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    @IBAction func gotoRootButtonPressed(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: false)
    }
    
}
