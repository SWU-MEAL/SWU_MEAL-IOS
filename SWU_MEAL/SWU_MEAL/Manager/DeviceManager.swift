//
//  DeviceManager.swift
//  SWU_MEAL
//
//  Created by 목정아 on 11/1/23.
//

import UIKit

final class DeviceManager {
    
    /// 기기별 폰트 사이즈 조정하기 - 오늘의 슈밥
    func calculateTodayDynamicFontSize(fontSize: CGFloat) -> CGFloat {
        let bounds = UIScreen.main.bounds
        let height = bounds.size.height

        switch height {
        case 480.0: // iPhone 3, 4S -> 예측값
            return fontSize - 2.5
        case 568.0: // iPhone 5, SE -> 예측값
            return fontSize - 2.5
        case 667.0: // iPhone 6, 6s, 7, 8, iphone SE(3rd)
            return fontSize - 2.5
        case 736.0: // iPhone 6s+, 6+, 7+, 8+ -> 예측값
            return fontSize - 1.0
        case 812.0: // iPhone X, XS => 5.8 inch
            return fontSize - 1.5
        case 844.0: // iphone 14, iPhone 13 Pro, iPhone 13, iPhone 12 Pro, iPhone 12
            return fontSize
        case 852.0: // iPhone 15 Pro, iPhone 15, iPhone 14 Pro
            return fontSize + 0
        case 896.0: // iPhone 11 Pro Max, iPhone 11, iPhone XS Max, iPhone XR
            return fontSize + 1.0
        case 926.0: // iPhone 13 Pro Max, iPhone 12 Pro Max
            return fontSize + 1.0
        case 932.0: // iphone 15 max, iPhone 15 Plus, iPhone 14 Pro Max
            return fontSize + 1.0
        default:
            print("Not an iPhone")
            return fontSize
        }
    }
    
    /// 이번주 슈밥 폰트 사이즈
    func calculateWeekDynamicFontSize(fontSize: CGFloat) -> CGFloat {
        let bounds = UIScreen.main.bounds
        let height = bounds.size.height

        switch height {
        case 480.0: // iPhone 3, 4S -> 예측값
            return fontSize + 0.5
        case 568.0: // iPhone 5, SE -> 예측값
            return fontSize + 0.5
        case 667.0: // iPhone 6, 6s, 7, 8, iphone SE(3rd)
            return fontSize + 0.5
        case 736.0: // iPhone 6s+, 6+, 7+, 8+ -> 예측값
            return fontSize + 0.5
        case 812.0: // iPhone X, XS => 5.8 inch
            return fontSize
        case 844.0: // iphone 14, iPhone 13 Pro, iPhone 13, iPhone 12 Pro, iPhone 12
            return fontSize
        case 852.0: // iPhone 15 Pro, iPhone 15, iPhone 14 Pro
            return fontSize + 1.0
        case 896.0: // iPhone 11 Pro Max, iPhone 11, iPhone XS Max, iPhone XR
            return fontSize + 1.5
        case 926.0: // iPhone 13 Pro Max, iPhone 12 Pro Max
            return fontSize + 2.0
        case 932.0: // iphone 15 max, iPhone 15 Plus, iPhone 14 Pro Max
            return fontSize + 2.0
        default:
            print("Not an iPhone")
            return fontSize
        }
    }
    
    /// 오늘의 슈밥 - 중식 TableView Cell 크기 조절
    func calculateTodayLunchTableCellSize(cellSize: CGFloat) -> CGFloat {
        let bounds = UIScreen.main.bounds
        let height = bounds.size.height

        switch height {
        case 480.0: // iPhone 3, 4S -> 예측값
            return cellSize - 9.0
        case 568.0: // iPhone 5, SE -> 예측값
            return cellSize - 8.0
        case 667.0: // iPhone 6, 6s, 7, 8, iphone SE(3rd)
            return cellSize - 8.0
        case 736.0: // iPhone 6s+, 6+, 7+, 8+ -> 예측값
            return cellSize - 1.0
        case 812.0: // iPhone X, XS => 5.8 inch
            return cellSize
        case 844.0: // iphone 14, iPhone 13 Pro, iPhone 13, iPhone 12 Pro, iPhone 12
            return cellSize
        case 852.0: // iPhone 15 Pro, iPhone 15, iPhone 14 Pro
            return cellSize
        case 896.0: // iPhone 11 Pro Max, iPhone 11, iPhone XS Max, iPhone XR
            return cellSize
        case 926.0: // iPhone 13 Pro Max, iPhone 12 Pro Max
            return cellSize
        case 932.0: // iphone 15 max, iPhone 15 Plus, iPhone 14 Pro Max
            return cellSize
        default:
            print("Not an iPhone")
            return cellSize
        }
    }
    
}
