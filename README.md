# InvestApp(23/11~진행중)
# 기술스택
1. MVC Design Pattern
1. RestAPI + Alamofire
1. Auto Layout
1. SwiftUI


# 결과
## 1. 홈(진행중)
- 홈
앱 실행시 첫 화면으로 주식 정보(한글명, 주식 현재가, 전일 대비율)을 table로 보여준다.
cell 선택시 해당 주식의 상세정보를 보여준다.
(사진)
- 상세정보
주식 상세정보(한글명, 업종명, 상한가, 하한가, 최저가 등)를 보여준다.
하단의 주문하기 버튼 클릭 시 주식주문 화면으로 이동한다.
(사진)
- 주식주문
어떻게 주문하는지
(사진)


## 2. 즐겨찾기(예정)
1번 홈화면과 동일한데 보여줄 주식 목록이 사용자가 좋아요 누른 주식만 보여준다.


## 3. 현재가(예정)
실시간 주식 정보를 보여준다.


## 4. 주식주문(진행중)
상단 탭바에서 주식주문과 정정및취소 선택
- 주식주문
search bar를 통해 구매하고 싶은 주식 검색 후 구매하고 싶은 주식을 선택하면 주식주문 화면을 보여준다.
이하 1번 홈에서의 주식주문과 동일하다.

- 정정 및 취소
정정 및 취소가 가능한 주식 리스트를 보여준다. 정정 및 취소하고 싶은 주식을 선택하면 정정 및 취소 화면을 보여준다.


## 5. 내정보(진행중)
사용자의 투자계좌자산현황 조회 결과나 실현손익 등을 보여준다.


# 상세 기술
## 1. MVC Design Pattern


## 2. restAPI + Alamofire
1) restAPI request
`
let request = AF.request(url, method: (.post/.get), parameters: myParaters, encoding: (URLEncoding.default/JSONEncoding.default, headers: myHeaders, interceptor: MyRequestInterceptor())

request.response { response in
    //JSON Parsing 후 후처리
}
`
2) JSON Parsing
`
let decoder = JSONDecoder()
do {
    let decodedData = try decoder.decode(DataType.self, from: response.data!)
    //성공시
    delegate?.successAPIRequest(data: decodedData)
    //실패시
    //delegate?.failAPIRequest()
    } catch {
        print("error")
    }
}
`


## 3. AutoLayout


## 4. SwiftUI
SwiftUI로 만든 주식주문 View와 정정및취소 View를 storyboard로 만든 주식주문 ViewController의 Container View에 올려서 tab 화면으로 보여준다.
`
private var viewControllers: [UIViewController] = []
let firstVC = UIHostingController(rootView: OrderCashTabView())
let secondVC = UIHostingController(rootView: RvsecnclTabView())

viewControllers.append(firstVC)
viewControllers.append(secondVC)
`
상단 tab은 tab man library를 이용하였다. ViewController class에 PageboyViewControllerDataSource, TMBarDataSource를 상속받는다.
`
func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
    return viewControllers.count
}

func viewController(for pageboyViewController: PageboyViewController,
                        at index: PageboyViewController.PageIndex) -> UIViewController? {
    return viewControllers[index]
}

func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
    return nil
}

func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
    let title = titles[index]
    return TMBarItem(title: title)
}
`


# 문제점
## 1. Access token 만료
1) Interceptor
1-1) adapt에서 처리
만약 access token이 없거나(앱 처음 실행) 만료날짜가 현재날짜보다 빠르면 access token을 request하는 호출한다.
`
//access token의 만료날짜(String)와 현재날짜 비교
//만료날짜 < 현재날짜
//access token 업데이트
//header에 새 access token 붙이기
let api = APIService()
    
if K.access_token == "" {
    api.requestAccessToken()
}
else {
    //String > Date
    let empireString = K.empire_date
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    if let empireDate = dateFormatter.date(from: empireString) {
        //현재날짜와 만료날짜 비교
        if Date() > empireDate {
            api.requestAccessToken()
        }
    }
}
`
Header에 access token을 추가하여 request한다.
`
var urlRequestAdd = urlRequest
urlRequestAdd.headers.add(.authorization(bearerToken: K.access_token))
completion(.success(urlRequestAdd))
`
1-2) 문제점
만약 access token을 요청해야하면 보여줄 주식 리스트에 있는 주식의 수 만큼 access token 요청하게 된다.
1-3) retry에서 처리해야할 것 같다.


## 2. custom keyboard
주식주문 화면의 textField에 custom keyboard를 연결했는데 custom keyboard 상위 View의 크기가 device에 따라서 custom keyboard보다 작을 때도 있고 클 때도 있다.
- view가 키보드보다 작음> 키보드 안 눌림
- view가 키보드보다 큼 > textfield나 다른 text를 가려버림
1) view의 opacity
view의 크기를 아예 크게 하고 opacity를 0으로 줘서 투명하게 한다.
1-1) 문제점
근본적 해결이 아닐 뿐더러 view가 textfield를 가려버리면 textfield 터치가 안된다.
2) view의 크기를 조절해야할 것 같다.
근본적으로 view가 custom keyboard랑 똑같은 사이즈가 됐음 좋겠음


## 3. 주식정보 관리
주식 정보를 firestore에서 관리하는 게 나을까?


## 4. 주식 모델 리스트 중복추가
1) dictionary로 주식 모델을 저장
tableView reload 시 주식 리스트에 계속 주식 모델이 중복 추가된다.


## 5. 홈
1) 주식 리스트 어떻게 정렬할지
1) 로드 안 될 때 무슨 화면 보여줄지
1) 디테일 화면에서 단기과열여부나 시장경고코드 어떻게 보여줄지


# 예정
1. SwiftUI(진행중)
1. csv file(진행중)
1. Chart(예정)
1. FCM(예정)
1. Web socket(예정)
1. key 숨기기(예정)
