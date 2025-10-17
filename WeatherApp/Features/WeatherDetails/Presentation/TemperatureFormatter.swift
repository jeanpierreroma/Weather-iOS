enum TemperatureFormatter {
    static func format(celsius: Int, to unit: TemperatureDisplayUnit) -> String {
        let value: Int = switch unit {
        case .celsius: celsius
        case .fahrenheit: Int((Double(celsius) * 9.0/5.0 + 32.0).rounded())
        }
        return "\(value)°\(unit.suffix)"
    }
}