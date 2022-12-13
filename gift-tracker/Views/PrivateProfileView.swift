//
//  PrivateProfileView.swift
//  gift-tracker
//
//  Created by user227528 on 11/



import SwiftUI


struct PrivateProfileView: View {
    @Binding var user: UserAccount
    @Binding var friendsList: String
    @Binding var friendEvents: [FriendEvent]
    
    var body: some View {
        ZStack {
            Color.myBeige
                .ignoresSafeArea()
            
            NavigationView{
                VStack {
                    ProfilePicture(image: Image("profile_picture_1"))
                        .offset(x: -80, y: -110)
                        //.padding(.bottom, -50)
                    VStack(alignment: .leading) {
                        HStack {
                            Text(user.display_name)
                                .font(.title)
                                .colorInvert()
                            Spacer()
                            Text(formatBirthday(user.birthday))
                                .font(.subheadline)
                                .colorInvert()
                        }
                        
                        Divider()
                            .colorInvert()
                        
                        let daysToB = daysToBirthday(user.birthday)
                        
                        if daysToB == 0{
                            Text("Your birthday is Today!")
                                .font(.title2)
                                .colorInvert()
                        }
                        else{
                            Text("Your birthday is in \(daysToB) days.")
                                .font(.title2)
                                .colorInvert()
                        }
                    }
                    .offset(y: -110)
                    .padding()
                    NavigationLink(destination: AddFriendView(user: $user, friendsList: $friendsList, friendEvents: $friendEvents)){
                        Text("Add Friends")
                    }
                    .padding(.vertical)
                    .padding(.horizontal, 100)
                    .foregroundColor(Color.white)
                    .background(Color.myLightGreen)
                    .clipShape(Capsule())
                    .offset(y: -50)
                }
                .frame(width: UIScreen.screenWidth, height: 700)
                .offset(y: 10)
                //.offset(y: -150) use this for the private profile
                .background(Color.myDarkGreen)
                .offset(y: -50)
                Spacer()
            }
        }
    }
}



/*

 
struct PrivateProfileView_Previews: PreviewProvider {
    @State static var user: UserAccount = UserAccount(birthday: "2001-11-17", display_name: "John Appleseed", friends: [], user_id: 12345, username: "johnyap25")
    static var previews: some View {
        PrivateProfileView(user: $user)
    }
}

*/
