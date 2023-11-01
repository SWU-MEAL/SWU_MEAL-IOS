//
//  WeekViewController.swift
//  SWU_MEAL
//
//  Created by 목정아 on 2023/09/24.
//

import UIKit

final class WeekViewController: UIViewController {
    
    // MARK: - Views
    
    private let deviceManager = DeviceManager()
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .mainGrayColor
        // refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        
        return refreshControl
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = """
이번주
슈니의 밥상 🍽
"""
        label.numberOfLines = 0
        label.textColor = .black
        label.textAlignment = .left
        label.font = .systemFont(
            ofSize: deviceManager.calculateTodayDynamicFontSize(fontSize: 28.0)
            , weight: .semibold
        )
        
        return label
    }()
    
    private lazy var highLightView: UIView = {
        let view = UIView()
        let height: CGFloat = 6.0
        view.backgroundColor = UIColor(hex: "#FF5A00").withAlphaComponent(0.2)
        view.layer.cornerRadius = height / 2
        view.widthAnchor.constraint(equalToConstant: 75.0).isActive = true
        view.heightAnchor.constraint(equalToConstant: height).isActive = true
        
        return view
    }()
    
    private let scheduleView = WeekdayView()
    private let weekdayTabBarController = WeekViewTabBarController()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundColor
        
        self.scheduleView.setupDelegate(self)
        self.scrollView.bounces = false
        self.setupLayout()
    }
}

// MARK: - Extension

private extension WeekViewController {
    
    func setupLayout() {
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width),
            contentView.heightAnchor.constraint(
                equalToConstant: calculateDynamicHeight()
            )
        ])

        [
            titleLabel,
            highLightView,
            weekdayTabBarController.view
        ].forEach { contentView.addSubview($0) }
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24.0)
        ])
        
        highLightView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            highLightView.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 27.0),
            highLightView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant: -2.0)
        ])
        
        weekdayTabBarController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            weekdayTabBarController.view.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 37.0),
            weekdayTabBarController.view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            weekdayTabBarController.view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            weekdayTabBarController.view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}

// MARK: - Func

private extension WeekViewController {
    func calculateDynamicHeight() -> CGFloat {
        let bounds = UIScreen.main.bounds
        let height = bounds.size.height

        switch height {
        case 480.0: // iPhone 3, 4S -> 예측값
            return UIScreen.main.bounds.size.height + 650.0
        case 568.0: // iPhone 5, SE -> 예측값
            return UIScreen.main.bounds.size.height + 620.0
        case 667.0: // iPhone 6, 6s, 7, 8
            return UIScreen.main.bounds.size.height + 600.0
        case 736.0: // iPhone 6s+, 6+, 7+, 8+ -> 예측값
            return UIScreen.main.bounds.size.height + 500.0
        case 812.0: // iPhone X, XS => 5.8 inch
            return UIScreen.main.bounds.size.height + 470.0
        case 844.0: // iphone 14, iPhone 13 Pro, iPhone 13, iPhone 12 Pro, iPhone 12
            return UIScreen.main.bounds.size.height + 440.0
        case 852.0: // iPhone 15 Pro, iPhone 15, iPhone 14 Pro
            return UIScreen.main.bounds.size.height + 400.0
        case 896.0: // iPhone 11 Pro Max, iPhone 11, iPhone XS Max, iPhone XR
            return UIScreen.main.bounds.size.height + 380.0
        case 926.0: // iPhone 13 Pro Max, iPhone 12 Pro Max
            return UIScreen.main.bounds.size.height + 360.0
        case 932.0: // iphone 15 max, iPhone 15 Plus, iPhone 14 Pro Max
            return UIScreen.main.bounds.size.height + 350.0
        default:
            print("Not an iPhone")
            return UIScreen.main.bounds.size.height + 650.0
        }
    }
}

// MARK: - WeekdayViewProtocol

extension WeekViewController: WeekdayViewProtocol {
    func didTapInfoReport() {
        print("didTapInfoReport")
        let vc = MenuReportViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
