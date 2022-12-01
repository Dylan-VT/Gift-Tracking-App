//
//  ProfileView.swift
//  gift-tracker
//
//  Created by Christian Rhodes on 10/22/22.
//

import SwiftUI

let MonthList = ["Blank", "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]


struct ProfileView: View {
    @Binding var user: UserAccount
    var body: some View {
        ZStack {
//https://stackoverflow.com/questions/56437036/swiftui-how-do-i-change-the-background-color-of-a-view
//            Color.purple
//                .ignoresSafeArea()
            
            VStack {
                ProfilePicture(image: Image("profile_picture_1"))
                VStack(alignment: .leading) {
                    HStack {
                        Text(user.display_name)
                            .font(.title)
                        Spacer()
                        Text(formatBirthday(user.birthday))
                            .font(.subheadline)
                    }
                    
                    Divider()
                    let daysToB = daysToBirthday(user.birthday)
                    
                    if daysToB == 0{
                        Text("\(user.display_name)'s birthday is Today!")
                            .font(.title2)
                    }
                    else{
                        Text("\(user.display_name)'s birthday is in \(daysToB) days.")
                            .font(.system(.title2, design: .rounded))
                    }
                }
                .padding()
            }
            //.background(Color.teal)
            Spacer()
        }
        
    }
}


func formatBirthday(_ birthday: String) -> String{
    let yeMoDa = birthday.components(separatedBy: "-")
    let year = Int(yeMoDa[0])
    let month = Int(yeMoDa[1])
    let day = Int(yeMoDa[2])
    var retStr = ""
    if let m = month{
        retStr.append(MonthList[m])
    }
    retStr.append(" ")
    if let d = day{
        retStr.append(String(d))
        switch d{
        case 1, 21, 31:
            retStr.append("st ")
        case 2, 22:
            retStr.append("nd ")
        case 3, 23:
            retStr.append("rd ")
        default:
            retStr.append("th ")
        }
    }
    if let y = year{
        retStr.append(String(y))
    }
    return retStr
}

func daysToBirthday(_ birthday: String) -> Int{
    let yeMoDa = birthday.components(separatedBy: "-")
    let bYear = Int(yeMoDa[0])
    let bMonth = Int(yeMoDa[1])
    let bDay = Int(yeMoDa[2])
    
    let date = Date()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd/MM/yyyy"
    let cYeMoDa = dateFormatter.string(from: date).components(separatedBy: "/")
    let cYear = Int(cYeMoDa[2])
    let cMonth = Int(cYeMoDa[1])
    let cDay = Int(cYeMoDa[0])
    
    //find how many days into year both are and subtract
    let monthLength = [0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    var BdayCount = 0
    
    if let mon = bMonth{
        for m in 0...mon-1{
            BdayCount += monthLength[m]
            if let y = bYear{
                if isLeapYear(y) && mon > 2{
                    BdayCount += 1
                }
            }
        }
    }
    if let d = bDay{
        BdayCount += d
    }
    
    var cDayCount = 0
    
    if let mon = cMonth{
        for m in 0...mon-1{
            cDayCount += monthLength[m]
            if let y = cYear{
                if isLeapYear(y) && mon > 2{
                    cDayCount += 1
                }
            }
        }
    }
    if let d = cDay{
        cDayCount += d
    }
    if cDayCount > BdayCount{
        return 365 - cDayCount + BdayCount
    }
    else{
        return BdayCount - cDayCount
    }
}

func isLeapYear(_ year: Int) -> Bool{
    return (year % 4 == 0 && (year%100 != 0 || year%400 == 0))
}
struct ProfileView_Previews: PreviewProvider {
    @State static var previewUser: UserAccount = UserAccount(birthday: "2001-11-17", display_name: "John Appleseed", friends: [], user_id: 12345, username: "johnyap25")
    static var previews: some View {
        ProfileView(user: $previewUser)
    }
}

