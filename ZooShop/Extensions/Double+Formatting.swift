import Foundation

extension Double {
    /// Formats with up to one fractional digit, rounding to the nearest tenth.
    func formattedOneDecimal(locale: Locale = .current) -> String {
        let formatter = NumberFormatter()
        formatter.locale = locale
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 1
        formatter.roundingMode = .halfUp

        return formatter.string(from: NSNumber(value: self)) ?? String(self)
    }

    /// Formats with two fractional digits, rounding toward positive infinity.
    func formattedRoundedUp(locale: Locale = .current) -> String {
        let formatter = NumberFormatter()
        formatter.locale = locale
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        formatter.roundingMode = .ceiling

        return formatter.string(from: NSNumber(value: self)) ?? String(self)
    }

    /// The currency code identifies the currency; the locale controls its presentation.
    func formattedCurrency(code: String, locale: Locale = .current) -> String {
        let formatter = NumberFormatter()
        formatter.locale = locale
        formatter.numberStyle = .currency
        formatter.currencyCode = code
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        formatter.roundingMode = .ceiling

        return formatter.string(from: NSNumber(value: self)) ?? String(self)
    }
}
