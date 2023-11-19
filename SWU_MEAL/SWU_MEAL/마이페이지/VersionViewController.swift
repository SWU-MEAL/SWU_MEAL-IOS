//
//  VersionViewController.swift
//  SWU_MEAL
//
//  Created by 목정아 on 10/9/23.
//

import UIKit

enum Announcement: String {
    case latestVersion = "최신 버전을 사용하고 있는 중입니다"
    case updateVersion = "최신 버전으로 업데이트 해주세요."
}

final class VersionViewController: UIViewController {
    
    // MARK: - Views

    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        button.tintColor = .black
        button.heightAnchor.constraint(equalToConstant: 31.0).isActive = true
        button.widthAnchor.constraint(equalToConstant: 31.0).isActive = true
        button.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "AppLogo")?
            .resize(to: CGSize(width: 86.0, height: 86.0))
        
        return imageView
    }()
    
    private lazy var announcementLabel: UILabel = {
        let label = UILabel()
        if let shortVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String,
           let buildNumber = Bundle.main.infoDictionary?["CFBundleVersion"] as? String {
           let currentAppVersion = "\(shortVersion).\(buildNumber)"
            if buildNumber != "3"{
                label.text = Announcement.updateVersion.rawValue
            } else {
                label.text = Announcement.latestVersion.rawValue
            }
            print(currentAppVersion)
        }
        label.textColor = .black
        label.font = .systemFont(ofSize: 16.0)
        
        return label
    }()
    
    private lazy var versionLabel: UILabel = {
        let label = UILabel()
        if let shortVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String,
           let buildNumber = Bundle.main.infoDictionary?["CFBundleVersion"] as? String {
           let currentAppVersion = "\(shortVersion).\(buildNumber)"
            if buildNumber != "2"{
                label.text =  "최신 버전 \(currentAppVersion)"
            } else {
                label.text =  "현재 버전 \(currentAppVersion)"
            }
        }
        label.textColor = .textColor3
        label.font = .systemFont(ofSize: 12.0)
        
        return label
    }()
    
    private lazy var labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 8.0
        stackView.alignment = .center
        stackView.axis = .vertical
        [
            announcementLabel,
            versionLabel
        ].forEach { stackView.addArrangedSubview($0) }
        
        return stackView
    }()
    
    private lazy var allStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 24.0
        stackView.alignment = .center
        stackView.axis = .vertical
        [
            logoImageView,
            labelStackView
        ].forEach { stackView.addArrangedSubview($0) }
        
        return stackView
    }()
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(hex: "#F6F6F6")
        self.setupNavigation()
        self.setupLayout()
    }
    
}

private extension VersionViewController {
    
    func setupNavigation() {
        self.navigationItem.hidesBackButton = true
        
        let customBackButtonItem = UIBarButtonItem(customView: backButton)
        self.navigationItem.leftBarButtonItem = customBackButtonItem
        self.navigationController?.navigationBar.titleTextAttributes = [
            .font: UIFont.systemFont(ofSize: 16.0, weight: .bold),
            .foregroundColor: UIColor.black
        ]
        self.navigationItem.title = "버전 정보"
    }
    
    func setupLayout() {
        view.addSubview(allStackView)
        allStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            allStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            allStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 50.0)
        ])
    }
    
    @objc func didTapBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
}
