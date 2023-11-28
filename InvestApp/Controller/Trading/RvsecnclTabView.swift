//
//  RvsecnclTabView.swift
//  InvestApp
//
//  Created by shm on 2023/11/26.
//

import SwiftUI

struct RvsecnclTabView: View {
    @State var name: String = ""
    
    var body: some View {
        VStack{
            HStack{
                Image(systemName: "magnifyingglass")
                TextField("입력", text: $name)
                    .padding()
                    .background(Color(uiColor: .secondarySystemBackground))
            }
            
            List {
                Text("1")
                Text("2")
            }
        }
    }
}

struct RvsecnclTabViewPreview: PreviewProvider {
    static var previews: some View {
        RvsecnclTabView()
    }
}

