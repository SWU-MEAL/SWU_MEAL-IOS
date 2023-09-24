//
//  WeekViewController.swift
//  SWU_MEAL
//
//  Created by 목정아 on 2023/09/24.
//

import UIKit

final class WeekViewController: UIViewController {
    
    // MARK: - Views

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
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundColor
        self.setupLayout()
    }
    
}

// MARK: - Extension

private extension WeekViewController {
    
    func setupLayout() {
        [
            titleLabel,
            highLightView,
        ].forEach { view.addSubview($0) }
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24.0)
        ])
        
        highLightView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            highLightView.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 27.0),
            highLightView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant: -2.0)
        ])
    }
    
}

