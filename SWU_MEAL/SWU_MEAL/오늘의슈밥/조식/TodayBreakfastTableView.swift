//
//  TodayBreakfastTableView.swift
//  SWU_MEAL
//
//  Created by 목정아 on 2023/09/25.
//

import UIKit

final class TodayBreakfastTableView: UITableView {
    
    private let todayMeal: [TodayMealModel] = [
        TodayMealModel(content: "야채죽"),
        TodayMealModel(content: "셀프 시리얼"),
        TodayMealModel(content: "계란후라이(1인 1개씩)"),
        TodayMealModel(content: "구운 소세지 & 케찹"),
        TodayMealModel(content: "우유&주스"),
        TodayMealModel(content: "배추김치")
    ]
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extension

private extension TodayBreakfastTableView {
    
    func setupLayout() {
        self.isScrollEnabled = false
        self.separatorStyle = .none
        
        self.dataSource = self
        self.register(
            TodayBreakfastTableViewCell.self,
            forCellReuseIdentifier: TodayBreakfastTableViewCell.identifier
        )
    }
    
}

extension TodayBreakfastTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todayMeal.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: TodayBreakfastTableViewCell.identifier,
            for: indexPath
        ) as? TodayBreakfastTableViewCell else { return UITableViewCell() }
        
        let model = todayMeal[indexPath.row]
        cell.setup(model: model)
        cell.selectionStyle = .none
        
        return cell
    }
}
