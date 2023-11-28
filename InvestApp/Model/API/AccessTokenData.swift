//
//  AccessTokenModel.swift
//  InvestApp
//
//  Created by shm on 2023/11/18.
//

import Foundation

struct AccessTokenData: Codable {
    let access_token: String
    let access_token_token_expired: String
    let token_type: String
    let expires_in: Int
}
