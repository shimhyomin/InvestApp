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

struct TradingManager {
    var ms: String? = ""
    var delegate: TradingManagerDelegate?
    let url = "https://openapi.koreainvestment.com:9443/uapi/domestic-stock/v1/trading/order-cash"
    var headers = HTTPHeaders(["authorization": "Bearer \(K.access_token)",
                               "appkey": K.appkey,
                               "appsecret": K.secretkey,])
    /*
     tr_id : //매수(TTTC0802U), 매도(TTTC0801U)
     */
    
    var parameters = ["CANO": K.account, "ACNT_PRDT_CD": "01"]
        /*
         "PDNO": "009150", //종목코드
        "ORD_DVSN": "00", //주문구분(00:지정가, 01:시장가, 02:조건부지정가, ...)
        "ORD_QTY": "3", //주문수량
        "ORD_UNPR": "150000" //주문단가
         */
    
    mutating func requestOrderCash(tr_int: Int, pdno: String, qty: String, unpr: String) {
        parameters["PDNO"] = pdno
        parameters["ORD_QTY"] = qty
        parameters["ORD_UNPR"] = unpr
        parameters["ORD_DVSN"] = "00"
        
        var tr_id: String {
            switch tr_int {
            case 0: return "TTTC0802U"
            case 1: return "TTTC0801U"
            default: return "error"
            }
        }
        headers.add(name: "tr_id", value: tr_id)
        
        let request = AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
        
        request.response { response in
            debugPrint(response)
            
            //JSON Parsing
            let decoder = JSONDecoder()
            do {
                let decodeData = try decoder.decode(OrderCashData.self, from: response.data!)
                //self캡쳐 어떻게 하지???
                
            } catch{
                print(error)
            }
        }
    }
}
