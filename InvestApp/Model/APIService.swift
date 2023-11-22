//
//  APIService.swift
//  InvestApp
//
//  Created by shm on 2023/11/18.
//

import Foundation
import Alamofire

enum API {
    case accessToken
    case stock
    case orderCash
    case account
    
    var url: String {
        switch self {
        case .accessToken:
            return "https://openapi.koreainvestment.com:9443//oauth2/tokenP"
        case .stock:
            return "https://openapi.koreainvestment.com:9443/uapi/domestic-stock/v1/quotations/inquire-price"
        case .orderCash:
            return "https://openapi.koreainvestment.com:9443/uapi/domestic-stock/v1/trading/order-cash"
        case .account:
            return "https://openapi.koreainvestment.com:9443/uapi/domestic-stock/v1/trading/inquire-account-balance"
        }
    }
    
    var headers: HTTPHeaders {
        switch self {
        case .accessToken:
            return HTTPHeaders(["content-type" : "application/json", "charset": "UTF-8"])
        case .stock:
            return HTTPHeaders(["content-type": "application/json", "charset": "utf-8", "authorization": "a", "appkey": K.appkey, "appsecret": K.secretkey, "tr_id": "FHKST01010100"])
        case .orderCash:
            return HTTPHeaders(["authorization": "Bearer \(K.access_token)", "appkey": K.appkey, "appsecret": K.secretkey, "tr_id": "TTTC0802U"]) //매수주문
        case .account:
            return HTTPHeaders(["content-type": "application/json", "charset": "utf-8", "authorization": "Bearer \(K.access_token)", "appkey": K.appkey, "appsecret": K.secretkey, "tr_id": "CTRP6548R", "custtype": "P"])
        }
    }
    
    var parameters: [String: String] {
        switch self {
        case .accessToken:
            return ["grant_type": "client_credentials", "appkey": K.appkey, "appsecret": K.secretkey]
        case .stock:
            return ["fid_cond_mrkt_div_code": "J",
                    "fid_input_iscd": "key"]
        case .orderCash:
            return [
                "CANO": K.account, //계좌번호 체계(8-2)의 앞 8자리
                "ACNT_PRDT_CD": "01", //계좌번호 체계(8-2)의 뒤 2자리
                "PDNO": "009150", //종목코드(6자리))
                "ORD_DVSN": "00", //주문구분 (00: 지정가, 01: 시장가)
                "ORD_QTY": "3", //주문수량
                "ORD_UNPR": "100" //주문단가
                /* * 주문단가가 없는주문은 상한가로 주문금액을 선정하고 이후 체결이되면 체결금액로 정산
                 * 지정가 이외의 장전 시간외, 장후 시간외, 시장가 등 모든 주문구분의 경우 1주당 가격을 공란으로 비우지 않음 "0"으로 입력 권고
                 1주당 가격 */
            ]
        case .account:
            return [
                "CANO": K.account,
                "ACNT_PRDT_CD": "01",
                "INQR_DVSN_1": " ",
                "BSPR_BF_DT_APLY_YN": " "]
        }
    }
}

//APIService 코드 다시 정리 필요!!!
enum APIService {
    static func requestAccessToken() {
        //AccessToken의 기한은 하루
        //자주 발급받으면 발급 막힐 수 있음
        //처리 필요!!!
        let request = AF.request(API.accessToken.url, method: .post, parameters: API.accessToken.parameters, encoding: JSONEncoding.default, headers: API.accessToken.headers)
        request.response { response in
            debugPrint(response)
            
            let decoder = JSONDecoder()
            do {
                let decodeData = try decoder.decode(AccessTokenData.self, from: response.data!)
                print("AccessToekn: \(decodeData.access_token)")
            }catch{
                print(error)
            }
        }
    }
    
    static func requestStock(with fid: String) {
        //return 값을 뭘로 할지 어떻게 return 할지 다시 정리 필요!!!
        var myParameters = API.stock.parameters
        myParameters["fid_input_iscd"] = fid
        let request = AF.request(API.stock.url, method: .get, parameters: myParameters, encoding: URLEncoding.default, headers: API.stock.headers)
        request.response { response in
            debugPrint(response)
            //JSON Parshing
//            let decoder = JSONDecoder()
//            do {
//                let decodedData = try decoder.decode(StockData.self, from: response.data!)
//            } catch {
//                print("error")
//                
//            }
        }
    }
    
    static func requestOrderCash() {
        let request = AF.request(API.orderCash.url, method: .post, parameters: API.orderCash.parameters, encoding: JSONEncoding.default, headers: API.orderCash.headers)
        request.response { response in
            debugPrint(response)
            let decoder = JSONDecoder()
            do {
                
                let decodeData = try decoder.decode(OrderCashData.self, from: response.data!)
                print(decodeData.msg1)
            }catch{
                print(error)
            }
        }
    }
    
    static func requestAccount() {
        let request = AF.request(API.account.url, method: .get, parameters: API.account.parameters, encoding: URLEncoding.default, headers: API.account.headers)
        request.response { response in
            debugPrint(response)
            
        }
    }
}
