import Foundation

enum WindPresenter {
    static func props(from d: WindDetails,
                      unit: UnitSpeed,
                      locale: Locale = .current) -> WindProps {
        let windText = SpeedFormatter.text(mps: d.windSpeedMps, to: unit, locale: locale)
        let gustText = SpeedFormatter.text(mps: d.gustSpeedMps, to: unit, locale: locale)

        let deg = CardinalFormatter.normalizedDegrees(d.directionDegrees)
        let dirText = "\(Int(deg.rounded()))° \(CardinalFormatter.abbreviation(for: deg))"

        let windForCompass = SpeedFormatter.measurement(mps: d.windSpeedMps, to: unit)

        return WindProps(
            windText: windText,
            gustText: gustText,
            directionText: dirText,
            directionDegrees: deg,
            windForCompass: windForCompass
        )
    }
}