//
//  PrivateProfileView.swift
//  gift-tracker
//
//  Created by user227528 on 11/



import SwiftUI


struct PrivateProfileView: View {
    @Binding var user: UserAccount
    var body: some View {
        NavigationView{
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
                        Text("Your birthday is Today!")
                            .font(.title2)
                    }
                    else{
                        Text("Your birthday is in \(daysToB) days.")
                            .font(.title2)
                    }
                }
                .padding()
                NavigationLink(destination: AddFriendView(user: $user)){
                    Text("Add Friends")
                }
                .padding(.vertical)
                .padding(.horizontal, 100)
                .foregroundColor(Color.white)
                .background(Color.blue)
                .clipShape(Capsule())
            }
        }
    }
}

//502 == error
//200 == successful



 
struct PrivateProfileView_Previews: PreviewProvider {
    @State static var user: UserAccount = UserAccount(birthday: "2001-11-17", display_name: "John Appleseed", friends: [], user_id: 12345, username: "johnyap25")
    static var previews: some View {
        PrivateProfileView(user: $user)
    }
}

