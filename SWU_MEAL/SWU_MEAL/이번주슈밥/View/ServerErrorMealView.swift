//
//  ServerErrorMealView.swift
//  SWU_MEAL
//
//  Created by 목정아 on 10/10/23.
//

import UIKit

final class ServerErrorMealView: UIView {
    
    // MARK: - Views

    private lazy var logoView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "Logo")?
            .withTintColor(.red)
            .resize(to: CGSize(width: 58.26, height: 58.26))
        
        return imageView
    }()
    
    private lazy var emptyLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = """
서버에 요청할 수 없습니다.
메일로 문의해주세요.
"""
        label.font = .uhbeeBold(size: 16.0)
        label.textColor = .red
        
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 10.0
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
        view.layer.cornerRadius = 10.0
        
        return view
    }()
    
    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(hex: "#F6F6F6")
        
        self.setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension ServerErrorMealView {
    
    func setupLayout() {
        [
            stackView,
            coverView
        ].forEach { addSubview($0)}
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 200.0),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
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

