//
//  TodayLunchTableView.swift
//  SWU_MEAL
//
//  Created by 목정아 on 2023/09/26.
//

import UIKit

final class TodayLunchTableView: UITableView {
    
    // MARK: - Properties

    private let cellHeight: CGFloat = 32.0
    
    private let todayMeal: [TodayMealModel] = [
        TodayMealModel(content: "햄김치볶음밥"),
        TodayMealModel(content: "고로케&케찹"),
        TodayMealModel(content: "self 우동국물"),
        TodayMealModel(content: "단무지"),
        TodayMealModel(content: "배추김치")
    ]
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setupTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTableView() {
        self.dataSource = self
        self.isScrollEnabled = false
        self.separatorStyle = .none
        self.layer.cornerRadius = 10.0
        self.rowHeight = cellHeight
        self.heightAnchor.constraint(
            equalToConstant: cellHeight * CGFloat(todayMeal.count)
        ).isActive = true
        
        self.register(
            TodayLunchTableViewCell.self,
            forCellReuseIdentifier: TodayLunchTableViewCell.identifier
        )
    }
    
}

extension TodayLunchTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todayMeal.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: TodayLunchTableViewCell.identifier,
            for: indexPath
        ) as? TodayLunchTableViewCell else { return UITableViewCell() }
        
        let model = todayMeal[indexPath.row]
        cell.setup(model: model)
        cell.selectionStyle = .none
        
        return cell
    }
}
