//
//  InquiryViewController.swift
//  SWU_MEAL
//
//  Created by 목정아 on 10/9/23.
//

import UIKit

final class InquiryViewController: UIViewController {
    
    // MARK: - Views
    
    private lazy var xmarkButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .black
        button.heightAnchor.constraint(equalToConstant: 24.0).isActive = true
        button.widthAnchor.constraint(equalToConstant: 24.0).isActive = true
        button.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        
        return button
    }()

    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigation()
        self.setupLayout()
        
       
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
       
    }
    
    @objc func didTapBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
}
