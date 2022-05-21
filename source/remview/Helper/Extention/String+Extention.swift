import Foundation
import UIKit
import Resolver

extension String {
    
    var localized: String {
        // return NSLocalizedString(self, comment: "")

        let language = "en"
        guard
            let path = Bundle.main.path(forResource: language, ofType: "lproj"),
            let bundle = Bundle(path: path)
        else {
            return NSLocalizedString(self, comment: "")
        }
        return NSLocalizedString(self, tableName: "", bundle: bundle, value: "", comment: "")
    }
    
    func localized(bundle: Bundle?) -> String {
        guard let bundleLang = bundle else {
            return NSLocalizedString(self, comment: "")
        }
        return NSLocalizedString(self, tableName: "", bundle: bundleLang, value: "", comment: "")
    }
    
    func strikeThrough() -> NSAttributedString {
        let attributeString =  NSMutableAttributedString(string: self)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0,attributeString.length))
        return attributeString
    }
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    
    func convertToDate(dateFormat: String = "dd/MM/yyyy HH:mm:ss") -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        dateFormatter.calendar = Calendar(identifier: .iso8601)
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        return dateFormatter.date(from: self)!
    }
    
    var htmlToAttributedString: NSAttributedString? {
            guard let data = data(using: .utf8) else { return nil }
            do {
                return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
            } catch {
                return nil
            }
        }
        var htmlToString: String {
            return htmlToAttributedString?.string ?? ""
        }
    
    /// MARK: VALIDATION
    /// REF:
    ///     + https://www.advancedswift.com/regular-expressions/
    
    func isPhoneNumber() -> Bool {
        let phonePattern  = #"[0-9]+"#
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phonePattern)
        return phoneTest.evaluate(with: self) && self.count >= 10
    }
    func isEmail()-> Bool {
        let phonePattern  = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phonePattern)
        return phoneTest.evaluate(with: self)
    }
    func isOtp() -> Bool {
        let phonePattern  = #"[0-9]+"#
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phonePattern)
        return phoneTest.evaluate(with: self) && self.count == 6
    }
    
    func isValidPassword() -> Bool {
        return self.count >= 8;
    }
    
    func fromBase64() -> String? {
            guard let data = Data(base64Encoded: self) else {
                return nil
            }

            return String(data: data, encoding: .utf8)
        }

        func toBase64() -> String {
            return Data(self.utf8).base64EncodedString()
        }

    func restaurantStringToDouble(setting:RestaurantSetting)->Double{
        let des = self.replacingOccurrences(of: setting.numberGroup!, with: "")
            .replacingOccurrences(of: setting.numberDecimal!, with: ".")
            .replacingOccurrences(of: "%", with: "")
            .replacingOccurrences(of: setting.currency!, with: "")
            .replacingOccurrences(of: " ", with: "")
        return Double(des)!
    }
}
