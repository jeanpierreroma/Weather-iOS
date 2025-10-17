import SwiftUI

enum HumidityPresenter {
    private static func dewPointC(tempC: Double, rhPct: Int) -> Double {
        let a = 17.27, b = 237.7
        let rh = max(0.0, min(100.0, Double(rhPct))) / 100.0
        let gamma = (a * tempC / (b + tempC)) + log(rh)
        return (b * gamma) / (a - gamma)
    }

    static func props(
        humidityPct: Int,
        temperatureC: Double? = nil,
        tempUnit: TemperatureDisplayUnit = .celsius
    ) -> HumidityProps {
        let clamped = max(0, min(100, humidityPct))
        let valueText = "\(clamped)%"

        let summaryText: String = {
            guard let tC = temperatureC else {
                return "Humidity level right now."
            }
            let dpC = dewPointC(tempC: tC, rhPct: clamped)
            let dpRounded = Int((dpC).rounded())
            let dpText = TemperatureFormatter.format(celsius: dpRounded, to: tempUnit)
            return "Dew point is \(dpText) right now."
        }()

        return HumidityProps(valueText: valueText, summaryText: summaryText)
    }
}