//
//  CalendarView.swift
//  TimeTask
//
//  Created by kdk on 11/7/24.
//

import SwiftUI

struct CalendarView: View {
    
    @Binding var selectedDate: Date
    private let calendar = Calendar.current
    var body: some View {
        VStack {
            monthView
            dayView
        }
    }
    
    private var monthView: some View {
        HStack{
            Spacer()
            Button(action: {
                changeMonth(-1)
            }, label: {
                Image(systemName: "chevron.left")
                    .foregroundColor(Color.subGray)
            })
            Button(action: {
                 changeMonth(1)
            }, label: {
                Image(systemName: "chevron.right")
                    .foregroundColor(Color.subGray)
            })
        } .padding(.leading, 100)
    }
    
    @ViewBuilder
    private var dayView: some View {
        
        let startDate = calendar.date(from: Calendar.current.dateComponents([.year, .month], from: selectedDate))!
        
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10){
                let components = (0..<calendar.range(of: .day, in: .month, for: selectedDate)!.count)
                    .map {
                        calendar.date(byAdding: .day, value: $0, to: startDate)!
                    }
                
                ForEach(components, id: \.self) { date in
                    VStack {
                        Text(day(from: date))
                            .font(.caption)
                            .foregroundColor(calendar.isDate(selectedDate, equalTo: date, toGranularity: .day) ? Color.white : Color.subGray)
                        
                        Text("\(calendar.component(.day, from: date))")
                            .foregroundColor(calendar.isDate(selectedDate, equalTo: date, toGranularity: .day) ? Color.white : Color.subGray)
                            .font(.title3)
                    }   .padding(4)
                        .frame(width: 50, height: 50)
                        .background(calendar.isDate(selectedDate, equalTo: date, toGranularity: .day) ? Color.mainGreen : Color.clear)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .onTapGesture {
                            selectedDate = date
                    }
                }
            }
        }
    }
}

    private extension CalendarView {
        func changeMonth(_ value: Int) {
            guard let changeDate = calendar.date(byAdding: .month, value: value, to: selectedDate)
            else {
                return
            }
            selectedDate = changeDate
        }
        
        func day(from date: Date) -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.setLocalizedDateFormatFromTemplate("E")
            return dateFormatter.string(from: date)
        }
    }
