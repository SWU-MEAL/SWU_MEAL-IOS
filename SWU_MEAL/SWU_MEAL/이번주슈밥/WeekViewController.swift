//
//  WeekViewController.swift
//  SWU_MEAL
//
//  Created by 목정아 on 2023/09/24.
//

import UIKit

final class WeekViewController: UIViewController {
    
    // MARK: - Properties
    
    // MARK: - Views
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = """
이번주
슈니의 밥상 🍽
"""
        label.numberOfLines = 0
        label.textColor = .black
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 28.0, weight: .semibold)
        
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
    
    private let scheduleView = WeekdayView(frame: .zero)
    
    private let weekdayTabBarController = WeekViewTabBarController()
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundColor
        
        scheduleView.setupDelegate(self)
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
            contentView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.height + 550)
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

// MARK: - WeekdayViewProtocol

extension WeekViewController: WeekdayViewProtocol {
    func didTapInfoReport() {
        let vc = MenuReportViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
