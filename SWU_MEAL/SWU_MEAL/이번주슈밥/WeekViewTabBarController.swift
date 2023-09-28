//
//  WeekViewTabBarController.swift
//  SWU_MEAL
//
//  Created by 목정아 on 2023/09/28.
//

import UIKit
import Tabman
import Pageboy

enum WeekTabBarTopic: String {
    case mon = "월"
    case thu = "화"
    case wed = "수"
    case thur = "목"
    case fri = "금"
    
    static var allCases: [WeekTabBarTopic] {
        return [
            .mon,
            .thu,
            .wed,
            .thur,
            .fri
        ]
    }
}

class WeekViewTabBarController: TabmanViewController {
    
    // MARK: - Properties
    
    private let numberOfCases: Int = 5
    
    
    
}
