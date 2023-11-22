//
//  DetailViewController.swift
//  InvestApp
//
//  Created by shm on 2023/11/19.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var stockNameLabel: UILabel!
    @IBOutlet weak var mxprLabel: UILabel!
    @IBOutlet weak var llamLabel: UILabel!
    
    var stock: StockModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        
        stockNameLabel.text = stock?.name
        mxprLabel.text = stock?.id
        llamLabel.text = stock?.llam
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
}
