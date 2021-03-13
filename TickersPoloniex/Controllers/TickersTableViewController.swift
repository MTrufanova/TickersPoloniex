//
//  TickersTableViewController.swift
//  TickersPoloniex
//
//  Created by msc on 08.03.2021.
//

import UIKit
import SnapKit

final class TickersTableViewController: UITableViewController {
    
    var tickers = [TickersModel]()
    
    let api: APIClient = APIClientclass()
    let cellID = "cellID"
    let headerId = "head"
    
    let activityIndicator = UIActivityIndicatorView()
    
    var timer: Timer?
    
    
    let reloadButton: UIButton = {
        let button = UIButton()
        button.setTitle("Reload", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(loadData), for: .touchUpInside)
        return button
    }()
    
    let errorLabel: UILabel = {
        let label = UILabel()
        label.text = "Something went wrong. Please try again."
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.textColor = .darkGray
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Tickers"
        
        tableView.register(TickerCell.self, forCellReuseIdentifier: cellID)
        tableView.register(TickerHeaderView.self, forHeaderFooterViewReuseIdentifier: headerId)
        
        loadData()
        updateInfo()
        setupLayout()
    }
    
    //MARK: - Methods
    func setupLayout() {
        
        tableView.addSubview(activityIndicator)
        tableView.addSubview(errorLabel)
        tableView.addSubview(reloadButton)
        
        activityIndicator.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
        errorLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(200)
        }
        reloadButton.snp.makeConstraints { (make) in
            make.top.equalTo(errorLabel.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalTo(150)
        }
    }
    
    func updateInfo() {
        timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(loadWithoutIndicator), userInfo: nil, repeats: true)
    }
    
    func loadingData() {
        activityIndicator.startAnimating()
        errorLabel.isHidden = true
        reloadButton.isHidden = true
        tableView.separatorStyle = .none
    }
    func showError() {
        activityIndicator.stopAnimating()
        errorLabel.isHidden = false
        reloadButton.isHidden = false
    }
    
    func showData()  {
        activityIndicator.stopAnimating()
        errorLabel.isHidden = true
        reloadButton.isHidden = true
        tableView.separatorStyle = .singleLine
    }
    
    @objc func loadWithoutIndicator() {
        api.fetchData(onResult: { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let ticker):
                    for (_, _) in ticker {
                        self.tickers = ticker.map(TickersModel.init).sorted(by: {$0.namePair < $1.namePair})
                        self.tableView.reloadData()
                        self.showData()
                    }
                    
                case .failure(_):
                    self.tickers = []
                    self.tableView.reloadData()
                    self.showError()
                    
                }
                
            }
        })
    }
    @objc func loadData() {
        loadingData()
        loadWithoutIndicator()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerId) as? TickerHeaderView {
            return cell
        }
        return UIView()
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tickers.count
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? TickerCell {
            let ticker = tickers[indexPath.row]
            cell.refresh(ticker)
            cell.selectionStyle = .none
            
            return cell
        }
        
        return UITableViewCell()
        
    }
    
}
