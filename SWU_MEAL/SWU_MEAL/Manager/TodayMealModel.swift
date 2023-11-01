//
//  TodayMealModel.swift
//  SWU_MEAL
//
//  Created by 목정아 on 2023/09/25.
//

import Foundation

struct TodayMealModel: Codable {
    let code: Int
    let message: String
    let data: TodayMealDataClass?
    
    struct TodayMealDataClass: Codable {
        let date, time: String
        let result: [TodayMealResult]
        
        struct TodayMealResult: Codable {
            let menuID: Int
            let type: String
            let corner: String?
            let items: [String]

            enum CodingKeys: String, CodingKey {
                case menuID = "menuId"
                case type, corner, items
            }
        }
    }
}
