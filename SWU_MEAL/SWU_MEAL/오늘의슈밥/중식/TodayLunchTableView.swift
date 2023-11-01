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
    private let headerHeight: CGFloat = 26.0
    
    var itemsArray: [String]? {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.reloadData()
            }
        }
    }
    
    var itemsCount: Int = 1 {
        didSet {
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
        self.rowHeight = cellHeight
        self.register(
            TodayTableViewCell.self,
            forCellReuseIdentifier: TodayTableViewCell.identifier
        )
    }
    
}

extension TodayLunchTableView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsArray?.count ?? 0
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
