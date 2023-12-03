//
//  APIService.swift
//  InvestApp
//
//  Created by shm on 2023/11/18.
//

import Foundation
import Alamofire

//MARK: - APIDelegate
protocol APIDelegate {
    func successAPIRequest(data: Any?)
    func failAPIRequest(error: String?)
}

//MARK: - API
private let headers = HTTPHeaders(["content-type" : "application/json", "charset": "UTF-8",
                                   "appkey": K.appkey, "appsecret": K.secretkey])

enum API {
    case accessToken
    case stock
    case orderCash
    case account
    case profitNloss
    
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
        case .profitNloss:
            return "https://openapi.koreainvestment.com:9443/uapi/domestic-stock/v1/trading/inquire-balance-rlz-pl"
        }
    }
    
    var parameters: [String: String] {
        switch self {
        case .accessToken:
            return ["grant_type": "client_credentials", "appkey": K.appkey, "appsecret": K.secretkey]
        case .stock:
            return ["fid_cond_mrkt_div_code": "J"]
        case .orderCash:
            return [
                "CANO": K.account, //계좌번호 체계(8-2)의 앞 8자리
                "ACNT_PRDT_CD": "01", //계좌번호 체계(8-2)의 뒤 2자리
                "ORD_DVSN": "00", //주문구분 (00: 지정가, 01: 시장가)
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
        case .profitNloss:
            return [
                "CANO": K.account,
                "ACNT_PRDT_CD": "29", //계좌상품코드
                "ACCA_DVSN_CD": "00", //적립금구분코드
                "INQR_DVSN": "00", //조회구분(00 : 전체)
                "CTX_AREA_FK100": "", //연속조회검색조건100
                "CTX_AREA_NK100": "" //연속조회키100
            ]
        }
    }
}

//MARK: - APIService
//APIService 코드 다시 정리 필요!!!
struct APIService {
    var delegate: APIDelegate?
    
    func requestAccessToken() {
        //AccessToken의 기한은 하루
        //자주 발급받으면 발급 막힐 수 있음
        //처리 필요!!!
        let myHeaders = HTTPHeaders(["content-type" : "application/json", "charset": "UTF-8"])
        let request = AF.request(API.accessToken.url, method: .post, parameters: API.accessToken.parameters, encoding: JSONEncoding.default, headers: myHeaders)
        request.response { response in
            debugPrint(response)
            
            let decoder = JSONDecoder()
            do {
                let decodeData = try decoder.decode(AccessTokenData.self, from: response.data!)
                print("AccessToekn: \(decodeData.access_token)")
                K.access_token = decodeData.access_token
                K.empire_date = decodeData.access_token_token_expired
            }catch{
                print(error)
            }
        }
    }
    
    func requestStock(fid: String, name: String) {
        var myHeaders = headers
        myHeaders.add(name: "tr_id", value: "FHKST01010100")
        var myParameters = API.stock.parameters
        myParameters["fid_input_iscd"] = fid
        
        let request = AF.request(API.stock.url, method: .get, parameters: myParameters, encoding: URLEncoding.default, headers: myHeaders, interceptor: MyRequestInterceptor())
        request.response { response in
            debugPrint(response)
            
            let decoder = JSONDecoder()
            do {
                let decodeData = try decoder.decode(StockData.self, from: response.data!)
                let output = decodeData.output
                delegate?.successAPIRequest(data: StockModel(id: fid, name: name, mrkt_name: output.rprs_mrkt_kor_name, bstp_isnm: output.bstp_kor_isnm, prpr: output.stck_prpr, prdy_vrss: output.prdy_vrss, prdy_vrss_sign: output.prdy_vrss_sign ,prdy_ctrt: output.prdy_ctrt, acml_vol: output.acml_vol, prdy_vrss_vol_rate: output.prdy_vrss_vol_rate, oprc: output.stck_oprc, hgpr: output.stck_hgpr, lwpr: output.stck_lwpr, mxpr: output.stck_mxpr, llam: output.stck_llam, sdpr: output.stck_sdpr))
                
            }catch{
                print(error)
            }
        }
    }
    
