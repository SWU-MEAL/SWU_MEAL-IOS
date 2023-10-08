//
//  EmptyMealView.swift
//  SWU_MEAL
//
//  Created by 목정아 on 10/9/23.
//

import UIKit

final class EmptyMealView: UIView {
    
    // MARK: - Views

    private lazy var logoView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "Logo")?
            .resize(to: CGSize(width: 66.0, height: 66.0))
        
        return imageView
    }()
    
    private lazy var emptyLabel: UILabel = {
        let label = UILabel()
        label.text = "텅.."
        label.font = .uhbeeBold(size: 30.0)
        label.textColor = .mainOrangeColor
        
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

private extension EmptyMealView {
    
    func setupLayout() {
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 250.0),
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
}
