//
//  Manager.swift
//  SWU_MEAL
//
//  Created by 목정아 on 10/7/23.
//

import Alamofire
import Foundation

class APIManager {
    
    // MARK: - BaseURL
    
    private let baseURL = "http://15.164.192.106:10000"
    
    // MARK: - 오늘의 슈밥 데이터 API
    
    ///  오늘의 슈밥 데이터 불러오기
    func todayMealGetData(
        date: String,
        time: String,
        completion: @escaping (Result<TodayMealModel, Error>
        ) -> Void) {
        
        let url = "\(baseURL)/v1/menu/today?time=\(time)"
        
        AF.request(url, method: .get).responseDecodable(of: TodayMealModel.self) { response in
            switch response.result {
            case .success(let todayMealModel):
                completion(.success(todayMealModel))
            case .failure(let error):
                print("요청 실패: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
    }
    
    /// 오늘의 슈밥 -  메뉴 데이터
    func todayGetMenuListForDate(
        date: String,
        time: String,
        todayMealModel: TodayMealModel
    ) -> [TodayMealModel.TodayMealDataClass.TodayMealResult]? {
        if (todayMealModel.data?.result.first) != nil {
            return todayMealModel.data?.result
        }
        return nil
    }
    
    /// 오늘의 슈밥 - 점심 메뉴 데이터 불러오기 함수
    func todayGetLunchMenuListForDate(
        date: String,
        time: String,
        type: String,
        corner: String?,
        todayMealModel: TodayMealModel
    ) -> [String]? {
        if let result = todayMealModel.data?.result.first {
            let filteredMenus = result.items.filter { item in
                if result.type == type {
                    if let resultCorner = result.corner {
                        if let corner = corner {
                            return resultCorner == corner
                        }
                        return false
                    }
                    return true
                }
                return false
            }
            return filteredMenus
        }
        return nil
    }
    
    
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
    
    /// 이번주 슈밥 - 메뉴 데이터 불러오기
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
    
    /// 이번주 슈밥 - 점심 메뉴 데이터 불러오기 함수
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
        
        // 현재 시간대의 날짜 및 시간 가져오기
        let components = calendar.dateComponents(in: calendar.timeZone, from: date)
        date = calendar.date(from: components)!
        
        print(date.description)

        // 일요일(1) ~ 토요일(7)으로 변경하되, 월요일을 1로 시작하도록 조정
        var currentWeekday = calendar.component(.weekday, from: date)
        if currentWeekday == 1 {
            currentWeekday = 7
        } else {
            currentWeekday -= 1
        }

        // 만약 오늘이 주말인 경우, 다음주 월요일로 이동
        if currentWeekday >= 6 {
            date = calendar.date(byAdding: .day, value: currentWeekday + 1, to: date)!
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
    
    /// 오늘 날짜를 원하는 포맷으로 변경해서 출력하기
    func calculateTodayDate() -> String {
        let date = Date()
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let selectedDate = dateFormatter.string(from: date)
        
        return selectedDate
    }
    
    // MARK: - 이용약관 API
    
    func getTermsData(
        completion: @escaping (Result<TermsModel, Error>
        ) -> Void) {
        
        let requestURLString = "\(baseURL)/v1/mypage/terms"
        
        AF.request(requestURLString, method: .get).responseDecodable(of: TermsModel.self) { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                print("요청 실패: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
    }
    
}
