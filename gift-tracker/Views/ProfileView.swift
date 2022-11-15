//
//  ProfileView.swift
//  gift-tracker
//
//  Created by Christian Rhodes on 10/22/22.
//

import SwiftUI

let MonthList = ["Blank", "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]

struct ProfileView: View {
    @State var user: UserAccount
    var body: some View {
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
                
                Text("John's birthday is in 100 days.")
                    .font(.title2)
                Text("Description...")
                    .padding(5)
            }
            .padding()
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


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(user: UserAccount(birthday: "2001-08-07", display_name: "John Appleseed", friends: [], user_id: 12345, username: "johnyap25"))
    }
}
