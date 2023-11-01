//
//  TodayDinnerTableView.swift
//  SWU_MEAL
//
//  Created by 목정아 on 2023/09/26.
//

import UIKit

final class TodayDinnerTableView: UITableView {
    
    // MARK: - Properties
    
    private let cellHeight: CGFloat = 32.0
    private let headerHeight: CGFloat = 26.0
    
    var itemsArray: [String]? {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.reloadData()
//                print("WeekmorningTableView Data : \(self?.b_itemsArray ?? [])")
            }
        }
    }
    
    var itemsCount: Int = 1 {
        didSet {
            DispatchQueue.main.async {
                self.heightAnchor.constraint(
                    equalToConstant: self.cellHeight * CGFloat(self.itemsCount) + (self.headerHeight * 2)
                ).isActive = true
            }
        }
    }
    
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
        self.register(
            TodayTableViewCell.self,
            forCellReuseIdentifier: TodayTableViewCell.identifier
        )
        let emptyHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: headerHeight))
        self.tableHeaderView = emptyHeaderView
        self.tableFooterView = emptyHeaderView
    }
    
}

extension TodayDinnerTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: TodayTableViewCell.identifier,
            for: indexPath
        ) as? TodayTableViewCell else { return UITableViewCell() }
        
        if let item = itemsArray?[indexPath.row] {
            cell.setup(content: item)
        }
        cell.selectionStyle = .none
        
        return cell
    }
}
