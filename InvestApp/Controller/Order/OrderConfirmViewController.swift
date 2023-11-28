//
//  OrderConfirmViewController.swift
//  InvestApp
//
//  Created by shm on 2023/11/26.
//

import UIKit

class OrderConfirmViewController: UIViewController {
    
    @IBOutlet weak var stockNameLabel: UILabel!
    @IBOutlet weak var stockIdLabel: UILabel!
    @IBOutlet weak var unprLabel: UILabel!
    @IBOutlet weak var qtyLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    var tradingManager = TradingManager()
    //var stock: StockModel?
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
        self.tabBarController?.tabBar.isHidden = true
    }
    
    @IBAction func buttonPressed(_ sender: Any) {
        //tr_int가 0이면 매수, 1이면 매도
        tradingManager.requestOrderCash(tr_int: 0, pdno: id, qty: String(qty), unpr: String(unpr))
    }
}

//MARK: - TradingManagerDelegate
extension OrderConfirmViewController: TradingManagerDelegate {
    func fail(msg: String) {
        //실패 팝업창 띄우기
        showPopup(with: msg)
    }
    
    func success() {
        //OrderComplete View 띄우기
        performSegue(withIdentifier: "comfirmToComplete", sender: nil)
    }
}

//MARK: - Popup
extension OrderConfirmViewController {
    func showPopup(with msg: String) {
        let storyBoard = UIStoryboard.init(name: "PopupViewController", bundle: nil)
        let popupVC = storyBoard.instantiateViewController(withIdentifier: "popupVC")
        //popup view의 투명도
        popupVC.modalPresentationStyle = .overCurrentContext
        if let vc = popupVC as? PopupViewController {
            vc.msg = msg
        }
        
        self.present(popupVC, animated: false, completion: nil)
    }
}
