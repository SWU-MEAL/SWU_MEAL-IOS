//
//  Manager.swift
//  SWU_MEAL
//
//  Created by 목정아 on 10/7/23.
//

import Alamofire
import Foundation

class APIManager {
    private let baseURL = "http://54.180.103.35:10000"
    
    func getMenuListForDate(
        date: String,
        time: String,
        weekMealModel: WeekMealModel
    ) -> [WeekMealModel.DataClass.Result.MenuList]? {
        if let dataClass = weekMealModel.data,
           let result = dataClass.result.first(where: { $0.time == time }) {
            return result.menuList
        }
        return nil
    }

    /// 이번주 슈밥 데이터 불러오기
    func weekdayMealGetData(date: String, time: String, completion: @escaping (Result<WeekMealModel, Error>) -> Void) {
        
        let url = "\(baseURL)/v1/menu?date=\(date)"
        print("요청 URL = \(url)")

        AF.request(url, method: .get).responseDecodable(of: WeekMealModel.self) { response in
            switch response.result {
            case .success(let weekMealModel):
                completion(.success(weekMealModel))
            case .failure(let error):
                print("요청 실패: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
    }
}
