//
//  StockBrain.swift
//  InvestApp
//
//  Created by shm on 2023/11/18.
//

import Foundation
import Alamofire

//MARK: - StockManagerDelegate
protocol StockManagerDelegate {
    func update(_ stockManager: StockManager, stockModels: [StockModel])
}

//MARK: - StockManager
struct StockManager {
    let stocks = ["060310":"3S", "095570":"AJ네트웍스", "006840":"AK홀딩스", "054620":"APS"]
    var delegate: StockManagerDelegate?
    

    
    //전체 stock
    func getStock() {
        var list: [StockModel] = []
        for s in stocks {
            let fid = s.key
            var myParameters = API.stock.parameters
            myParameters["fid_input_iscd"] = fid
            var myHeaders = API.stock.headers
            myHeaders.add(name: "authorization", value: "Bearer \(K.access_token)")
            
            let request = AF.request(API.stock.url, method: .get, parameters: myParameters, encoding: URLEncoding.default, headers: myHeaders)
            request.response { response in
                //debugPrint(response)
                //JSON Parshing
                let decoder = JSONDecoder()
                do {
                    let data = try decoder.decode(StockData.self, from: response.data!)
                    let d = data.output
                    list.append(StockModel(id: s.key, name: s.value, mrkt_name: d.rprs_mrkt_kor_name, bstp_isnm: d.bstp_kor_isnm, prpr: d.stck_prpr, prdy_vrss: d.prdy_vrss, prdy_vrss_sign: d.prdy_vrss_sign ,prdy_ctrt: d.prdy_ctrt, acml_vol: d.acml_vol, prdy_vrss_vol_rate: d.prdy_vrss_vol_rate, oprc: d.stck_oprc, hgpr: d.stck_hgpr, lwpr: d.stck_lwpr, mxpr: d.stck_mxpr, llam: d.stck_llam, sdpr: d.stck_sdpr))
                } catch {
                    print(error)
                }
                delegate?.update(self, stockModels: list)
            }
        }
    }
}

