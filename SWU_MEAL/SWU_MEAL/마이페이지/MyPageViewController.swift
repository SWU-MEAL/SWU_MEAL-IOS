//
//  MyPageViewController.swift
//  SWU_MEAL
//
//  Created by 목정아 on 2023/09/24.
//

import UIKit

final class MyPageViewController: UIViewController {
    
    // MARK: - Views
    
    private lazy var shadowView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowRadius = 5.0
        view.layer.shadowOffset = CGSize(width: 0, height: 10)
        view.heightAnchor.constraint(equalToConstant: 2.0).isActive = true
        
        return view
    }()

    private lazy var appIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "Logo")
        imageView.heightAnchor.constraint(equalToConstant: 24.0).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 24.0).isActive = true
        
        return imageView
    }()
    
    private lazy var appLabel: UILabel = {
        let label = UILabel()
        label.text = "슈:밥"
        label.textColor = .mainOrangeColor
        label.font = .uhbeeBold(size: 16.0)
        
        return label
    }()
    
    private lazy var appStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 8.0
        [
            appIcon,
            appLabel
        ].forEach { stackView.addArrangedSubview($0) }
        
        return stackView
    }()
    
    private let wrapperView = UIView()

    private let mypageTableView = MypageTableView(frame: .zero)
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.setup()
        self.setupNavigation()
        self.mypageTableView.setupDelegate(delegate: self)
    }
}

private extension MyPageViewController {
    
    func setupNavigation() {
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.backgroundColor = UIColor.white
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
       
        } else {
            self.navigationController?.navigationBar.barTintColor = UIColor.white
        }
    
        let leftItem = UIBarButtonItem(customView: wrapperView)
        navigationItem.leftBarButtonItem = leftItem
    }
    
    func setup() {
        view.backgroundColor = .white
        [
            mypageTableView
        ].forEach { view.addSubview($0) }

        mypageTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mypageTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mypageTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mypageTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mypageTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        wrapperView.addSubview(appStackView)
        appStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            appStackView.bottomAnchor.constraint(equalTo: wrapperView.bottomAnchor, constant: 5.0),
            appStackView.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor, constant: 8.0),
        ])
        
    }
    
}

extension MyPageViewController: MyPageProtocol {

    func didTapInquries() {
        let vc = InquiryViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
