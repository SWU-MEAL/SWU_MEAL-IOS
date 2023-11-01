//
//  MypageTableView.swift
//  SWU_MEAL
//
//  Created by 목정아 on 2023/09/26.
//

import UIKit

protocol MyPageProtocol: AnyObject {
    func didTapInquries()
    func didTapTerms()
    func didTapVersion()
}

final class MypageTableView: UITableView {
    
    private weak var mypageDelegate: MyPageProtocol?
    
    private let cellHeight: CGFloat = 56.0
    
    private let mypageModel: [MypageModel] = [
        MypageModel(title: "버전 정보 1.0.0"),
        // MypageModel(title: "버전 정보 \(UIApplication.version)"),
        MypageModel(title: "이용약관"),
        // MypageModel(title: "문의")
    ]
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.setupTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTableView() {
        self.backgroundColor = .white
        self.delegate = self
        self.dataSource = self
        self.rowHeight = self.cellHeight
        self.register(
            MypageTableViewCell.self, 
            forCellReuseIdentifier: MypageTableViewCell.identifier
        )
      }
    
    func setupDelegate(delegate: MyPageProtocol) {
        self.mypageDelegate = delegate
    }
    
}

// MARK: - UITableViewDelegate

extension MypageTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            self.didTapVersion()
        case 1:
            self.didTapTerms()
        case 2:
            print(indexPath.row)
        default:
            print("Default")
        }
    }
}

// MARK: - UITableViewDataSource

extension MypageTableView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mypageModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: MypageTableViewCell.identifier,
            for: indexPath
        ) as? MypageTableViewCell else { return UITableViewCell() }
        
        let model = mypageModel[indexPath.row]
        cell.setup(model: model)
        cell.selectionStyle = .none
        
        return cell
    }
}

private extension MypageTableView {
    
    func didTapInquries() {
        self.mypageDelegate?.didTapInquries()
    }
    
    func didTapVersion() {
        self.mypageDelegate?.didTapVersion()
    }
    
    func didTapTerms() {
        self.mypageDelegate?.didTapTerms()
    }
    
}
