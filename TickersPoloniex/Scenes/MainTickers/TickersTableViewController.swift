//
//  TickersTableViewController.swift
//  TickersPoloniex
//
//  Created by msc on 08.03.2021.
//

import UIKit
import SnapKit

protocol TickersDisplayLogic: class {
    func display(data: [TickerViewModel])
    func showError()
    
}

 class TickersTableViewController: UITableViewController {
    
    //MARK: - Internal var
    var interactor: TickersBusinessLogic?
    private var dataToDisplay = [TickerViewModel]()
 
    
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
    
        init() {
        super.init(nibName: nil, bundle: nil)
           
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        interactor?.fetchTickers()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Tickers"
        
        tableView.register(TickerCell.self, forCellReuseIdentifier: cellID)
        tableView.register(TickerHeaderView.self, forHeaderFooterViewReuseIdentifier: headerId)
        
        updateInfo()
        setupLayout()
        tableView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        tableView.tableFooterView = UIView()
    }
    
    
    //MARK: - Methods
    
    func setupLayout() {
        
        tableView.addSubview(activityIndicator)
        tableView.addSubview(errorLabel)
        tableView.addSubview(reloadButton)
        
        errorLabel.isHidden = true
        reloadButton.isHidden = true
        activityIndicator.startAnimating()
        
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
        timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(loadData), userInfo: nil, repeats: true)
    }
    
  
    @objc func loadData() {
        interactor?.fetchTickers()
        tableView.reloadData()
    }
    
    
    // MARK: - Table view data source & delegate
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerId) as? TickerHeaderView {
            if dataToDisplay.isEmpty {
            cell.isHidden = true
            } else {
                cell.isHidden = false
            }
            return cell
        }
        return UIView()
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataToDisplay.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? TickerCell {
            let ticker = dataToDisplay[indexPath.row]
            cell.refresh(ticker)
            cell.selectionStyle = .none
            
            return cell
        }
        return UITableViewCell()
    }
    
}

extension TickersTableViewController: TickersDisplayLogic {
    
    func display(data: [TickerViewModel]) {
        activityIndicator.stopAnimating()
        errorLabel.isHidden = true
        reloadButton.isHidden = true
        dataToDisplay =  data
        tableView.reloadData()
    }
    
    func showError(){
        activityIndicator.stopAnimating()
        errorLabel.isHidden = false
        reloadButton.isHidden = false
    }
    
}
