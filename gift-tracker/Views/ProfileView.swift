//
//  ProfileView.swift
//  gift-tracker
//
//  Created by Christian Rhodes on 10/22/22.
//

import SwiftUI
import Combine

let MonthList = ["Blank", "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]

struct CheckToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        return HStack {
            configuration.label
            Spacer()
            Image(systemName: configuration.isOn ? "checkmark.square" : "square")
                .resizable()
                .frame(width: 22, height: 22)
                .onTapGesture { configuration.isOn.toggle() }
        }
    }
}

struct ProfileView: View {
    
    @State var user: FriendEvent
    @State var text = "\u{2022} "
    
    @StateObject var giftIdeasViewModel: GiftIdeasViewModel = GiftIdeasViewModel()
    
    var body: some View {
        ZStack {
            Color.myBeige
                .ignoresSafeArea()
            
            VStack {
                ProfilePicture(image: Image("profile_picture_1"))
                    .offset(x: -80, y: -110)
                    .padding(.bottom, -150)
                VStack(alignment: .leading) {
                    VStack {
                        Text(user.username)
                            .font(.largeTitle)
                            .colorInvert()
                            .padding(.bottom, 1)
                        Text("🎂 " + formatBirthday(user.event_date))
                            .font(.title3)
                            .colorInvert()
                    }
                    .padding(.top, 30)
                    
                    Divider()
                        .colorInvert()
                    
                    let daysToB = daysToBirthday(user.event_date)
                    
                    if daysToB == 0{
                        Text("⏱ " + "\(user.username)'s birthday is Today!")
                            .font(.title2)
                            .colorInvert()
                    }
                    else{
                        Text("⏱ " + "\(user.username)'s birthday is in \(daysToB) days.")
                            .font(.system(.title2, design: .rounded))
                            .colorInvert()
                    }
                    
                    //place todo-list view here
                    NavigationView {
                        GiftIdeasView()
                    }
                    .environmentObject(giftIdeasViewModel)
                    
                }
                .padding()
            }
            .frame(height: 600)
            .offset(y: -150)
            .background(Color.myDarkGreen)
            .offset(y: 80)
            Spacer()
        }
        
    }
}


extension Color {
    static let myBlue = Color("CustomColor_Blue")
    static let myBeige = Color("CustomColor_Beige")
    static let myLightGreen = Color("CustomColor_LightGreen")
    static let myDarkGreen = Color("CustomColor_DarkGreen")
    static let myLightBrown = Color("CustomColor_LightBrown")
    static let myDarkBrown = Color("CustomColor_DarkBrown")
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
    @State static var previewUser: FriendEvent = FriendEvent(event_for: 2, event_name: "event name", event_description: "event decription...", event_date: "event date", username: "user name")
    static var previews: some View {
        ProfileView(user: previewUser)
    }
}


        //OLD USERDEAUTLS
//                    Toggle("Need Gift? ", isOn: $friendDetails.needGift)
//                        //.toggleStyle(CheckToggleStyle())
//                        .colorInvert()
//                        //.onChange(of: <#T##Equatable#>, perform: <#T##(Equatable) -> Void##(Equatable) -> Void##(_ newValue: Equatable) -> Void#>)

                    //gift ideas
//                    TextEditor(text: friendDetails.giftIdea)
//                        //.frame(height: 400)
//                        //.border(Color.black)
//                        //.colorInvert()
//                        .onChange(of: text) { [text] newText in
//                            if newText.suffix(1) == "\n" && newText > text {
//                                self.text.append("\u{2022} ")
//                            }
