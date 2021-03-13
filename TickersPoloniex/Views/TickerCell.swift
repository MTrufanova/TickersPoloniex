//
//  TickerCell.swift
//  TickersPoloniex
//
//  Created by msc on 10.03.2021.
//

import UIKit
import SnapKit

class TickerCell: UITableViewCell {
    
    // MARK: -UI Cell
    let pairLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 15)
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    
    let highestBidLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        label.font = .systemFont(ofSize: 14)
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    
    let lastLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        label.font = .systemFont(ofSize: 14)
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    
    let percentLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    // MARK: - Methods
    func refresh(_ model:TickersModel) {
        pairLabel.text = model.namePair.split(separator: "_").joined(separator: "/")
        highestBidLabel.text = model.tickerInfo.highestBid
        lastLabel.text = model.tickerInfo.last
        let percent = Float(model.tickerInfo.percentChange) ?? 0
        percent >= 0 ? (percentLabel.textColor = .green) : (percentLabel.textColor = .red)
        percentLabel.text = String(format: "%.2f", (percent * 100)) + "%"
    }
    
    
    // MARK: - Layout
    private func setupLayout() {
        addSubview(pairLabel)
        addSubview(highestBidLabel)
        addSubview(lastLabel)
        addSubview(percentLabel)
        
        pairLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
        }
        
        highestBidLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.width.equalTo(100)
            make.trailing.equalTo(lastLabel.snp.leading).offset(-8)
        }
        
        lastLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.width.equalTo(100)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        percentLabel.snp.makeConstraints { (make) in
            make.top.equalTo(lastLabel.snp.bottom)
            make.trailing.equalToSuperview().offset(-16)
        }
    }
    
}
