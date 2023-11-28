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
class StockManager {
    let stocks = ["023760":"한국캐피탈", "095570":"AJ네트웍스", "006840":"AK홀딩스", "054620":"APS", "078860": "아이오케이", "089230": "The E&M", "032800": "판타지오", "005930": "삼성전자", "051900": "LG생활건강", "090430": "아모레퍼시픽", "003550": "LG", "035420": "NAVER", "035720": "카카오", "000660": "SK하이닉스", "005380": "현대차", "000270": "기아", "032830": "삼성생명", "088350": "한화생명", "010060": "OCI홀딩스", "011930": "신성이엔지"]
    var list: [StockModel] = []
    var delegate: StockManagerDelegate?
    
    //전체 stock
    func getStocks() {
        let api = APIService(delegate: self)
        
        for s in stocks {
            api.requestStock(fid: s.key, name: s.value)
        }
    }
}

//MARK: - APIDelegate
extension StockManager: APIDelegate {
    func successAPIRequest(data: Any?) {
        if let s = data as? StockModel {
            list.append(s)
            delegate?.update(self, stockModels: list)
        }
    }
    
    func failAPIRequest(error: String?) {
        //todo
    }
}
