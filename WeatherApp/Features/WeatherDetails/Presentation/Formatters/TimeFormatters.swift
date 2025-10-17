import SwiftUI

enum TimeFormatters {
    /// Короткий час з урахуванням locale + calendar (і його timeZone).
    static func shortTime(calendar: Calendar, locale: Locale) -> DateFormatter {
        let f = DateFormatter()
        f.locale = locale
        f.calendar = calendar
        f.timeZone = calendar.timeZone
        f.dateStyle = .none
        f.timeStyle = .short
        return f
    }
}