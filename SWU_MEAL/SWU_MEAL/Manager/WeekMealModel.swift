//
//  WeekMealModel.swift
//  SWU_MEAL
//
//  Created by 목정아 on 10/7/23.
//

import Foundation

struct WeekMealModel: Codable {
    let code: Int
    let message: String
    let data: DataClass?
    
    struct DataClass: Codable {
        let date: String
        let result: [Result]
        
        struct Result: Codable {
            let time: String
            let menuList: [MenuList]
            
            struct MenuList: Codable {
                let menuID: Int
                /// 예) 샬롬, 교직원
                let type: String
                /// 코너 - 한식, 일품, 스낵, 교직원
                let corner: String?
                /// 식단메뉴아이템
                let items: [String]

                enum CodingKeys: String, CodingKey {
                    case menuID = "menuId"
                    case type, corner, items
                }
            }
        }
    }
}
