//
//  OrderCashModel.swift
//  InvestApp
//
//  Created by shm on 2023/11/27.
//

import Foundation

struct OrderCashModel {
    let rt_cd: String //성공 실패 여부(0: 성공)
    let msg: String //응답메세지
    let krxFwdgOrdOrgno: String //한국거래소전송주문조직번호
    let odno: String //주문번호
    let ordTmd: String //주문시각
}
