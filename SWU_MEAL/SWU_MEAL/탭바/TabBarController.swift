//
//  TabBarController.swift
//  SWU_MEAL
//
//  Created by 목정아 on 2023/09/24.
//

import UIKit

final class TabBarController: UITabBarController {
    
    private lazy var todayViewController: UIViewController = {
        let viewcontroller = UINavigationController(rootViewController: TodayViewController())
        
        let tabBarItem = UITabBarItem(
            title: "오늘의 슈밥",
            image: UIImage(named: "Tab1_Gray")?
                .resize(to: CGSize(width: 48.0, height: 48.0)),
            selectedImage: UIImage(named: "Tab1_Gray")?
                .resize(to: CGSize(width: 48.0, height: 48.0))
        )
        
        viewcontroller.tabBarItem = tabBarItem
        
        return viewcontroller
    }()
    
    private lazy var weekViewController: UIViewController = {
        let viewcontroller = UINavigationController(rootViewController: WeekViewController())
        
        let tabBarItem = UITabBarItem(
            title: "이번주 슈밥",
            image: UIImage(named: "Tab2_Gray")?
                .resize(to: CGSize(width: 48.0, height: 48.0)),
            selectedImage: UIImage(named: "Tab2_Gray")?
                .resize(to: CGSize(width: 48.0, height: 48.0))
        )
        viewcontroller.tabBarItem = tabBarItem
        return viewcontroller
    }()
    
    private lazy var mypageViewController: UIViewController = {
        let viewcontroller = UINavigationController(rootViewController: MyPageViewController())
        
        let tabBarItem = UITabBarItem(
            title: "마이페이지",
            image: UIImage(named: "Tab3_Gray")?
                .resize(to: CGSize(width: 48.0, height: 48.0)),
            selectedImage: UIImage(named: "Tab3_Gray")?
                .resize(to: CGSize(width: 48.0, height: 48.0))
        )
        viewcontroller.tabBarItem = tabBarItem
        return viewcontroller
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.backgroundColor = .white
        tabBar.isTranslucent = false
        tabBar.tintColor = .tabBarActiveColor
        tabBar.unselectedItemTintColor = .tabBarInActiveColor
        UITabBarItem.appearance().titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 5)
        
        UITabBarItem.appearance().setTitleTextAttributes([
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12.0)
        ], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12.0)
        ], for: .selected)
        
        viewControllers = [
            todayViewController,
            weekViewController,
            mypageViewController
        ]
        
        self.setupStyle()
    }
}

private extension TabBarController {
  func setupStyle() {
      UITabBar.clearShadow()
      tabBar.layer.applyShadow(color: .gray, alpha: 0.3, x: 0, y: 0, blur: 3)
  }
}

// MARK: - CALayer

private extension CALayer {

  func applyShadow(
      color: UIColor = .black,
      alpha: Float = 0.5,
      x: CGFloat = 0,
      y: CGFloat = 2,
      blur: CGFloat = 4
  ) {
      shadowColor = color.cgColor
      shadowOpacity = alpha
      shadowOffset = CGSize(width: x, height: y)
      shadowRadius = blur / 2.0
  }
}

private extension UITabBar {

  static func clearShadow() {
      UITabBar.appearance().shadowImage = UIImage()
      UITabBar.appearance().backgroundImage = UIImage()
      UITabBar.appearance().backgroundColor = UIColor.white
  }
}
