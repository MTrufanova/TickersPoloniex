//
//  TickerHeaderView.swift
//  TickersPoloniex
//
//  Created by msc on 10.03.2021.
//

import UIKit
import SnapKit

class TickerHeaderView: UITableViewHeaderFooterView {
    
    // MARK: - UI
    let pairLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .black
        label.text = "Pair"
        return label
    }()
    
    let highestLaabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .black
        label.text = "​HighestBid"
        return label
    }()
    
    let lastPrice: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textColor = .black
        label.text = "Last Price"
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Layout
    private func setupLayout() {
        addSubview(pairLabel)
        addSubview(highestLaabel)
        addSubview(lastPrice)
        
        let leftRightMargin = 16
        
        pairLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(leftRightMargin)
            
        }
        
        highestLaabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(lastPrice.snp.leading).offset(-20)
        }
        
        lastPrice.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(50)
            
        }
    }
    
}
