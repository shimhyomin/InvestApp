//
//  OrderCompleteViewController.swift
//  InvestApp
//
//  Created by shm on 2023/11/26.
//

import SwiftUI

struct OrderCompleteView: View {
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

struct OrderCompleteViewPreview: PreviewProvider {
    static var previews: some View {
        OrderCompleteView()
    }
}
