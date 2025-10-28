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
    
    enum TopAxisMode: Equatable {
        case perHour
        case averageByBucket(hours: Int)
    }
    
    let day: Date
    let points: [MetricPoint]
    let bands: [ChartBand]
    
    var yDomain: ClosedRange<Double>
    var topAxisMode: TopAxisMode
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
            AxisMarks(position: .top, values: topAxisTicks) { v in
                AxisValueLabel {
                    if let d = v.as(Date.self), let val = topAxisValueAt[d] {
                        if yGridStep.truncatingRemainder(dividingBy: 1) == 0 {
                            Text("\(Int(round(val)))")
                                .font(.caption2.weight(.semibold))
                                .foregroundStyle(.secondary)
                        } else {
                            Text(val.formatted(.number.precision(.fractionLength(0...1))))
                                .font(.caption2.weight(.semibold))
                                .foregroundStyle(.secondary)
                        }
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
                        if yGridStep.truncatingRemainder(dividingBy: 1) == 0 {
                            Text("\(Int(y))")
                        } else {
                            Text(y.formatted(.number.precision(.fractionLength(0...2))))
                        }
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
    
    private var topAxisTicks: [Date] {
        switch topAxisMode {
        case .perHour:
            return Array(Set(hourTicks)).sorted()
        case .averageByBucket(let hours):
            return bucketTicks(hours: hours)
        }
    }
    
    private var topAxisValueAt: [Date: Double] {
        switch topAxisMode {
        case .perHour:
            return valueByHour
        case .averageByBucket(let hours):
            return bucketAverages(hours: hours)
        }
    }

    private func bucketTicks(hours: Int) -> [Date] {
        guard hours > 0 else { return [] }
        var ticks: [Date] = []
        var t = startOfDay
        while t < endOfDay {
            ticks.append(t)                     
            t = calendar.date(byAdding: .hour, value: hours, to: t)!
        }
        return ticks
    }

    private func bucketStart(for date: Date, hours: Int) -> Date {
        let comps = calendar.dateComponents([.year, .month, .day, .hour], from: date)
        let h = comps.hour ?? 0
        let startH = (h / hours) * hours
        return calendar.date(from: .init(year: comps.year, month: comps.month, day: comps.day, hour: startH))!
    }

    private func bucketAverages(hours: Int) -> [Date: Double] {
        guard hours > 0 else { return [:] }
        var agg: [Date: (sum: Double, count: Int)] = [:]
        for p in points {
            let b = bucketStart(for: p.date, hours: hours)
            let cur = agg[b] ?? (0, 0)
            agg[b] = (cur.sum + p.value, cur.count + 1)
        }
        var res: [Date: Double] = [:]
        for (k, v) in agg {
            res[k] = v.count > 0 ? v.sum / Double(v.count) : .nan
        }
        return res
    }
    
    private var yGridValues: [Double] {
        let lo = yDomain.lowerBound
        let hi = yDomain.upperBound
        let step = max(0.0001, yGridStep)
        
        let first = ceil(lo / step) * step
        guard first <= hi else { return [hi] }
        
        return Array(stride(from: first, through: hi, by: step))
    }
}

#Preview {
    let day: Date = .now
    let points: [MetricPoint] = DemoData.mockUVIData()
    let bands: [ChartBand] = UVIBands.standard
    let yDomain: ClosedRange<Double> = 0...11
    
    ConditionChart(
        day: day,
        points: points,
        bands: bands,
        yDomain: yDomain,
        topAxisMode: .perHour
    )
    .padding()
}
