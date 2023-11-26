//
//  OrderConfirmViewController.swift
//  InvestApp
//
//  Created by shm on 2023/11/26.
//

import UIKit
import SwiftUI

class OrderConfirmViewController: UIViewController {
    
    @IBOutlet weak var stockNameLabel: UILabel!
    @IBOutlet weak var stockIdLabel: UILabel!
    @IBOutlet weak var unprLabel: UILabel!
    @IBOutlet weak var qtyLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    var tradingManager = TradingManager()
    var stock: StockModel?
    var id: String = ""
    var name: String = ""
    var unpr: Int = 0
    var qty: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tradingManager.delegate = self
        self.navigationItem.title = "주문확인"
        
        stockNameLabel.text = name
        stockIdLabel.text = id
        unprLabel.text = m.deciFormatter(value: unpr)+"원"
        qtyLabel.text = m.deciFormatter(value: qty)+"주"
        let total: String = m.deciFormatter(value: unpr*qty)+"원"
        totalLabel.text = total
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("OrderConfirm"+#function)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    @IBAction func buttonPressed(_ sender: Any) {
        if let qty = qtyLabel.text, let unpr = unprLabel.text, let id = stock?.id {
            tradingManager.requestOrderCash(tr_int: 0, pdno: id, qty: qty, unpr: unpr)
        }
    }
}

//MARK: - TradingManagerDelegate
extension OrderConfirmViewController: TradingManagerDelegate {
    func fail(msg: String) {
        //todo
    }
    
    func success() {
        //todo
    }
}
