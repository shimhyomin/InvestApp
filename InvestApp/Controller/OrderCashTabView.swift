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
