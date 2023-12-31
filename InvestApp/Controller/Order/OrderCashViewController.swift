//
//  OrderCashViewController.swift
//  InvestApp
//
//  Created by shm on 2023/11/26.
//

import UIKit
import SwiftUI

class OrderCashViewController: UIViewController {
    
    @IBOutlet weak var stockNameLabel: UILabel!
    @IBOutlet weak var unprTextField: UITextField!
    @IBOutlet weak var qtyTextField: UITextField!
    @IBOutlet weak var msgLabel: UILabel!
    @IBOutlet weak var unprLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    var unpr: Int = 0
    var qty: Int = 0
    var mxpr: Int {
        if let n = Int(stock?.mxpr ?? "0") {
            return n
        }
        return 0
    }
    
    var stock: StockModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "주식주문(현금)"
        msgLabel.isHidden = true
        stockNameLabel.text = stock?.name
        unprLabel.text = "주문단가(미기입시 상한가 \(m.deciFormatter(value: mxpr))원으로 주문)"
        
        //MyKeyboard
        let loadNib = Bundle.main.loadNibNamed("MyKeyboardView", owner: nil, options: nil)
        let myKeyboardView = loadNib?.first as! MyKeyboardView
        myKeyboardView.delegate = self
        
        unprTextField.inputView = myKeyboardView
        qtyTextField.inputView = myKeyboardView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
        
        //처음부터 textField 활성화 > 키보드 활성화된 상태 유지
        unprTextField.becomeFirstResponder()
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    //MARK: - Navigation Prepare
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //todo
        if let desVC = segue.destination as? OrderConfirmViewController {
            desVC.name = stock?.name ?? ""
            desVC.id = stock?.id ?? ""
            desVC.unpr = unpr
            desVC.qty = qty
        }
    }
}
  
//MARK: - MyKeyboardDelegate
extension OrderCashViewController: MyKeyboardDelegate {
    func keyboardTapped(str: String) {
        if qtyTextField.isEditing {
            switch str {
            case "00": qty *= 100
            case "-1": qty /= 10
            default: if let n = Int(str) { qty = qty * 10 + n }
            }
            let qtyString = m.deciFormatter(value: qty)
            qtyTextField.text = qtyString
            
            if qty != 0 && unpr == 0 {
                unpr = mxpr
                unprTextField.text = m.deciFormatter(value: unpr)
            }
        } else {
            switch str {
            case "00": unpr *= 100
            case "-1": unpr /= 10
            default: if let n = Int(str) { unpr = unpr * 10 + n }
            }
            unprTextField.text = m.deciFormatter(value: unpr)
        }
        totalLabel.text = "총금액 : \(m.deciFormatter(value: unpr*qty))원"
    }
    
    func nextButtonTapped() {
        if qty == 0 {
            msgLabel.isHidden = false
        } else {
            if unpr == 0 {
                unpr = mxpr
                unprTextField.text = m.deciFormatter(value: unpr)
            }
            //매수가능 여부 API로 받아오기!!!
            msgLabel.isHidden = true
            performSegue(withIdentifier: "orderToConfirm", sender: nil)
        }
    }
}
