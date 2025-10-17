enum FeelsLikePresenter {
    static func props(from details: FeelsLikeDetails, unit: TemperatureDisplayUnit) -> FeelsLikeProps {
        .init(
            temperatureText: TemperatureFormatter.format(celsius: details.temperature, to: unit),
            summary: details.summary
        )
    }
}