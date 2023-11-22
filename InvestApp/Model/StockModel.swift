//
//  StockBrain.swift
//  InvestApp
//
//  Created by shm on 2023/11/18.
//

import Foundation

struct StockModel {
    let id: String //종목코드
    let name: String //종목명
    let mrkt_name: String //대표 시장 한글명
    let bstp_isnm: String //업종 한글 종목명
    let prpr: String //주식 현재가
    let prdy_vrss: String //전일 대비
    let prdy_vrss_sign: String //전일 대비 부호
    //전일 대비 & 전일 대비 부호
    //    1 : 상한
    //    2 : 상승
    //    3 : 보합
    //    4 : 하한
    //    5 : 하락
    let prdy_ctrt: String //전일 대비율
    let acml_vol: String //누적 거래량
    let prdy_vrss_vol_rate: String //전일 대비 거래량 비율
    let oprc: String //주식 시가
    let hgpr: String //주식 최고가
    let lwpr: String //주식 최저가
    let mxpr: String //주식 상한가
    let llam: String //주식 하한가
    let sdpr: String //주식 기준가
    
    var prdy_vrss_Int: Int {
        switch prdy_vrss_sign {
        case "1": return 0
        default: return 12
        }
    }
}
