//
//  SplashVC.swift
//  SWU_MEAL
//
//  Created by 목정아 on 10/7/23.
//

import UIKit

final class SplashVC: UIViewController {
    
    // MARK: - Properties
    private var timer: Timer?
    
    // MARK: - Views
    
    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "Splash")?
            .resize(to: CGSize(width: 100.38, height: 98.13))
        
        return imageView
    }()
    
    private lazy var logoUILabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        
        let mutableAttributedString = NSMutableAttributedString(
            string: "슈니들의:밥상",
            attributes: [
                .font: UIFont.uhbee(size: 30.0) as Any,
                .foregroundColor: UIColor.white.withAlphaComponent(0.4),
            ]
        )
        
        mutableAttributedString.addAttribute(
            .font,
            value: UIFont.uhbeeBold(size: 30.0) as Any,
            range: NSRange(location: 0, length: 1)
        )
        mutableAttributedString.addAttribute(
            .foregroundColor,
            value: UIColor.white,
            range: NSRange(location: 0, length: 1)
        )
        mutableAttributedString.addAttribute(.font, value: UIFont.uhbeeBold(size: 30.0) as Any, range: NSRange(location: 5, length: 1))
        mutableAttributedString.addAttribute(
            .foregroundColor,
            value: UIColor.white,
            range: NSRange(location: 5, length: 1)
        )
        label.attributedText = mutableAttributedString
        
        return label
    }()
    
    
    private lazy var logoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 30.87
        stackView.alignment = .center
        [
            logoImageView,
            logoUILabel
        ].forEach { stackView.addArrangedSubview($0) }
        
        return stackView
    }()
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .mainOrangeColor
        timer = Timer.scheduledTimer(
            timeInterval: 2.0,
            target: self,
            selector: #selector(transitionToNextScreen),
            userInfo: nil,
            repeats: false
        )
        self.setupLayout()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer?.invalidate()
        timer = nil
    }
}

// MARK: - Extension

private extension SplashVC {
    
    func setupLayout() {
        view.addSubview(logoStackView)
        logoStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logoStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc func transitionToNextScreen() {
        let newViewController = TabBarController()
        let navigationController = UINavigationController(rootViewController: newViewController)
        navigationController.modalTransitionStyle = .crossDissolve
        navigationController.modalPresentationStyle = .fullScreen
        self.present(navigationController, animated: true, completion: nil)
    }
    
}
