//
//  AccountData.swift
//  InvestApp
//
//  Created by shm on 2023/11/19.
//

import Foundation

struct AccountData: Codable {
    let output1: [Output1]
    /*
     [아래 순서대로 출력 : 19항목]
     1: 주식
     2: 펀드/MMW
     3: 채권
     4: ELS/DLS
     5: WRAP
     6: 신탁/퇴직연금/외화신탁
     7: RP/발행어음
     8: 해외주식
     9: 해외채권
     10: 금현물
     11: CD/CP
     12: 단기사채
     13: 타사상품
     14: 외화단기사채
     15: 외화 ELS/DLS
     16: 외화
     17: 예수금+CMA
     18: 청약자예수금
     19: <합계>
     */
    let output2: Output2
    let rt_cd: String //성공 실패 여부
    let msg_cd, msg1: String
}

// MARK: - Output1
struct Output1: Codable {
    let pchsAmt: String //매입금액
    let evluAmt: String //평가금액
    let evluPflsAmt: String //평가손익금액
    let crdtLndAmt: String //신용대출금액
    let realNassAmt: String //실제순자산금액
    let wholWeitRt: String //전체비중율

    enum CodingKeys: String, CodingKey {
        case pchsAmt = "pchs_amt"
        case evluAmt = "evlu_amt"
        case evluPflsAmt = "evlu_pfls_amt"
        case crdtLndAmt = "crdt_lnd_amt"
        case realNassAmt = "real_nass_amt"
        case wholWeitRt = "whol_weit_rt"
    }
}

// MARK: - Output2
struct Output2: Codable {
    let pchsAmtSmtl, nassTotAmt, loanAmtSmtl, evluPflsAmtSmtl: String
    let evluAmtSmtl, totAsstAmt, totLndaTotUlstLnda, cmaAutoLoanAmt: String
    let totMglnAmt, stlnEvluAmt, crdtFncgAmt, oclAPLLoanAmt: String
    let pldgStupAmt, frcrEvluTota, totDnclAmt, cmaEvluAmt: String
    let dnclAmt, totSbstAmt, thdtRcvbAmt, ovrsStckEvluAmt1: String
    let ovrsBondEvluAmt, mmfCmaMggeLoanAmt, sbscDnclAmt, pbstSbscFndsLoanUseAmt: String
    let etprCrdtGrntLoanAmt: String

    enum CodingKeys: String, CodingKey {
        case pchsAmtSmtl = "pchs_amt_smtl"
        case nassTotAmt = "nass_tot_amt"
        case loanAmtSmtl = "loan_amt_smtl"
        case evluPflsAmtSmtl = "evlu_pfls_amt_smtl"
        case evluAmtSmtl = "evlu_amt_smtl"
        case totAsstAmt = "tot_asst_amt"
        case totLndaTotUlstLnda = "tot_lnda_tot_ulst_lnda"
        case cmaAutoLoanAmt = "cma_auto_loan_amt"
        case totMglnAmt = "tot_mgln_amt"
        case stlnEvluAmt = "stln_evlu_amt"
        case crdtFncgAmt = "crdt_fncg_amt"
        case oclAPLLoanAmt = "ocl_apl_loan_amt"
        case pldgStupAmt = "pldg_stup_amt"
        case frcrEvluTota = "frcr_evlu_tota"
        case totDnclAmt = "tot_dncl_amt"
        case cmaEvluAmt = "cma_evlu_amt"
        case dnclAmt = "dncl_amt"
        case totSbstAmt = "tot_sbst_amt"
        case thdtRcvbAmt = "thdt_rcvb_amt"
        case ovrsStckEvluAmt1 = "ovrs_stck_evlu_amt1"
        case ovrsBondEvluAmt = "ovrs_bond_evlu_amt"
        case mmfCmaMggeLoanAmt = "mmf_cma_mgge_loan_amt"
        case sbscDnclAmt = "sbsc_dncl_amt"
        case pbstSbscFndsLoanUseAmt = "pbst_sbsc_fnds_loan_use_amt"
        case etprCrdtGrntLoanAmt = "etpr_crdt_grnt_loan_amt"
    }
}
