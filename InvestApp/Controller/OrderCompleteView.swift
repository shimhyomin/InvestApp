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
            Text("삼성전자")
            Text("주문번호")
            Text("주문시간")
            Text("주문금액")
            Text(name)
            Button {
                //todo
            } label: {
                Text("주문완료")
                    .tint(.white)
            }
            .background(.blue)

        }
        .padding()

    }
}

struct OrderCompleteViewPreview: PreviewProvider {
    static var previews: some View {
        OrderCompleteView()
    }
}
