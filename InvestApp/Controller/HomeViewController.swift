//
//  HomeViewController.swift
//  InvestApp
//
//  Created by shm on 2023/11/18.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var stockTableView: UITableView! {
        didSet {
            stockTableView.delegate = self
            stockTableView.dataSource = self
        }
    }
    
    var stockManager = StockManager()
    var stockModelList: [StockModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stockManager.delegate = self
        
        //APIService.requestAccessToken()
        APIService.requestAccount()
        
        stockTableView.register(UINib(nibName: "HomeStockCell", bundle: nil), forCellReuseIdentifier: "reuseCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        stockManager.getStock()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let desVC = segue.destination as? DetailViewController else { return }
        guard let senderStock = sender as? StockModel else { return }
        desVC.stock = senderStock
    }
}

//MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //stockTableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "homeToDetail", sender: stockModelList[indexPath.row])
    }
}

//MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stockModelList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = stockTableView.dequeueReusableCell(withIdentifier: "reuseCell", for: indexPath) as! HomeStockCell
        let myStock = stockModelList[indexPath.row]
        cell.nameLabel.text = myStock.name
        cell.prLabel.text = myStock.prdy_vrss
        cell.ctrtLabel.text = myStock.prdy_ctrt
        
        switch myStock.prdy_vrss_sign {
        case "1", "2": cell.ctrtLabel.textColor = .red
            cell.ctrtSignImage.image = .init(systemName: "arrowtriangle.up.fill")
            cell.ctrtSignImage.tintColor = .red
        case "3": cell.ctrtLabel.textColor = .gray
            cell.ctrtSignImage.tintColor = .gray
        case "4", "5": cell.ctrtLabel.textColor = .blue
                cell.ctrtSignImage.image = .init(systemName: "arrowtriangle.down.fill")
            cell.ctrtSignImage.tintColor = .blue
        default: cell.ctrtLabel.textColor = .red
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

//MARK: - StockManagerDelegate
extension HomeViewController: StockManagerDelegate {
    func update(_ stockManager: StockManager, stockModels: [StockModel]) {
        DispatchQueue.main.async {
            self.stockModelList = stockModels
            //self.stockModelList.sorted(by: self.fun)
            self.stockTableView.reloadData()
        }
    }
}
