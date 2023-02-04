//
//  Extension + Date.swift
//  PayBack
//
//  Created by Nato Egnatashvili on 02.02.23.
//

import Foundation

extension Date.month {
    var prettyName: String {
        switch self {
        case .Jan : return "January"
        case .Feb : return "February"
        case .Mar : return "March"
        case .Apr : return "April"
        case .May : return "May"
        case .Jun : return "June"
        case .Jul : return "July"
        case .Aug : return "August"
        case .Sep : return "September"
        case .Oct : return "Octomber"
        case .Nov : return "November"
        case .Dec : return "December"
        }
    }
}

extension Date.WeekDay {
    public var prettyName: String {
        switch self {
        case .Mon : return "Mon"
        case .Tue : return "Tue"
        case .Wed : return "Wed"
        case .Thu : return "Thu"
        case .Fri : return "Fri"
        case .Sat : return "Sat"
        case .Sun : return "Sun"
        }
    }
}

extension Date {
    public enum WeekDay: Int {
        case Mon = 1
        case Tue
        case Wed
        case Thu
        case Fri
        case Sat
        case Sun
    }
    
    enum month: Int {
        case Jan = 1
        case Feb
        case Mar
        case Apr
        case May
        case Jun
        case Jul
        case Aug
        case Sep
        case Oct
        case Nov
        case Dec
    }
    
    public var yearMonthAndDayNums: String {
        let day = "-" + (String(self.day).count < 2 ? ("0\(String(self.day))") : String(self.day) )
        let month = "-" + (String(self.month).count < 2 ? ("0\(String(self.month))") : String(self.month) )
        return String(self.year) + month + day
    }
    
    public var yearMonthDayHourAndMinute: String {
        let hour = (String(self.hour).count < 2 ? ("0\(String(self.hour))") : String(self.hour) ) + ":"
        let minute = (String(self.minute).count < 2 ? ("0\(String(self.minute))") : String(self.minute) ) + " - "
        let day = String(self.day) + " "
        let month = Date.month.init(rawValue: self.month)!.prettyName + " / "
        return hour + minute + day +  month + String(self.year)
    }
    
    public var yearMonthAndDay: String {
        let day = String(self.day) + " "
        let month = Date.month.init(rawValue: self.month)!.prettyName + " / "
        return day +  month + String(self.year)
    }
    
    /// RDExtensionsSwift: Return date day
    var day : Int { return (Calendar.current as NSCalendar).components(NSCalendar.Unit.day, from: self).day! }
    
    /// RDExtensionsSwift: Return date week day
    public var weekDay : Int { return (Calendar.current as NSCalendar).components(NSCalendar.Unit.weekday, from: self).weekday! }
    
    /// RDExtensionsSwift: Return date ordinal week day
    var weekdayOrdinal : Int { return (Calendar.current as NSCalendar).components(NSCalendar.Unit.weekdayOrdinal, from: self).weekdayOrdinal! }
    
    var hour : Int {
        let calendar = (Calendar.current as NSCalendar)
        calendar.timeZone = TimeZone(abbreviation: "GMT")!
        return calendar.component(.hour, from: self)
        
    }
    
    var minute : Int { return (Calendar.current as NSCalendar).components(NSCalendar.Unit.minute, from: self).minute! }
    /// RDExtensionsSwift: Return date month
    var month : Int { return (Calendar.current as NSCalendar).components(NSCalendar.Unit.month, from: self).month! }
    
    /// RDExtensionsSwift: Return date year
    var year : Int { return (Calendar.current as NSCalendar).components(NSCalendar.Unit.year, from: self).year! }
}

extension Date {
    public static var yesterday: Date { return Date().dayBefore }
    public static var tomorrow:  Date { return Date().dayAfter }
    public var dayBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: noon)!
    }
    public var dayAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: noon)!
    }
    var noon: Date {
        return Calendar.current.date(bySettingHour: 23, minute: 59, second: 0, of: self)!
    }
}

extension String {
    public func toDate() -> Date?{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return dateFormatter.date(from: self)?.toLocalTime()
    }
    
    public func toDateWithoutZ() -> Date?{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return dateFormatter.date(from: self)?.toLocalTime()
    }
    
    public func dateWithSSOrZ() -> Date? {
        return toDate() ?? toDateWithoutZ()
    }
}

extension Date {

    // Convert local time to UTC (or GMT)
    func toGlobalTime() -> Date {
        let timezone = TimeZone.current
        let seconds = -TimeInterval(timezone.secondsFromGMT(for: self))
        return Date(timeInterval: seconds, since: self)
    }

    // Convert UTC (or GMT) to local time
    func toLocalTime() -> Date {
        let timezone = TimeZone.current
        let seconds = TimeInterval(timezone.secondsFromGMT(for: self))
        return Date(timeInterval: seconds, since: self)
    }

}
