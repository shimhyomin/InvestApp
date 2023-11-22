//
//  TradingViewController.swift
//  InvestApp
//
//  Created by shm on 2023/11/19.
//

import UIKit

class TradingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func buttonPressed(_ sender: UIButton) {
        APIService.requestOrderCash()
    }
}
