//
//  MypageTableView.swift
//  SWU_MEAL
//
//  Created by 목정아 on 2023/09/26.
//

import UIKit

final class MypageTableView: UITableView {
    
    private let cellHeight: CGFloat = 56.0
    
    private let mypageModel: [MypageModel] = [
        MypageModel(title: "버전 정보 \(UIApplication.version)"),
        MypageModel(title: "이용약관"),
        MypageModel(title: "문의")
    ]
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.setupTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTableView() {
        self.dataSource = self
        self.rowHeight = self.cellHeight
        self.register(
            MypageTableViewCell.self, 
            forCellReuseIdentifier: MypageTableViewCell.identifier
        )
      }
}

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
