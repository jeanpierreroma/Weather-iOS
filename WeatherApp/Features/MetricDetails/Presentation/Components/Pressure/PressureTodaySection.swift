//
//  PressureTodaySection.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 28.10.2025.
//

import SwiftUI
import Charts

struct PressureTodaySection: View {
    @Environment(\.calendar) private var calendar
    
    let date: Date
    let currentValue: Int
    let points: [MetricPoint]
    let dailySummary: String
    
    private let bucketHours = 2
    private let steadyThreshold: Double = 0.6
    
    var body: some View {
        VStack(alignment: .leading) {
            MetricChart(
                day: date,
                points: points,
                bands: PressureBands.standard,
                yDomain: 930...1100,
                topAxisMode: .custom(
                    ticks: bucketTicks(hours: bucketHours),
                    label: { d in trendLabel(at: d) }
                ),
                yGridStep: 15
            )
            .padding(.trailing)
            .padding(.top, 8)
            .padding(.bottom, 4)
            .frame(height: 320)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(style: StrokeStyle(lineWidth: 0.1))
            )
            
            PressureDailySummarySection(dailySummary: dailySummary)
            
            MetricAboutSection(
                title: "About Pressure",
                text: """
    Significant, rapid changes in pressure are used to predict changes in the weather. For example, a drop in pressure can mean that rain or snow is on the way, and rising pressure can mean that weather will improve. Pressure is also called barometric pressure or atmospheric pressure.
    """
            )
        }
    }
    
    var startOfDay: Date { calendar.startOfDay(for: date) }
    var endOfDay: Date { calendar.date(byAdding: .day, value: 1, to: startOfDay)! }

   func bucketTicks(hours: Int) -> [Date] {
       var ticks: [Date] = []
       var t = startOfDay
       while t < endOfDay {
           ticks.append(t)
           t = calendar.date(byAdding: .hour, value: hours, to: t)!
       }
       return ticks
   }

   func bucketStart(for d: Date, hours: Int) -> Date {
       let comps = calendar.dateComponents([.year, .month, .day, .hour], from: d)
       let h = comps.hour ?? 0
       let startH = (h / hours) * hours
       return calendar.date(from: .init(year: comps.year, month: comps.month, day: comps.day, hour: startH))!
   }

   // середні значення тиску по кошиках
   var avgByBucket: [Date: Double] {
       var sumCount: [Date: (sum: Double, cnt: Int)] = [:]
       for p in points {
           let b = bucketStart(for: p.date, hours: bucketHours)
           let cur = sumCount[b] ?? (0, 0)
           sumCount[b] = (cur.sum + p.value, cur.cnt + 1)
       }
       var res: [Date: Double] = [:]
       for (k, v) in sumCount { res[k] = v.sum / Double(v.cnt) }
       return res
   }

   // повертає мітку для верхньої осі (іконка або текст)
   func trendLabel(at tick: Date) -> TopAxisLabel? {
       let b = bucketStart(for: tick, hours: bucketHours)
       guard
           let curr = avgByBucket[b],
           let prevStart = calendar.date(byAdding: .hour, value: -bucketHours, to: b),
           let prev = avgByBucket[prevStart]
       else { return nil }

       let delta = curr - prev
       let absΔ = abs(delta)

       if absΔ < steadyThreshold {
           return .symbol(systemName: "line.3.horizontal")
       }
       return delta > 0
           ? .symbol(systemName: "arrow.up")
           : .symbol(systemName: "arrow.down")
   }
}

#Preview {
    let currentValue: Int = 1010
    
    PressureTodaySection(
        date: .now,
        currentValue: currentValue,
        points: DemoData.mockPressureDataHpa(),
        dailySummary: "Pressure is currently 1 010 hPa and rising. Today, the average pressure will be 1 006 hPa, and the lowest pressure will be 1 003 hPa."
    )
}
