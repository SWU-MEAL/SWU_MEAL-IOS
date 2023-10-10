//
//  CustomActivityIndicatorView.swift
//  SWU_MEAL
//
//  Created by 목정아 on 10/10/23.
//

import UIKit

class CustomActivityIndicatorView: UIView {
    
    private let activityIndicatorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Logo")?
            .resize(to: CGSize(width: 47.0, height: 49.0))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    init() {
        super.init(frame: .zero)
        self.backgroundColor = .white
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(activityIndicatorImageView)
        activityIndicatorImageView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicatorImageView.topAnchor.constraint(equalTo: topAnchor, constant: 150.0).isActive = true
    }
    
    func startAnimating() {
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.toValue = NSNumber(value: Double.pi * 2)
        rotationAnimation.duration = 1.0
        rotationAnimation.isCumulative = true
        rotationAnimation.repeatCount = .infinity
        activityIndicatorImageView.layer.add(rotationAnimation, forKey: "rotationAnimation")
    }
    
    func stopAnimating() {
        activityIndicatorImageView.layer.removeAllAnimations()
    }
}

