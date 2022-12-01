//
//  DateHolder.swift
//  gift-tracker
//
//  Created by Cole Hartnett on 11/30/22.
//

import Foundation
import SwiftUI

//create a class to store selected dates
class DateHolder: ObservableObject
{
    @Published var date = Date() //today
}
