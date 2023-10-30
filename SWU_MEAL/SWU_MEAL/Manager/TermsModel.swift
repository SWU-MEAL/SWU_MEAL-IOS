//
//  TermsModel.swift
//  SWU_MEAL
//
//  Created by 목정아 on 10/31/23.
//

import Foundation

struct TermsModel: Codable {
    let code: Int
    let message: String
    let data: TermsDataClass
    
    struct TermsDataClass: Codable {
        let terms, policy: String
    }
}
