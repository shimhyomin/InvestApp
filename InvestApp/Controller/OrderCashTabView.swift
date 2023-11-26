//
//  OrderCashTabView.swift
//  InvestApp
//
//  Created by shm on 2023/11/26.
//

import SwiftUI

struct OrderCashTabView: View {
    @State var name: String = ""
      
      var body: some View {
        VStack {
          TextField("Enter your name", text: $name)
            .padding()
            .background(Color(uiColor: .secondarySystemBackground))
          
          Text("Hello \(name)")
        }
      }
}

struct OrderCashTabViewPreviews: PreviewProvider {
    static var previews: some View {
        OrderCashTabView()
    }
}

//MARK: - 주문넣기
/*
 //nil일 때 처리해주기!!!
 if let qty = qtyTextField.text, let unpr = unprTextField.text {
     tradingManager.requestOrderCash(tr_int: 0, pdno: "051910", qty: qty, unpr: unpr)
 }
 */
