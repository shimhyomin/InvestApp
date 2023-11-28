//
//  TradingManager.swift
//  InvestApp
//
//  Created by shm on 2023/11/23.
//

import Foundation
import Alamofire

protocol TradingManagerDelegate {
    //실패했을 때 팝업창 띄우기
    //1. 장운영시간이 아님
    //2. 잔액 부족
    //3. 기타 등등
    func fail(msg: String)
    
    //성공했을 때 성공화면 띄우기
    //주문시간, 등등
    func success()
}

class TradingManager {
    var delegate: TradingManagerDelegate?
    
    func requestOrderCash(tr_int: Int, pdno: String, qty: String, unpr: String) {
        let api = APIService(delegate: self)
        
        api.requestOrderCash(pdno: pdno, qty: qty, unpr: unpr)
    }
}

//MARK: - APIDelegate
extension TradingManager: APIDelegate {
    func successAPIRequest(data: Any?) {
        if let d = data as? Data {
            //JSON Parshing
            let decoder = JSONDecoder()
            do {
                let decodedData = try decoder.decode(OrderCashData.self, from: d)
                
                if decodedData.rt_cd == "0" {
                    self.delegate?.success()
                } else {
                    self.delegate?.fail(msg: decodedData.msg1)
                }
                
            } catch {
                self.delegate?.fail(msg: error.localizedDescription)
                
            }
        }
        self.delegate?.success()
    }
    
    func failAPIRequest(error: String?) {
        if error != nil {
            self.delegate?.fail(msg: error!)
        }
    }
}
