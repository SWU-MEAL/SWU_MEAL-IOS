//
//  TodayDinnerViewController.swift
//  SWU_MEAL
//
//  Created by 목정아 on 2023/09/24.
//

import UIKit

final class TodayDinnerViewController: UIViewController {
    
    // MARK: - Properties

    private let apiManager = APIManager()
    private let todayDate: String = APIManager().calculateTodayDate()

    // MARK: - Views
    
    private lazy var  customActivityIndicatorView: CustomActivityIndicatorView = {
        let indicator = CustomActivityIndicatorView()
        indicator.isHidden = true
        
        return indicator
    }()

    private lazy var menuView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10.0
        
        return view
    }()

    private let dinnerTableView = TodayDinnerTableView(frame: .zero)
    
    private lazy var emptyView: EmptyTodayMealView = {
        let view = EmptyTodayMealView()
        view.isHidden = true
        
        return view
    }()

    private lazy var errorView: ServerErrorMealView = {
        let view = ServerErrorMealView()
        view.isHidden = true
        
        return view
    }()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "#F6F6F6")
        self.setupLayout()
        self.setupDinnerServer(date: todayDate)
    }
}

// MARK: - Extension

private extension TodayDinnerViewController {

    func setupLayout() {
        [
            menuView,
            dinnerTableView,
            emptyView,
            errorView,
            customActivityIndicatorView
        ].forEach { view.addSubview($0) }
        
        menuView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            menuView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32.0),
            menuView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24.0),
            menuView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24.0),
            menuView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -72.0)
        ])
        
        dinnerTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dinnerTableView.centerYAnchor.constraint(equalTo: menuView.centerYAnchor),
            dinnerTableView.leadingAnchor.constraint(equalTo: menuView.leadingAnchor),
            dinnerTableView.trailingAnchor.constraint(equalTo: menuView.trailingAnchor),
        ])
        
        emptyView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emptyView.topAnchor.constraint(equalTo: view.topAnchor),
            emptyView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            emptyView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            emptyView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        errorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            errorView.topAnchor.constraint(equalTo: view.topAnchor),
            errorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            errorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            errorView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        customActivityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            customActivityIndicatorView.topAnchor.constraint(equalTo: view.topAnchor),
            customActivityIndicatorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customActivityIndicatorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            customActivityIndicatorView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    // MARK: - Func
    
    func showIndicator() {
        self.customActivityIndicatorView.startAnimating()
        self.customActivityIndicatorView.isHidden = false
    }
    
    func hideIndicator() {
        self.customActivityIndicatorView.stopAnimating()
        self.customActivityIndicatorView.isHidden = true
    }

     func showEmptyView() {
        self.emptyView.isHidden = false
     }

    func hideEmptyView() {
        self.emptyView.isHidden = true
    }
    
    func showErrorView() {
        self.errorView.isHidden = false
    }
    
    func hideErrorView() {
        self.errorView.isHidden = true
    }
    
    // MARK: - Helper

    /// 이번주 슈밥 - 석식 API
    private func setupDinnerServer(date: String) {
        
        self.showIndicator()
        
        apiManager.todayMealGetData(date: date, time: "d") { [weak self] result in

            self?.hideIndicator()
            
            switch result {
            case .success(let todayMealModel):
                if let menuList = self?.apiManager.todayGetMenuListForDate(
                    date: date,
                    time: "d",
                    todayMealModel: todayMealModel
                ) {
                    self?.hideErrorView()
                    self?.hideEmptyView()
                    self?.hideIndicator()
                    
                    self?.dinnerTableView.itemsArray = menuList.flatMap { $0.items }
                    self?.dinnerTableView.itemsCount = menuList.map { $0.items.count }.reduce(0, +)
                } else {
                    print("저녁 메뉴 리스트를 찾을 수 없습니다.")
                    self?.showEmptyView()
                }
            case .failure(let error):
                print("요청 실패: \(error.localizedDescription)")
                self?.showErrorView()
            }
        }
    }
}
