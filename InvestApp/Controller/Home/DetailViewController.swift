//
//  DetailViewController.swift
//  InvestApp
//
//  Created by shm on 2023/11/19.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var stockNameLabel: UILabel!
    @IBOutlet weak var isnmLabel: UILabel!
    @IBOutlet weak var prprLabel: UILabel!
    @IBOutlet weak var vrssSignImage: UIImageView!
    @IBOutlet weak var vrssLabel: UILabel!
    @IBOutlet weak var ctrtLabel: UILabel!
    @IBOutlet weak var acmlTrPbmnLabel: UILabel!
    @IBOutlet weak var acmlVolLabel: UILabel!
    @IBOutlet weak var vrssVolRateLabel: UILabel!
    @IBOutlet weak var llamLabel: UILabel!
    @IBOutlet weak var mxprLabel: UILabel!
    @IBOutlet weak var oprcLabel: UILabel!
    @IBOutlet weak var sdprLabel: UILabel!
    @IBOutlet weak var lwprLabel: UILabel!
    @IBOutlet weak var hgprLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBOutlet weak var vrssLabel2: UILabel!
    @IBOutlet weak var ctrtLabel2: UILabel!
    
    
    var stock: StockModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        drawView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    //MARK: - Navigation Prepare
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        guard let desVC = segue.destination as? DetailViewController else { return }
//        guard let senderStock = sender as? StockModel else { return }
//        desVC.stock = senderStock
        if let desVC = segue.destination as? OrderCashViewController {
            //self.tabBarController?.tabBar.isHidden = true
            desVC.stock = stock
            return
        }
        return
    }
}


//MARK: - DrawView
extension DetailViewController {
    func drawView() {
        self.navigationItem.title = stock?.name
        
        stockNameLabel.text = stock?.name
        isnmLabel.text = stock?.bstp_isnm
        prprLabel.text = stock?.prprDeci
        vrssLabel.text = stock?.vrssAbs
        //vrssSignImage
        ctrtLabel.text = stock?.prdy_ctrt
        //acmlTrPbmnLabel.text =
        acmlVolLabel.text = stock?.acml_vol
        vrssVolRateLabel.text = stock?.prdy_vrss_vol_rate
        llamLabel.text = stock?.llam
        mxprLabel.text = stock?.mxpr
        oprcLabel.text = stock?.oprc
        sdprLabel.text = stock?.sdpr
        lwprLabel.text = stock?.lwpr
        hgprLabel.text = stock?.hgpr
        
        switch stock?.prdy_vrss_sign {
        case "1", "2": vrssSignImage.image = .init(systemName: "arrowtriangle.up.fill")
            vrssSignImage.tintColor = .red
            vrssLabel.textColor = .red
            ctrtLabel.textColor = .red
            vrssLabel2.textColor = .red
            ctrtLabel2.textColor = .red
        case "3": vrssSignImage.image = .init(systemName: "minus")
            vrssSignImage.tintColor = .gray
            vrssLabel.textColor = .gray
            ctrtLabel.textColor = .gray
            vrssLabel2.textColor = .gray
            ctrtLabel2.textColor = .gray
        case "4", "5": vrssSignImage.image = .init(systemName: "arrowtriangle.down.fill")
            vrssSignImage.tintColor = .blue
            vrssLabel.textColor = .blue
            ctrtLabel.textColor = .blue
            vrssLabel2.textColor = .blue
            ctrtLabel2.textColor = .blue
        default: vrssSignImage.tintColor = .black
        }
        
        var pr: Float {
            guard let oprc = Float(oprcLabel.text!) else { return 0.0 }
            guard let lwpr = Float(lwprLabel.text!) else { return 0.0 }
            guard let hgpr = Float(hgprLabel.text!) else { return 0.0 }
            return (oprc - lwpr) / (hgpr - lwpr)
        }
        progressBar.progress = pr
    }
}
