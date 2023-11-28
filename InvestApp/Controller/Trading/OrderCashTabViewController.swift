//
//  FirstViewController.swift
//  InvestApp
//
//  Created by shm on 2023/11/25.
//

import UIKit
import SwiftUI

class OrderCashTabViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // 버튼 생성
        let button = UIButton(type: .system)
        let textField = UITextField()
        
        // 버튼 위치 지정 및 크기 설정
        button.frame = CGRect(x: 100, y: 100, width: 100, height: 50)
        textField.frame = CGRect(x: 150, y: 150, width: 800, height: 50)
        textField.placeholder = "입력하세요"
        textField.backgroundColor = .systemGray6
        
        
        // 버튼 타이틀 설정
        button.setTitle("버튼", for: .normal)
        
        // 버튼 액션 추가
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        // 뷰에 버튼 추가
        view.addSubview(button)
        view.addSubview(textField)
        
    }
    
    @objc func buttonAction(sender: UIButton!) {
        print("버튼이 클릭되었습니다.")
    }
}

//MARK: - SwiftUI로 Storyboard 불러오기
struct TemplateView: View{
    @State private var name: String = ""
    
    var body: some View {
        VStack {
            Button(action: {
                apiSearchRoom()   // 입장 버튼을 눌렀을 경우 수행되는 함수
            }, label: {
                Text("WHEET Core API 호출 기능")
            })
                .frame(width: 350, height: 20)
                .foregroundColor(Color.white)
                .padding()
                .background(Color("#243062"))
                .cornerRadius(10)
            
            //해당 부분에서 UIKit을 불러옵니다.
            NavigationLink(destination: ScreenShareView()) {
                Text("UIKit 화면 불러오기")
            }
        }.padding()
    }
}

func apiSearchRoom() {
    //todo
    print("Pressed Button")
}

struct ScreenShareView : UIViewControllerRepresentable {
    
    typealias UIViewControllerType = OrderCashTabViewController
    
    //UIViewController를 생성합니다.
    func makeUIViewController(context: Context) -> UIViewControllerType {
        return OrderCashTabViewController()      //OrderCashTabViewController의 UIViewController를 호출합니다.
    }
    
    //UIViewController를 변경하였을때 수행합니다.
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        //
    }
}
