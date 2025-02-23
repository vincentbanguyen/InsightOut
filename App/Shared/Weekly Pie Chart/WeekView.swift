//
//  WeekView.swift
//  InsightOut
//
//  Created by Vincent Nguyen on 11/6/21.
//

import SwiftUI
import InsightOut

struct WeekView: View {
    
    let entries: [Date: [MoodEntry]]
    let startWeekDate = { () -> String in
        let startDate = Calendar.current.date(byAdding: .day, value: -7, to: Date())!
        return startDate.getFormattedDate(format: "MMMM d")
    }
    
    let endWeekDate = { () -> String in
        let startDate = Date()
        return startDate.getFormattedDate(format: "MMMM d")
    }
    
    var body: some View {
        VStack {
            Text("Mood Insight")
                .font(Font.system(size: 50, weight: .semibold))
                .padding(10)
                .foregroundColor(.black)
            Text("\(startWeekDate()) - \(endWeekDate())")
                .font(Font.system(size: 20, weight: .semibold))
                .padding()
                .foregroundColor(.black)
            let data = createChartData(findSavedEmojis(entries))
            WeekPieChart(entries: data)
                .frame(width: 300, height: 300)
                .padding(.bottom, 30)
            WeekPieChartLegend(entries: data)
                .frame(width: 300, height: 300)
        }
    }
    
    func findSavedEmojis(_ entries: [Date: [MoodEntry]]) -> [Mood] {
        var savedEmojis: [Mood] = []
        for mood in Mood.allCases {
            for (key, value) in entries {
                for moodEntry in value {
                    if mood == moodEntry.mood {
                        savedEmojis.append(moodEntry.mood)
                    }
                }
            }
            
        }
        return savedEmojis
    }
    
    func createChartData(_ savedEmojis: [Mood]) -> [ChartData] {
        var chartData: [ChartData] = []
        for mood in Mood.allCases {
            var frequency: CGFloat = 0
            for savedEmoji in savedEmojis {
                if mood == savedEmoji {
                    frequency += 1
                }
            }
            if frequency != 0 {
                chartData.append(ChartData(mood: mood, value: frequency))
            }
        }
        return chartData
    }
}

struct WeekView_Previews: PreviewProvider {
    
    static var previews: some View {
        let entries: [Date: [MoodEntry]] = {
            var entries = [Date: [MoodEntry]]()
            let dates = (-30 ..< 30).map { day in
                Calendar.current.date(byAdding: .day, value: day, to: Date())!
            }
            
            for date in dates {
                let mood = Mood.allCases.randomElement()!
                entries[date] = [MoodEntry(time: date, mood: mood)]
            }
            return entries
        }()
        
        WeekView(entries: entries)
    }
}

extension Date {
   func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
}
