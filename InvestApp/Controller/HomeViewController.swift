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
    
    var stockList: [String: String] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.tabBarItem.title이 왜 nill일까?
        self.navigationItem.title = self.tabBarItem.title ?? "홈"
        
        stockManager.delegate = self
        
        //APIService.requestAccessToken()
        //APIService.requestAccount()
        //loadLocationsFromCSV()
        
        stockTableView.register(UINib(nibName: "HomeStockCell", bundle: nil), forCellReuseIdentifier: "reuseCell")
    }
    
    private func parseCSV(url: URL) {
        do {
            let data = try Data(contentsOf: url)
            let dataEncoded = String(data: data, encoding: .utf8)
            if let dataArr = dataEncoded?.components(separatedBy: "\n").map({$0.components(separatedBy: ",")}) {
                for _ in dataArr {
                    //stockList[item[0]] = item[1]
                    print("dataArr: \(dataArr)")
                }
            } else { print("Error dataEncoding") }
            
        } catch  {
            print("Error reading CSV file: \(error)")
        }
    }
    
    private func loadLocationsFromCSV() {
        if let path = Bundle.main.path(forResource: "location", ofType: "csv") {
            parseCSV(url: URL(fileURLWithPath: path))
            print(stockList)
        } else {
            print("Error to loadLocationsFromCSV")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        stockManager.getStock()
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
        cell.prLabel.text = myStock.prprDeci
        cell.ctrtLabel.text = myStock.ctrtAbs
        
        switch myStock.prdy_vrss_sign {
        case "1", "2": cell.ctrtLabel.textColor = .red
            cell.ctrtSignImage.image = .init(systemName: "arrowtriangle.up.fill")
            cell.ctrtSignImage.tintColor = .red
        case "3": cell.ctrtLabel.textColor = .gray
            cell.ctrtSignImage.image = .init(systemName: "minus")
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
