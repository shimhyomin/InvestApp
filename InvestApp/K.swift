
import Foundation

struct K {
//    static let appkey = "(app key)"
//    static let secretkey = "(secret key)"
//    static let access_token = "(access token)"
//    static var empire_date = "(yyyy-mm-dd HH:mm:ss)"
//    static let account = "(account)"
    

}

struct m{
    static func deciFormatter(value n: Int) -> String {
        //천단위 끊기
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        if let resultString = numberFormatter.string(from: NSNumber(value: n)) {
            return resultString
        }
        return "0"
    }
}
