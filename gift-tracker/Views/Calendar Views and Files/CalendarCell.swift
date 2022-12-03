//
//  CalendarCell.swift
//  gift-tracker
//
//  Created by Cole Hartnett on 11/30/22.
//
//Determines the cell of each Caledar

import SwiftUI

struct CalendarCell: View {
    @EnvironmentObject var dateHolder: DateHolder
    //define the count variables gotten from the for each loop in CalendarView
    let count: Int
    let startingSpaces: Int
    let daysInMonth: Int
    let daysInPastMonth: Int
    //var cellColor = Color.white
    var body: some View {
        Text(monthStruct().day())
            .foregroundColor(textColor(type: monthStruct().monthType))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            //.background(cellColor)
    }
    //create a function to return the text color
    func textColor(type: MonthType) -> Color
    {
        //if it's the current month return black, otherwise return gray
        return type == MonthType.Current ? Color.black: Color.gray
    }
    //create a function to return a month struct
    func monthStruct() -> MonthStruct
    {
        let start = startingSpaces == 0 ? startingSpaces + 7 : startingSpaces
        //check if it's the previous month
        if(count <= start)
        {
            //if the day is the previous month
            let day = daysInPastMonth + count - start
            return MonthStruct(monthType: MonthType.Past, dayInt: day)
        }
        //check if it's the next month
        else if ((count - start) > daysInMonth)
        {
            let day = count-start-daysInMonth
            return MonthStruct(monthType: MonthType.Next, dayInt: day)
        }
     
        let day = count - start
        return MonthStruct(monthType: MonthType.Current, dayInt: day)
    
    }
}


struct CalendarCell_Previews: PreviewProvider {
    static var previews: some View {
        CalendarCell(count: 1, startingSpaces: 1, daysInMonth: 1, daysInPastMonth: 1)
    }
}