    func requestOrderCash(pdno: String, qty: String, unpr: String) {
        //HTTPHeaders(["authorization": "Bearer \(K.access_token)", "appkey": K.appkey, "appsecret": K.secretkey, "tr_id": "TTTC0802U"]) //매수주문
        var myHeaders = headers
        myHeaders.add(name: "tr_id", value: "TTTC0802U")
        var myParameters = API.orderCash.parameters
        myParameters["PDNO"] = pdno
        myParameters["ORD_QTY"] = qty
        myParameters["ORD_UNPR"] = unpr
        /*
         [
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
         */
        
        let request = AF.request(API.orderCash.url, method: .post, parameters: myParameters, encoding: JSONEncoding.default, headers: myHeaders, interceptor: MyRequestInterceptor())
        request.response { response in
            debugPrint(response)
            
            if let status = response.response?.statusCode {
                switch status {
                case 200..<300: delegate?.successAPIRequest(data: response.data)
                default: delegate?.failAPIRequest(error: "\(status)")
                }
            }
        }
    }
    
    func requestAccount() {
        //HTTPHeaders(["content-type": "application/json", "charset": "utf-8", "authorization": "Bearer \(K.access_token)", "appkey": K.appkey, "appsecret": K.secretkey, "tr_id": "CTRP6548R", "custtype": "P"])
        var myHeaders = headers
        myHeaders.add(name: "tr_id", value: "CTRP6548R")
        myHeaders.add(name: "custtype", value: "P")
        let myParameters = API.account.parameters
        
        let request = AF.request(API.account.url, method: .post, parameters: myParameters, encoding: JSONEncoding.default, headers: myHeaders, interceptor: MyRequestInterceptor())
        
        request.response { response in
            //debugPrint(response)
            //JSON Parshing
            let decoder = JSONDecoder()
            do {
                let decodedData = try decoder.decode(OrderCashData.self, from: response.data!)
                //성공시
                delegate?.successAPIRequest(data: decodedData)
                
                //실패시
                //delegate?.failAPIRequest()
            } catch {
                print("error")
                
            }
        }
    }
    
    func requestProfitNLoss() {
        //HTTPHeaders(["content-type" : "application/json", "charset": "UTF-8", "authorization": "Bearer \(K.access_token)", "appkey": K.appkey, "appsecret": K.secretkey, "tr_id": "TTTC2208R", "custtype": "P"])
        var myHeaders = headers
        myHeaders.add(name: "tr_id", value: "TTTC2208R")
        myHeaders.add(name: "custtype", value: "P")
        let myParameters = API.profitNloss.parameters
        
        let request = AF.request(API.account.url, method: .post, parameters: myParameters, encoding: URLEncoding.default, headers: myHeaders, interceptor: MyRequestInterceptor())
        
        request.response { response in
            //debugPrint(response)
            //JSON Parshing
            let decoder = JSONDecoder()
            do {
                let decodedData = try decoder.decode(OrderCashData.self, from: response.data!)
                //성공시
                delegate?.successAPIRequest(data: decodedData)
                
                //실패시
                //delegate?.failAPIRequest()
            } catch {
                print("error")
                
            }
        }
    }
}

class MyRequestInterceptor: RequestInterceptor {
    var retryLimit = 0
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        //request 전 특정 작업을 하고 싶은 경우 사용
        
        //access token이 유효하지 않아도 reqeust 성공하기 때문에
        //adapt에서 access token 만료확인 및 재발급 진행해야함
        
        //access token의 만료날짜(String)와 현재날짜 비교
        //만료날짜 < 현재날짜
        //access token 업데이트
        //header에 새 access token 붙이기
        print(#function)
        let api = APIService()
        
        if K.access_token == "" {
            api.requestAccessToken()
        }
        else {
            //String > Date
            let empireString = K.empire_date
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            if let empireDate = dateFormatter.date(from: empireString) {
                //현재날짜와 만료날짜 비교
                if Date() > empireDate {
                    api.requestAccessToken()
                    //K.access_token&empire_date 갱신
                }
            }
        }
        //Header의 access_token
        var urlRequestAdd = urlRequest
        urlRequestAdd.headers.add(.authorization(bearerToken: K.access_token))

        completion(.success(urlRequestAdd))
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        print(#function)
        
        guard let statusCode = request.response?.statusCode else { return }
        switch statusCode {
        case 200...299:
            completion(.doNotRetry)
        case 500:
            print("error 500")
            completion(.retry)
        default:
            if request.retryCount < retryLimit {
                completion(.retry)
                return
            }
            completion(.doNotRetry)
        }
    }
}
