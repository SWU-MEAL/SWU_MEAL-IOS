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
        label.font = UIFont.preferredFont(forTextStyle: .body)
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
          contentView.heightAnchor.constraint(equalToConstant:  calculateDynamicHeight())
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
        
        termsTextLabel.adjustsFontForContentSizeCategory = true
        termsTextLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            termsTextLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20.0),
            termsTextLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10.0),
            termsTextLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10.0),
        ])
    }
    
}

private extension TermsViewController {
    
    func calculateDynamicHeight() -> CGFloat {
        let bounds = UIScreen.main.bounds
        let height = bounds.size.height

        switch height {
        case 480.0: // iPhone 3, 4S -> 예측값
            return UIScreen.main.bounds.size.height + 7100.0
        case 568.0: // iPhone 5, SE -> 예측값
            return UIScreen.main.bounds.size.height + 6950.0
        case 667.0: // iPhone 6, 6s, 7, 8
            return UIScreen.main.bounds.size.height + 6900.0
        case 736.0: // iPhone 6s+, 6+, 7+, 8+ -> 예측값
            return UIScreen.main.bounds.size.height + 6875.0
        case 812.0: // iPhone X, XS => 5.8 inch
            return UIScreen.main.bounds.size.height + 6800.0
        case 844.0: // iphone 14, iPhone 13 Pro, iPhone 13, iPhone 12 Pro, iPhone 12
            return UIScreen.main.bounds.size.height + 6600.0
        case 852.0: // iPhone 15 Pro, iPhone 15, iPhone 14 Pro
            return UIScreen.main.bounds.size.height + 6600.0
        case 896.0: // iPhone 11 Pro Max, iPhone 11, iPhone XS Max, iPhone XR
            return UIScreen.main.bounds.size.height + 6100.0
        case 926.0: // iPhone 13 Pro Max, iPhone 12 Pro Max
            return UIScreen.main.bounds.size.height + 5900.0
        case 932.0: // iphone 15 max, iPhone 15 Plus, iPhone 14 Pro Max
            return UIScreen.main.bounds.size.height + 5900.0
        default:
            print("Not an iPhone")
            return UIScreen.main.bounds.size.height + 7100.0
        }
    }
    
    // MARK: - @objc

    @objc func didTapBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
}
