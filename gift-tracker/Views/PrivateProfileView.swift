//
//  PrivateProfileView.swift
//  gift-tracker
//
//  Created by user227528 on 11/



import SwiftUI





struct PrivateProfileView: View {
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
                let daysToB = daysToBirthday(user.birthday)
                
                if daysToB == 0{
                    Text("\(user.display_name)'s birthday is Today!")
                        .font(.title2)
                }
                else{
                    Text("\(user.display_name)'s birthday is in \(daysToB) days.")
                        .font(.title2)
                }
                
            }
            .padding()
        }
    }
}

//502 == error
//200 == successful

 
struct PrivateProfileView_Previews: PreviewProvider {
    static var previews: some View {
        PrivateProfileView(user: UserAccount(birthday: "2001-11-17", display_name: "John Appleseed", friends: [], user_id: 12345, username: "johnyap25"))
    }
}

