//
//  UvIndexChart.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 28.10.2025.
//


import SwiftUI
import Charts

struct MetricChart: View {
    @Environment(\.calendar) private var calendar

    let day: Date
    let points: [MetricPoint]
    let bands: [ChartBand]
    
    var yDomain: ClosedRange<Double>
    var topAxisMode: TopAxisMode
    var yGridStep: Double = 1
    var maskBaseline: Double = -0.1
    
    private let solidStyle  = StrokeStyle(lineWidth: 4, lineCap: .round)
    private let dashedStyle = StrokeStyle(lineWidth: 4, lineCap: .round, dash: [6, 8])
    
    private let pastFillOpacity   = 0.28
    private let futureFillOpacity = 0.56
    private let pastLineOpacity   = 0.65
    private let futureLineOpacity = 1.00
    
    var body: some View {
        Chart {
            if let cut = splitX {
                // MARK: Area
                ForEach(bands) { band in
                    RectangleMark(
                        xStart: .value("from", startOfDay),
                        xEnd:   .value("to",   endOfDay),
                        yStart: .value("y0", band.range.lowerBound),
                        yEnd:   .value("y1", band.range.upperBound)
                    )
                    .foregroundStyle(band.color.opacity(pastFillOpacity))
                }
                .mask {
                    ForEach(pastPointsWithCut) { p in
                        AreaMark(
                            x: .value("t", p.date),
                            yStart: .value("y0", yDomain.lowerBound + maskBaseline),
                            yEnd: .value("y1", p.value)
                        )
                        .interpolationMethod(.monotone)
                    }
                    .foregroundStyle(by: .value("current", Date()))
                }
                
                ForEach(bands) { band in
                    RectangleMark(
                        xStart: .value("from", startOfDay),
                        xEnd:   .value("to",   endOfDay),
                        yStart: .value("y0", band.range.lowerBound),
                        yEnd:   .value("y1", band.range.upperBound)
                    )
                    .foregroundStyle(band.color.opacity(futureFillOpacity))
                }
                .mask {
                    ForEach(futurePointsWithCut) { p in
                        AreaMark(
                            x: .value("t", p.date),
                            yStart: .value("y0", yDomain.lowerBound + maskBaseline),
                            yEnd: .value("y1", p.value)
                        )
                        .interpolationMethod(.monotone)
                    }
                    .foregroundStyle(by: .value("current", Date()))
                }
                
                // MARK: Line
                ForEach(bands) { band in
                    RectangleMark(
                        xStart: .value("from", startOfDay),
                        xEnd:   .value("to",   cut),
                        yStart: .value("y0", band.range.lowerBound + maskBaseline),
                        yEnd:   .value("y1", band.range.upperBound)
                    )
                    .foregroundStyle(band.color.opacity(pastLineOpacity))
                }
                .mask {
                    ForEach(pastPointsWithCut) { p in
                        LineMark(
                            x: .value("t", p.date),
                            y: .value("val", p.value)
                        )
                        .interpolationMethod(.monotone)
                        .lineStyle(dashedStyle)
                    }
                    .foregroundStyle(by: .value("current", Date()))
                }
                
                
                ForEach(bands) { band in
                    RectangleMark(
                        xStart: .value("from", cut),
                        xEnd:   .value("to", endOfDay),
                        yStart: .value("y0", band.range.lowerBound + maskBaseline),
                        yEnd:   .value("y1", band.range.upperBound)
                    )
                    .foregroundStyle(band.color.opacity(futureLineOpacity))
                }
                .mask {
                    ForEach(futurePointsWithCut) { p in
                        LineMark(
                            x: .value("t", p.date),
                            y: .value("val", p.value)
                        )
                        .interpolationMethod(.monotone)
                        .lineStyle(solidStyle)
                    }
                    .foregroundStyle(by: .value("current", Date()))
                }
            } else {
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
                            yStart: .value("y0", yDomain.lowerBound + maskBaseline),
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
            }
            
            if calendar.isDate(day, inSameDayAs: Date()) {
                RuleMark(x: .value("Now", Date()))
                    .lineStyle(.init(lineWidth: 1))
                    .foregroundStyle(.secondary)
            }
            
            if let cut = splitX {
                let y = value(at: cut)
                let c = color(for: y)

                // м'яке «сяйво»
                PointMark(
                    x: .value("t", cut),
                    y: .value("val", y)
                )
                .symbolSize(140)
                .foregroundStyle(c.opacity(0.20))
                .zIndex(10)

                // сама точка
                PointMark(
                    x: .value("t", cut),
                    y: .value("val", y)
                )
                .symbolSize(64)
                .foregroundStyle(c)
                .zIndex(11)

                // білий обвід для контрасту
                PointMark(
                    x: .value("t", cut),
                    y: .value("val", y)
                )
                .symbol(
                    Circle()
                        .strokeBorder(lineWidth: 2)
                )
                .foregroundStyle(.white)
                .symbolSize(68)
                .zIndex(12)
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
    
    private var isToday: Bool {
        calendar.isDate(day, inSameDayAs: Date())
    }
    
    private var splitX: Date? {
        guard isToday else { return nil }
        let now = Date()
        let r = min(max(now, startOfDay), endOfDay)
        print(r == startOfDay)
        print(r == now)
        print(r == endOfDay)
        
        return r
    }
    
    private func value(at t: Date) -> Double {
        let d = edgeExtendedPoints
        guard let first = d.first, let last = d.last else { return .nan }
        if t <= first.date { return first.value }
        if t >= last.date  { return last.value }
        for i in 1..<d.count {
            let p0 = d[i - 1], p1 = d[i]
            if p0.date <= t && t <= p1.date {
                let dt = p1.date.timeIntervalSince(p0.date)
                guard dt > 0 else { return p1.value }
                let k = t.timeIntervalSince(p0.date) / dt
                return p0.value + (p1.value - p0.value) * k
            }
        }
        return last.value
    }

    private var pastPointsWithCut: [MetricPoint] {
        guard let cut = splitX else { return edgeExtendedPoints }
        var pts = edgeExtendedPoints.filter { $0.date <= cut }
        if pts.last?.date != cut {
            pts.append(.init(date: cut, value: value(at: cut)))
        }
        return pts
    }
    private var futurePointsWithCut: [MetricPoint] {
        guard let cut = splitX else { return [] }
        var pts = edgeExtendedPoints.filter { $0.date >= cut }
        if pts.first?.date != cut {
            pts.insert(.init(date: cut, value: value(at: cut)), at: 0)
        }
        return pts
    }
    
    private func color(for value: Double) -> Color {
        if let band = bands.first(where: { $0.range.contains(value) }) {
            return band.color
        }
        return .accentColor
    }
}

#Preview {
    let day: Date = .now
    let points: [MetricPoint] = DemoData.mockUVIData()
    let bands: [ChartBand] = UVIBands.standard
    let yDomain: ClosedRange<Double> = 0...11
    
    MetricChart(
        day: day,
        points: points,
        bands: bands,
        yDomain: yDomain,
        topAxisMode: .perHour
    )
    .padding()
}
