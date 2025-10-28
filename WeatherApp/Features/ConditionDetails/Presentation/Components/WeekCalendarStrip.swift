//
//  WeekCalendarStrip.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 27.10.2025.
//


import SwiftUI

struct CalendarStrip: View {
    @Environment(\.calendar) private var calendar
    @Binding var selectedDate: Date
    
    private let baseDate: Date
    
    init(selectedDate: Binding<Date>, baseDate: Date = Date()) {
        self._selectedDate = selectedDate
        self.baseDate = baseDate
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            daysRow
            
            HStack {
                Spacer()
                dateLabel
                Spacer()
            }
            
        }
    }

    @ViewBuilder
    private var daysRow: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach(displayDays, id: \.timeIntervalSinceReferenceDate) { day in
                    let isSelected = calendar.isDate(day, inSameDayAs: selectedDate)
                    let enabled = effectiveRange.contains(day)

                    Button {
                        guard enabled else { return }
                        selectedDate = day
                    } label: {
                        VStack(spacing: 6) {
                            Text(weekdaySymbol(for: day).uppercased())
                                .font(.caption2)
                                .foregroundStyle(.secondary)

                            ZStack {
                                Text("88")
                                    .font(.callout.weight(.semibold))
                                    .monospacedDigit()
                                    .opacity(0)            

                                Text(dayNumber(day))
                                    .font(.callout.weight(.semibold))
                                    .monospacedDigit()
                            }
                            .padding(6)
                            .background(
                                Circle().fill(isSelected ? Color.accentColor : .clear)
                            )
                            .foregroundStyle(isSelected ? .white : (enabled ? .primary : .secondary))
                        }
                        .contentShape(Rectangle())
                    }
                    .buttonStyle(.plain)
                    .disabled(!enabled)
                }
            }
        }
    }

    @ViewBuilder
    private var dateLabel: some View {
        Text(selectedDate.formatted(.dateTime.weekday(.wide).day().month(.wide).year()))
            .font(.subheadline.weight(.medium))
            .foregroundStyle(.secondary)
            .padding(.top, 2)
    }

    // MARK: - Data

    private var displayDays: [Date] {
        let start = effectiveRange.lowerBound
        return (0..<10).compactMap { calendar.date(byAdding: .day, value: $0, to: start) }
    }

    private var effectiveRange: ClosedRange<Date> {
        let start = startOfWeekRespectingLocale(for: baseDate)
        let end = calendar.date(byAdding: .day, value: 9, to: start) ?? start
        return start...end
    }

    // MARK: - Helpers

    private func startOfWeekRespectingLocale(for date: Date) -> Date {
        if let interval = calendar.dateInterval(of: .weekOfYear, for: date) {
            return interval.start
        }
        
        let startOfDay = calendar.startOfDay(for: date)
        let weekday = calendar.component(.weekday, from: startOfDay) // 1 = неділя
        let daysFromMonday = (weekday + 5) % 7
        return calendar.date(byAdding: .day, value: -daysFromMonday, to: startOfDay) ?? startOfDay
    }

    private func weekdaySymbol(for date: Date) -> String {
        date.formatted(.dateTime.weekday(.narrow))
    }

    private func dayNumber(_ date: Date) -> String {
        String(calendar.component(.day, from: date))
    }
}

#Preview("CalendarStrip") {
    @Previewable @State var date: Date = .now
    VStack(spacing: 16) {
        
        CalendarStrip(selectedDate: $date)
    }
    .padding()
}
