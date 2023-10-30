//
//  TermsViewController.swift
//  SWU_MEAL
//
//  Created by 목정아 on 10/31/23.
//

import UIKit

final class TermsViewController: UIViewController {

    // MARK: - Properties

    private let apiManager = APIManager()
    
    // MARK: - Views
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private lazy var customActivityIndicatorView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.style = .medium
        indicator.color = .mainGrayColor
        indicator.isHidden = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()

    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        button.tintColor = .black
        button.heightAnchor.constraint(equalToConstant: 31.0).isActive = true
        button.widthAnchor.constraint(equalToConstant: 31.0).isActive = true
        button.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var termsTextLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .systemFont(ofSize: 15.0)
        label.textColor = UIColor(hex: "#606060")
        label.textAlignment = .justified
        label.numberOfLines = 0
        
        return label
    }()
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        self.setupNavigation()
        self.setupLayout()
        self.customActivityIndicatorView.startAnimating()
        apiManager.getTermsData(completion: { [weak self] result in
            guard let self = self else { return }
            self.customActivityIndicatorView.stopAnimating()
            self.customActivityIndicatorView.removeFromSuperview()
            switch result {
            case let .success(result):
                self.termsTextLabel.text = """
○ 이용약관 : 

\(result.data.terms)

○ 개인정보 처리방침 :

\(result.data.policy)

"""
            case let .failure(error):
              print("ERROR : \(error)")
            }
          })
    }
    
}

private extension TermsViewController {
    
    func setupNavigation() {
        self.navigationItem.hidesBackButton = true
        
        let customBackButtonItem = UIBarButtonItem(customView: backButton)
        self.navigationItem.leftBarButtonItem = customBackButtonItem
        self.navigationController?.navigationBar.titleTextAttributes = [
            .font: UIFont.systemFont(ofSize: 15.0, weight: .bold),
            .foregroundColor: UIColor.black
        ]
        self.navigationItem.title = "이용 약관"
    }
    
    func setupLayout() {
        
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
          scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
          scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
          scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
          scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
          contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
          contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
          contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
          contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
          contentView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width),
          contentView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.height +  6600.0)
        ])
        
        [
            customActivityIndicatorView,
            termsTextLabel
        ].forEach { contentView.addSubview($0) }
        
        customActivityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            customActivityIndicatorView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            customActivityIndicatorView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        ])
        
        termsTextLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            termsTextLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20.0),
            termsTextLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10.0),
            termsTextLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10.0),
        ])
    }
    
}

private extension TermsViewController {
    
    // MARK: - @objc

    @objc func didTapBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
}
