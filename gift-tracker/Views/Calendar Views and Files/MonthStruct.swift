//
//  MonthStruct.swift
//  gift-tracker
//
//  Created by Cole Hartnett on 11/30/22.
//
//structure that will define how a month is presented

import Foundation
import SwiftUI

struct MonthStruct
{
    var monthType: MonthType
    var dayInt: Int
    //helper fuction to turn dayInt into a string
    func day() -> String{
        return String(dayInt)
    }
}
//declare month type as enum
enum MonthType
{
    case Past
    case Current
    case Next
}
