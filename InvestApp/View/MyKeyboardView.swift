//
//  MyKeyboardView.swift
//  InvestApp
//
//  Created by shm on 2023/11/27.
//

import UIKit

protocol MyKeyboardDelegate {
    func keyboardTapped(str: String)
    func nextButtonTapped()
}

class MyKeyboardView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        //setup
    }
    
    var delegate: MyKeyboardDelegate?
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        if let title = sender.titleLabel?.text {
            if title == "다음" {
                delegate?.nextButtonTapped()
                return
            }
            if title == "◀" {
                delegate?.keyboardTapped(str: "-1")
                return
            }
            delegate?.keyboardTapped(str: title)
        }
    }
}
