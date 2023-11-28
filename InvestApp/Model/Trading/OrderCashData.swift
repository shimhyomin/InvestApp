//
//  OrderCashData.swift
//  InvestApp
//
//  Created by shm on 2023/11/18.
//

import Foundation
struct OrderCashData: Codable {
    let rt_cd: String //성공 실패 여부(0: 성공)
    let msg_cd: String //응답코드
    let msg1: String //응답메세지
    let output: OrderCashOutput?
}

struct OrderCashOutput: Codable {
    let krx_Fwdg_Ord_Orgno: String //한국거래소전송주문조직번호
    let odno: String //주문번호
    let ordTmd: String //주문시각

    enum CodingKeys: String, CodingKey {
        case krx_Fwdg_Ord_Orgno = "KRX_FWDG_ORD_ORGNO"
        case odno = "ODNO"
        case ordTmd = "ORD_TMD"
    }
    
}
