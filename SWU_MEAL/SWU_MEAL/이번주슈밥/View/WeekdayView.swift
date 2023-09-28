//
//  WeekdayView.swift
//  SWU_MEAL
//
//  Created by 목정아 on 2023/09/27.
//

import UIKit

protocol WeekdayViewProtocol: AnyObject {
    func didTapInfoReport()
}

final class WeekdayView: UIView {
    
    // MARK: - Properties
    
    private weak var weekdayDelegate: WeekdayViewProtocol?
    
    // MARK: - Views
    
    private lazy var morningLabel: UILabel = {
        let label = UILabel()
        label.text = "🌞 아침식사"
        label.textColor = .black
        label.font = .systemFont(ofSize: 20.0, weight: .bold)
        
        return label
    }()
    
    private lazy var morningTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "7:30 ~ 9:00"
        label.textColor = UIColor(hex: "#606060")
        label.font = .systemFont(ofSize: 12.0, weight: .regular)
        
        return label
    }()
    
    private lazy var morningStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 12.0
        stackView.distribution = .fill
        [
            morningLabel,
            morningTimeLabel
        ].forEach { stackView.addArrangedSubview($0) }
        
        return stackView
    }()
    
    private lazy var morningView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10.0
        view.backgroundColor = .white
        view.heightAnchor.constraint(equalToConstant: 220.0).isActive = true
        
        return view
    }()
    
    private lazy var launchLabel: UILabel = {
        let label = UILabel()
        label.text = "🍚 점심식사"
        label.textColor = .black
        label.font = .systemFont(ofSize: 20.0, weight: .bold)
        
        return label
    }()
    
    private lazy var launchTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "11:30 ~ 13:30"
        label.textColor = UIColor(hex: "#606060")
        label.font = .systemFont(ofSize: 12.0, weight: .regular)
        
        return label
    }()
    
    private lazy var launchStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 12.0
        stackView.distribution = .fill
        [
            launchLabel,
            launchTimeLabel
        ].forEach { stackView.addArrangedSubview($0) }
        
        return stackView
    }()
    
    private lazy var launchView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10.0
        view.backgroundColor = .white
        view.heightAnchor.constraint(equalToConstant: 260.0).isActive = true
        
        return view
    }()
    
    private lazy var dinnerLabel: UILabel = {
        let label = UILabel()
        label.text = "🌙 저녁식사"
        label.textColor = .black
        label.font = .systemFont(ofSize: 20.0, weight: .bold)
        
        return label
    }()
    
    private lazy var dinnerTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "17:10 ~ 18:30"
        label.textColor = UIColor(hex: "#606060")
        label.font = .systemFont(ofSize: 12.0, weight: .regular)
        
        return label
    }()
    
    private lazy var dinnerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 12.0
        stackView.distribution = .fill
        [
            dinnerLabel,
            dinnerTimeLabel
        ].forEach { stackView.addArrangedSubview($0) }
        
        return stackView
    }()
    
    private lazy var dinnerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10.0
        view.backgroundColor = .white
        view.heightAnchor.constraint(equalToConstant: 220.0).isActive = true
        
        return view
    }()
    
    private lazy var infoReportButton: UIButton = {
        let button = UIButton()
        button.setTitle("메뉴 정보가 잘못되었나요?", for: .normal)
        button.setTitleColor(UIColor(hex: "#606060"), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12.0, weight: .regular)
        button.addTarget(self, action: #selector(didTapInfoReport), for: .touchUpInside)
        
        return button
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
    
    func setupDelegate(_ delegate: WeekdayViewProtocol?) {
        self.weekdayDelegate = delegate
    }
    
}

private extension WeekdayView {
    
    func setupLayout() {
        [
            morningStackView,
            morningView,
            launchStackView,
            launchView,
            dinnerStackView,
            dinnerView,
            infoReportButton
        ].forEach { addSubview($0) }

        morningStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            morningStackView.topAnchor.constraint(equalTo: topAnchor, constant: 35.0),
            morningStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24.0)
        ])

        morningView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            morningView.leadingAnchor.constraint(equalTo: morningStackView.leadingAnchor),
            morningView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24.0),
            morningView.topAnchor.constraint(equalTo: morningStackView.bottomAnchor, constant: 10.0),
        ])
        
        launchStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            launchStackView.topAnchor.constraint(equalTo: morningView.bottomAnchor, constant: 36.0),
            launchStackView.leadingAnchor.constraint(equalTo: morningStackView.leadingAnchor)
        ])
        
        launchView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            launchView.topAnchor.constraint(equalTo: launchStackView.bottomAnchor, constant: 10.0),
            launchView.leadingAnchor.constraint(equalTo: launchStackView.leadingAnchor),
            launchView.trailingAnchor.constraint(equalTo: morningView.trailingAnchor),
        ])
        
        dinnerStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dinnerStackView.topAnchor.constraint(equalTo: launchView.bottomAnchor, constant: 36.0),
            dinnerStackView.leadingAnchor.constraint(equalTo: morningStackView.leadingAnchor)
        ])
        
        dinnerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dinnerView.topAnchor.constraint(equalTo: dinnerStackView.bottomAnchor, constant: 10.0),
            dinnerView.leadingAnchor.constraint(equalTo: dinnerStackView.leadingAnchor),
            dinnerView.trailingAnchor.constraint(equalTo: morningView.trailingAnchor)
        ])
        
        infoReportButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            infoReportButton.topAnchor.constraint(equalTo: dinnerView.bottomAnchor, constant: 32.0),
            infoReportButton.centerXAnchor.constraint(equalTo: dinnerView.centerXAnchor)
        ])
    }
    
    @objc func didTapInfoReport() {
        self.weekdayDelegate?.didTapInfoReport()
    }
    
}
