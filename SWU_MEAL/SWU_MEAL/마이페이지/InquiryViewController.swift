//
//  InquiryViewController.swift
//  SWU_MEAL
//
//  Created by 목정아 on 10/9/23.
//

import UIKit

final class InquiryViewController: UIViewController {
    
    // MARK: - Views
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private lazy var xmarkButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .black
        button.heightAnchor.constraint(equalToConstant: 24.0).isActive = true
        button.widthAnchor.constraint(equalToConstant: 24.0).isActive = true
        button.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        
        return button
    }()
    
    private let sortView = WhiteView(frame: .zero, height: 52.0)

    
    private let infoView = WhiteView(frame: .zero, height: 250.0)

    private let fileView = WhiteView(frame: .zero, height: 52.0)
    
    private let emailView = WhiteView(frame: .zero, height: 52.0)
    
    private lazy var registerButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .reportUnActiveColor
        button.layer.cornerRadius = 10.0
        button.setTitle("문의 접수하기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16.0, weight: .regular)
        button.heightAnchor.constraint(equalToConstant: 48.0).isActive = true
        
        return button
    }()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.setupNavigation()
        //self.setupLayout()
        
    }
    
}

private extension InquiryViewController {
    
    func setupNavigation() {
        self.view.backgroundColor = UIColor(hex: "#F6F6F6")
        self.navigationItem.hidesBackButton = true
        self.navigationItem.title = "문의하기"
        
        let customBackButtonItem = UIBarButtonItem(customView: xmarkButton)
        self.navigationItem.leftBarButtonItem = customBackButtonItem
        self.navigationController?.navigationBar.titleTextAttributes = [
            .font: UIFont.systemFont(ofSize: 16.0, weight: .bold),
            .foregroundColor: UIColor.black
        ]
    }
    
    func setupLayout() {
        [
            sortView,
            infoView,
            fileView,
            emailView,
            registerButton
        ].forEach { view.addSubview($0) }
        
        sortView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sortView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32.0),
            sortView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24.0),
            sortView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24.0)
        ])
        
        infoView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            infoView.topAnchor.constraint(equalTo: sortView.bottomAnchor, constant: 14.0),
            infoView.leadingAnchor.constraint(equalTo: sortView.leadingAnchor),
            infoView.trailingAnchor.constraint(equalTo: sortView.trailingAnchor)
        ])
        
        fileView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            fileView.topAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 14.0),
            fileView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            fileView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        
        emailView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emailView.topAnchor.constraint(equalTo: fileView.bottomAnchor, constant: 14.0),
            emailView.leadingAnchor.constraint(equalTo: fileView.leadingAnchor),
            emailView.trailingAnchor.constraint(equalTo: fileView.trailingAnchor)
        ])
        
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            registerButton.leadingAnchor.constraint(equalTo: sortView.leadingAnchor),
            registerButton.trailingAnchor.constraint(equalTo: sortView.trailingAnchor),
            registerButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32.0)
        ])
        
    }
    
    @objc func didTapBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
}
