//
//  TodayTabBarController.swift
//  SWU_MEAL
//
//  Created by 목정아 on 2023/09/24.
//

import UIKit
import Tabman
import Pageboy

enum TodayTabBarTopic: String {
    case breakfast = "조식"
    case lunch = "중식"
    case dinner = "석식"
    
    static var allCases: [TodayTabBarTopic] {
        return [
            .breakfast,
            .lunch,
            .dinner,
        ]
    }
}

class TodayTabBarController: TabmanViewController {
    
    // MARK: - Properties
    
    private let numberOfCases: Int = 3
    
    private var viewControllers = [
        TodayBreakfastViewController(),
        TodayLunchViewController(),
        TodayDinnerViewController(),
    ]
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
        self.setupStyle()
    }
    
}

private extension TodayTabBarController {
    
    func setupStyle() {
        let bar = TMBar.ButtonBar()
        bar.backgroundColor = .white
        bar.layout.transitionStyle = .snap
        bar.layout.contentMode = .fit
        bar.layout.contentInset = UIEdgeInsets(top: 0.0, left: 24.0, bottom: 0.0, right: 24.0)
        let systemBar = bar.systemBar()
        systemBar.backgroundStyle = .blur(style: .light)
        
        bar.buttons.customize { (button) in
            button.tintColor = UIColor(hex: "#606060")
            button.selectedTintColor = UIColor(hex: "#191919")
            button.font = .systemFont(ofSize: 16.0, weight: .regular)
            button.selectedFont = .systemFont(ofSize: 18.0, weight: .bold)
        }
        
        bar.indicator.overscrollBehavior = .bounce
        bar.indicator.weight = .medium
        bar.indicator.tintColor = .mainOrangeColor
        
        addBar(bar, dataSource: self, at: .top)
        
    }
    
}

// MARK: - PageboyViewControllerDataSource, TMBarDataSource

extension TodayTabBarController: PageboyViewControllerDataSource, TMBarDataSource  {
    
    func numberOfViewControllers(in pageboyViewController: Pageboy.PageboyViewController) -> Int {
        return numberOfCases
    }
    
    func viewController(for pageboyViewController: Pageboy.PageboyViewController, at index: Pageboy.PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }
    
    func defaultPage(for pageboyViewController: Pageboy.PageboyViewController) -> Pageboy.PageboyViewController.Page? {
        return nil
    }
    
    func barItem(for bar: Tabman.TMBar, at index: Int) -> Tabman.TMBarItemable {
        if let tabBarTopic = TodayTabBarTopic(rawValue: TodayTabBarTopic.allCases[index].rawValue) {
            return TMBarItem(title: tabBarTopic.rawValue)
        } else {
            return TMBarItem(title: "Unknown")
        }
    }
}
