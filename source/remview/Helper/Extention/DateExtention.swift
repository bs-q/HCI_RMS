import Foundation


extension Date {
    func convertUTCToGMTTime(date: Date,utc: String) -> Date {
        let calendar = NSCalendar.current
        if utc.contains("+") {
            let timeAdd = utc.replacingOccurrences(of: "+", with: "")
            let arrTime = timeAdd.components(separatedBy: ":")
            let hour = arrTime.first ?? "0"
            let minutes = arrTime.last ?? "0"
            var fromDate = calendar.date(byAdding: .hour,value: Int(hour) ?? 0 , to: date)
            fromDate = calendar.date(byAdding: .minute,value: Int(minutes) ?? 0 , to: fromDate ?? Date())
            return fromDate ?? Date()
        } else if utc.contains("-") {
            let timeAdd = utc.replacingOccurrences(of: "+", with: "")
            let arrTime = timeAdd.components(separatedBy: ":")
            let hour = Int(arrTime.first ?? "0") ?? 0
            let minutes = Int(arrTime.last ?? "0") ?? 0
            var fromDate = calendar.date(byAdding: .hour,value: -hour , to: date)
            fromDate = calendar.date(byAdding: .minute,value: -minutes , to: fromDate ?? Date())
            return fromDate ?? Date()
        }
        else { return date }
    }
    func convertToUTCTime(date: String) -> Date {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.date(from: date) ?? Date()
    }
    func currentUTCTimeZoneDate() -> Date {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let stringDate =  formatter.string(from: self)
        return formatter.date(from: stringDate) ?? Date()
    }
    func convertDateToString(format: String,locale : Bool = false) -> String { // locale flag for utc time zone
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        if locale { formatter.timeZone = TimeZone(abbreviation: "UTC")}
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    func currentTimeMillis() -> Double {
        return self.timeIntervalSince1970 * 1000.0
    }
    
    func fromMimisecond(time: Double!) -> Date {
        return Date(timeIntervalSince1970: time/1000.0)
    }
    static func -(recent: Date, previous: Date) -> (month: Int?, day: Int?, hour: Int?, minute: Int?, second: Int?) {
            let day = Calendar.current.dateComponents([.day], from: previous, to: recent).day
            let month = Calendar.current.dateComponents([.month], from: previous, to: recent).month
            let hour = Calendar.current.dateComponents([.hour], from: previous, to: recent).hour
            let minute = Calendar.current.dateComponents([.minute], from: previous, to: recent).minute
            let second = Calendar.current.dateComponents([.second], from: previous, to: recent).second

            return (month: month, day: day, hour: hour, minute: minute, second: second)
        }
}
