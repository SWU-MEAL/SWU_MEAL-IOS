//
//  Manager.swift
//  SWU_MEAL
//
//  Created by 목정아 on 10/7/23.
//

import Alamofire
import Foundation

class APIManager {
    
    private let baseURL = "http://15.164.192.106:10000"
    
    /// 이번주 슈밥 데이터 불러오기
    func weekdayMealGetData(
        date: String,
        time: String,
        completion: @escaping (Result<WeekMealModel, Error>
        ) -> Void) {
        
        let url = "\(baseURL)/v1/menu?date=\(date)"
        
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
    
    /// 이번주 슈밥 - 점심 메뉴 데이터 불러오기
    func getLunchMenuListForDate(
        date: String,
        time: String,
        type: String,
        corner: String?,
        weekMealModel: WeekMealModel
    ) -> [WeekMealModel.DataClass.Result.MenuList]? {
        if let dataClass = weekMealModel.data,
           let result = dataClass.result.first(where: { $0.time == time }) {
            let filteredMenus = result.menuList.filter { menu in
                if menu.type == type {
                    if let menuCorner = menu.corner {
                        return menuCorner == corner
                    } else {
                        return true
                    }
                }
                return false
            }
            return filteredMenus
        }
        return nil
    }
    
    ///  이번주 슈밥 - 날짜 계산
    func calculateDate(forDayOfWeek dayOfWeek: Int) -> String {
        let calendar = Calendar.current
        var date = Date()

        // 일요일(1) ~ 토요일(7)으로 변경하되, 월요일을 1로 시작하도록 조정
        var currentWeekday = calendar.component(.weekday, from: date) - 1
        if currentWeekday == 0 {
            currentWeekday = 7
        }
        
        // 만약 오늘이 주말인 경우, 다음주 월요일로 이동하자.
        if currentWeekday >= 6 {
            date = calendar.date(byAdding: .day, value: 8 - currentWeekday, to: date)!
        }

        let daysUntilSelectedDay = dayOfWeek - currentWeekday
        
        let daysToAdd = daysUntilSelectedDay - 1
        date = calendar.date(byAdding: .day, value: daysToAdd, to: date)!
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let selectedDate = dateFormatter.string(from: date)
        
        return selectedDate
    }

}
