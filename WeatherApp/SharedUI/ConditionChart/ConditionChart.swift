//
//  UvIndexChart.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 28.10.2025.
//


import SwiftUI
import Charts

struct ConditionChart: View {
    @Environment(\.calendar) private var calendar

    let day: Date
    let points: [MetricPoint]
    let bands: [ChartBand]
    
    var yDomain: ClosedRange<Double>
    var yGridStep: Double = 1
    var maskBaseline: Double = -0.1
    
    var body: some View {
        Chart {
            ForEach(bands) { band in
                RectangleMark(
                    xStart: .value("from", startOfDay),
                    xEnd:   .value("to",   endOfDay),
                    yStart: .value("y0", band.range.lowerBound),
                    yEnd:   .value("y1", band.range.upperBound)
                )
                .foregroundStyle(band.color.opacity(0.22))
            }
            .mask {
                ForEach(edgeExtendedPoints) { p in
                    AreaMark(
                        x: .value("t", p.date),
                        yStart: .value("y0", maskBaseline),
                        yEnd: .value("y1", p.value)
                    )
                    .interpolationMethod(.monotone)
                }
            }
            
            ForEach(bands) { band in
                RectangleMark(
                    xStart: .value("from", startOfDay),
                    xEnd:   .value("to",   endOfDay),
                    yStart: .value("y0", band.range.lowerBound + maskBaseline),
                    yEnd:   .value("y1", band.range.upperBound)
                )
                .foregroundStyle(band.color)
            }
            .mask {
                ForEach(edgeExtendedPoints) { p in
                    LineMark(
                        x: .value("t", p.date),
                        y: .value("val", p.value)
                    )
                    .interpolationMethod(.monotone)
                    .lineStyle(.init(lineWidth: 4))
                }
            }
            
            if calendar.isDate(day, inSameDayAs: Date()) {
                RuleMark(x: .value("Now", Date()))
                    .lineStyle(.init(lineWidth: 1))
                    .foregroundStyle(.secondary)
            }
        }
        .chartYScale(domain: yDomain)
        .chartXScale(domain: startOfDay...endOfDay)
        .chartXAxis {
            AxisMarks(position: .top, values: hourTicks) { v in
                AxisValueLabel {
                    if let d = v.as(Date.self), let val = valueByHour[d] {
                        Text("\(Int(round(val)))")
                            .font(.caption2.weight(.semibold))
                            .foregroundStyle(.secondary)
                    }
                }
            }
            
            AxisMarks(position: .bottom, values: .stride(by: .hour, count: 6)) { v in
                AxisGridLine()
                AxisValueLabel {
                    if let d = v.as(Date.self) {
                        Text(d, format: .dateTime.hour(.twoDigits(amPM: .omitted)))
                    }
                }
            }
        }
        .chartYAxis {
            AxisMarks(position: .trailing, values: yGridValues) { val in
                AxisGridLine()
                AxisValueLabel {
                    if let y = val.as(Double.self) {
                        Text("\(Int(y))")
                    }
                }
            }
        }
    }
    
    private var startOfDay: Date { calendar.startOfDay(for: day) }
    private var endOfDay: Date { calendar.date(byAdding: .day, value: 1, to: startOfDay)! }

    private var edgeExtendedPoints: [MetricPoint] {
        let s = points.sorted { $0.date < $1.date }
        guard !s.isEmpty else { return [] }
        var res = s
        if s.first!.date > startOfDay {
            res.insert(.init(date: startOfDay, value: s.first!.value), at: 0)
        }
        if s.last!.date < endOfDay {
            res.append(.init(date: endOfDay, value: s.last!.value))
        }
        return res
    }
    
    private var valueByHour: [Date: Double] {
        Dictionary(uniqueKeysWithValues:
            points.map { p in
                let h = calendar.date(from: calendar.dateComponents([.year,.month,.day,.hour], from: p.date))!
                return (h, p.value)
            }
        )
    }
    
    private var hourTicks: [Date] {
        points
            .sorted { $0.date < $1.date }
            .map { calendar.date(from: calendar.dateComponents([.year,.month,.day,.hour], from: $0.date))! }
    }
    
    private var yGridValues: [Double] {
        let lo = Int(ceil(yDomain.lowerBound))
        let hi = Int(floor(yDomain.upperBound))
        return (lo...hi).map(Double.init)
    }
}

#Preview {
    let cal = Calendar.current
    let base = cal.startOfDay(for: .now)
    let hours = (0..<24).compactMap { cal.date(byAdding: .hour, value: $0, to: base) }
    let values = hours.map { d -> Double in
        // простенька "дзвіночком" форма для прикладу
        let t = Double(cal.component(.hour, from: d))
        return max(0, 2 + 2.5 * exp(-pow((t - 12)/4.0, 2)))
    }
    let pts = zip(hours, values).map { MetricPoint(date: $0.0, value: $0.1) }
    
    ConditionChart(day: .now, points: pts, bands: UVIBands.standard, yDomain: 0...11)
        .padding()
}
