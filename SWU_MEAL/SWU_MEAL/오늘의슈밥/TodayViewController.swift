//
//  TodayViewController.swift
//  SWU_MEAL
//
//  Created by 목정아 on 2023/09/24.
//

import UIKit

final class TodayViewController: UIViewController {
    
    // MARK: - Properties

    
    // MARK: - Views

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = """
오늘의
아침 밥상은?
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
        view.widthAnchor.constraint(equalToConstant: 106.0).isActive = true
        view.heightAnchor.constraint(equalToConstant: height).isActive = true
        
        return view
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.text = "아침시간 : 7:30~9:00"
        label.textColor = UIColor(hex: "#999999")
        label.font = .systemFont(ofSize: 14.0)
        
        return label
    }()
    
    private lazy var timeBubbleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Bubble")?
            .resize(to: CGSize(width: 96.0, height: 28.25))
        
        return imageView
    }()
    
    private lazy var countTimeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 10.0, weight: .semibold)
        label.text = "시작까지 09:54"
        
        return label
    }()
    
    private let todayTabBarViewController = TodayTabBarController()
    
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundColor
        self.setupLayout()
    }
    
}

private extension TodayViewController {
    
    func setupLayout() {
        [
            titleLabel,
            highLightView,
            timeLabel,
            timeBubbleImageView,
            countTimeLabel,
            todayTabBarViewController.view
        ].forEach { view.addSubview($0) }
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24.0)
        ])
        
        highLightView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            highLightView.bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: -2.0),
            highLightView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant: -2.0)
        ])
        
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15.0),
            timeLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor)
        ])
        
        timeBubbleImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            timeBubbleImageView.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 15.0),
            timeBubbleImageView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor)
        ])
        
        countTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            countTimeLabel.centerXAnchor.constraint(equalTo: timeBubbleImageView.centerXAnchor),
            countTimeLabel.centerYAnchor.constraint(equalTo: timeBubbleImageView.centerYAnchor, constant: -2.3)
        ])
        
        addChild(todayTabBarViewController)
        todayTabBarViewController.didMove(toParent: self)
        
        todayTabBarViewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            todayTabBarViewController.view.topAnchor.constraint(equalTo: timeBubbleImageView.bottomAnchor, constant: 3.0),
            todayTabBarViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            todayTabBarViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            todayTabBarViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }
    
}
