//
//  AccountData.swift
//  InvestApp
//
//  Created by shm on 2023/11/19.
//

import Foundation

struct AccountData: Codable {
    let output1: [Output1]
    let output2: Output2
    let rtCD, msgCD, msg1: String

    enum CodingKeys: String, CodingKey {
        case output1, output2
        case rtCD = "rt_cd"
        case msgCD = "msg_cd"
        case msg1
    }
}

// MARK: - Output1
struct Output1: Codable {
    let pchsAmt, evluAmt, evluPflsAmt, crdtLndAmt: String
    let realNassAmt, wholWeitRt: String

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
