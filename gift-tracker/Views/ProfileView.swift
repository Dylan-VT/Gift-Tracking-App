//
//  ProfileView.swift
//  gift-tracker
//
//  Created by Christian Rhodes on 10/22/22.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        VStack {
            ProfilePicture(image: Image("profile_picture_1"))
            VStack(alignment: .leading) {
                HStack {
                    Text("John Appleseed")
                        .font(.title)
                    Spacer()
                    Text("July 4th")
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

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
