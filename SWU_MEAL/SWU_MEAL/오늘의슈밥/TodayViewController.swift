//
//  TodayViewController.swift
//  SWU_MEAL
//
//  Created by 목정아 on 2023/09/24.
//

import UIKit

final class TodayViewController: UIViewController {
    
    // MARK: - Properties
    
    private var morningTimer: Timer?
    private var lunchTimer: Timer?
    private var dinnerTimer: Timer?
    
    private var morningTargetTime: Date?
    private var lunchTargetTime: Date?
    private var dinnerTargetTime: Date?
    
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
    
    private lazy var b_BubbleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Bubble")?
            .resize(to: CGSize(width: 96.0, height: 28.25))
        
        return imageView
    }()
    
    private lazy var b_countTimeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 10.0, weight: .semibold)
        label.text = "시작까지 09:54"
        
        return label
    }()
    
    private lazy var l_BubbleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Bubble")?
            .resize(to: CGSize(width: 96.0, height: 28.25))
        
        return imageView
    }()
    
    private lazy var l_countTimeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 10.0, weight: .semibold)
        label.text = "시작까지 09:54"
        
        return label
    }()
    
    private lazy var d_BubbleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Bubble")?
            .resize(to: CGSize(width: 96.0, height: 28.25))
        
        return imageView
    }()
    
    private lazy var d_countTimeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 10.0, weight: .semibold)
        label.text = "시작까지 09:54"
        
        return label
    }()
    
    private lazy var countTimeStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 1.0
        [
            b_BubbleImageView,
            l_BubbleImageView,
            d_BubbleImageView
        ].forEach { stackView.addArrangedSubview($0) }
        
        return stackView
    }()
    
    private let todayTabBarViewController = TodayTabBarController()
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundColor
        self.setupLayout()
    }
    
    deinit {
        morningTimer?.invalidate()
        lunchTimer?.invalidate()
        dinnerTimer?.invalidate()
    }
    
}

private extension TodayViewController {
    
    func setupLayout() {
        [
            titleLabel,
            highLightView,
            timeLabel,
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
        
        addChild(todayTabBarViewController)
        todayTabBarViewController.didMove(toParent: self)
        
        todayTabBarViewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            todayTabBarViewController.view.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 37.0),
            todayTabBarViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            todayTabBarViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            todayTabBarViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }
    
}

// MARK: - Helper

private extension TodayViewController {
    
    private func setupTargetTimes() {
        
        let currentDate = Date()
        
        // 아침 목표 시간 설정 (예: 아침 7시 30분)
        var calendar = Calendar.current
        calendar.timeZone = TimeZone.current
        var morningComponents = calendar.dateComponents([.year, .month, .day], from: currentDate)
        morningComponents.hour = 7
        morningComponents.minute = 30
        morningTargetTime = calendar.date(from: morningComponents)
        
        // 점심 목표 시간 설정 (예: 점심 11시 30분)
        var lunchComponents = calendar.dateComponents([.year, .month, .day], from: currentDate)
        lunchComponents.hour = 11
        lunchComponents.minute = 30
        lunchTargetTime = calendar.date(from: lunchComponents)
        
        // 저녁 목표 시간 설정 (예: 저녁 17시 10분)
        var dinnerComponents = calendar.dateComponents([.year, .month, .day], from: currentDate)
        dinnerComponents.hour = 17
        dinnerComponents.minute = 10
        dinnerTargetTime = calendar.date(from: dinnerComponents)
        
        // 목표 시간이 현재 시간보다 이전인 경우 다음날로 설정
        if morningTargetTime! < currentDate {
            morningTargetTime = morningTargetTime?.addingTimeInterval(86400)  
            // 86400초 = 24시간
        }
        if lunchTargetTime! < currentDate {
            lunchTargetTime = lunchTargetTime?.addingTimeInterval(86400)
        }
        if dinnerTargetTime! < currentDate {
            dinnerTargetTime = dinnerTargetTime?.addingTimeInterval(86400)
        }
    }
    
    private func startTimers() {
        startTimer(for: b_countTimeLabel, targetTime: morningTargetTime)
        startTimer(for: l_countTimeLabel, targetTime: lunchTargetTime)
        startTimer(for: d_countTimeLabel, targetTime: dinnerTargetTime)
    }
    
    private func startTimer(for label: UILabel, targetTime: Date?) {
        guard let targetTime = targetTime else { return }
        
        let timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCountdownLabel(_:)), userInfo: label, repeats: true)
        
        let currentDate = Date()
        if currentDate >= targetTime {
            timer.invalidate()
            label.text = "목표 시간에 도달했습니다."
        }
    }
    
    @objc private func updateCountdownLabel(_ timer: Timer) {
        guard let targetTime = targetTime(for: timer), let label = timer.userInfo as? UILabel else { return }
        
        let currentDate = Date()
        
        let timeRemaining = Calendar.current.dateComponents([.hour, .minute, .second], from: currentDate, to: targetTime)
        
        // 시간 텍스트 포맷 (예: "02:30:45")
        let timeString = String(format: "%02d:%02d:%02d", timeRemaining.hour ?? 0, timeRemaining.minute ?? 0, timeRemaining.second ?? 0)
        
        label.text = timeString
        
        if currentDate >= targetTime {
            timer.invalidate()
            label.text = "목표 시간에 도달했습니다."
        }
    }
    
    private func targetTime(for timer: Timer) -> Date? {
        if timer === morningTimer {
            return morningTargetTime
        } else if timer === lunchTimer {
            return lunchTargetTime
        } else if timer === dinnerTimer {
            return dinnerTargetTime
        }
        return nil
    }
    
}
