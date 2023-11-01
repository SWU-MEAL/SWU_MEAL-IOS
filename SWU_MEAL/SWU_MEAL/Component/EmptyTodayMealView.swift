//
//  EmptyTodayMealView.swift
//  SWU_MEAL
//
//  Created by 목정아 on 10/28/23.
//

import UIKit

final class EmptyTodayMealView: UIView {
    
    // MARK: - Views
    
    private lazy var whiteView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10.0
        
        return view
    }()

    private lazy var logoView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "Logo")?
            .withTintColor(UIColor(hex: "#191919"))
            .resize(to: CGSize(width: 58.26, height: 58.26))
        
        return imageView
    }()
    
    private lazy var emptyLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = """
오늘은 공휴일!
급식을 진행하지 않아요!
"""
        label.font = .uhbeeBold(size: 16.0)
        label.textColor = UIColor(hex: "#191919")
        
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 15.0
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .center
        [
            logoView,
            emptyLabel
        ].forEach { stackView.addArrangedSubview($0) }
        
        return stackView
    }()
    
    private lazy var coverView: UIView = {
        let view = UIView()
        view.backgroundColor = .white.withAlphaComponent(0.85)
        
        return view
    }()
    
    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(hex: "#BCBCBC")
        
        self.setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension EmptyTodayMealView {
    
    func setupLayout() {
        [
            whiteView,
            stackView,
            coverView
        ].forEach { addSubview($0)}
        
        whiteView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            whiteView.topAnchor.constraint(equalTo: topAnchor, constant: 90.0),
            whiteView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24.0),
            whiteView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24.0),
            whiteView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -69.0),
        ])
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: whiteView.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: whiteView.centerYAnchor)
        ])
        
        coverView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            coverView.topAnchor.constraint(equalTo: topAnchor),
            coverView.leadingAnchor.constraint(equalTo: leadingAnchor),
            coverView.trailingAnchor.constraint(equalTo: trailingAnchor),
            coverView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
