//
//  StockModel.swift
//  InvestApp
//
//  Created by shm on 2023/11/18.
//

import Foundation

struct StockData: Codable {
    let output: StockOutput
    let rt_cd: String
    let msg_cd: String
    let msg1: String
}

struct StockOutput: Codable {
    let rprs_mrkt_kor_name: String //대표 시장 한글명
    let bstp_kor_isnm: String //업종 한글 종목명
    let stck_prpr: String //주식 현재가
    let prdy_vrss: String //전일 대비
    let prdy_vrss_sign: String //전일 대비 부호
    let prdy_ctrt: String //전일 대비율
    let acml_tr_pbmn: String //누적 거래 대금
    let acml_vol: String //누적 거래량
    let prdy_vrss_vol_rate: String //전일 대비 거래량 비율
    let stck_oprc: String //주식 시가
    let stck_hgpr: String //주식 최고가
    let stck_lwpr: String //주식 최저가
    let stck_mxpr: String //주식 상한가
    let stck_llam: String //주식 하한가
    let stck_sdpr: String //주식 기준가
}
