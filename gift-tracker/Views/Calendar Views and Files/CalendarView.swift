//
//  CalendarView.swift
//  gift-tracker
//
//  Created by Cole Hartnett on 11/30/22.
//

import Foundation
import SwiftUI

struct CalendarView: View
{
    //define dateHolder as an environmental object
    @EnvironmentObject var dateHolder: DateHolder
    
    var body: some View
    {
        VStack(spacing: 1)
        {
            DateScrollerView()
                .environmentObject(dateHolder)
                .padding()
            daysOfWeekStack
            calendarGrid
        }
    }
    
    //define the daysOfWeek Stack
    var daysOfWeekStack: some View
    {
        HStack(spacing: 1)
        {
            Text("Sun").dayOfWeek()
            Text("Mon").dayOfWeek()
            Text("Tue").dayOfWeek()
            Text("Wed").dayOfWeek()
            Text("Thu").dayOfWeek()
            Text("Fri").dayOfWeek()
            Text("Sat").dayOfWeek()
        }
    }
    //define an VStack for the grid of the calendar
    var calendarGrid: some View
    {
        VStack(spacing: 1)
        {
            //declare the days in the month and the first day of the month
            let daysInMonth = CalendarHelper().daysInMonth(dateHolder.date)
            let firstDayOfMonth = CalendarHelper().fistOfMonth(dateHolder.date)
            //as well as the starting spaces and the previous month date
            let startingSpace = CalendarHelper().getWeekDay(firstDayOfMonth)
            let pastMonth = CalendarHelper().minusMonth(dateHolder.date)
            //define the days in the previous month
            let daysInPastMonth = CalendarHelper().daysInMonth(pastMonth)
            //define loops to create a 6x7 grid calendar
            ForEach(0..<6)
            {
                row in
                HStack(spacing: 1)
                {
                    ForEach(1..<8)
                    {
                        column in
                        //formula for dynamic calendar was researched and taken from https://xelplus.com/calendar-excel-formula/
                        let count = column + (row * 7)
                        //create each Calendar Cell Object
                        CalendarCell(count: count, startingSpaces: startingSpace, daysInMonth: daysInMonth, daysInPastMonth: daysInPastMonth)
                            //also pass the dateHolder in
                            .environmentObject(dateHolder)
                    }
                }
            }
        }
        //define the stack attributes
        .frame(maxHeight: .infinity)
    }
}

 struct CalendarView_Previews: PreviewProvider {
 static var previews: some View {
 ContentView()
 }
 }
 

//define the extension text for the .dayOfWeek, this makes it easier to update how it looks
extension Text
{
    func dayOfWeek() -> some View
    {
        //this function will apply any text edits to the days of the weeks
        //TODO: Add this with the current month and not the dummy data
        self.frame(maxWidth: .infinity)
            .padding(.top, 1)
            .lineLimit(1)
    }
}
