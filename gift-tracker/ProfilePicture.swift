//
//  ProfilePicture.swift
//  gift-tracker
//
//  Created by Ryan Salsburg on 10/22/22.
//

import SwiftUI

struct ProfilePicture: View {
    var body: some View {
        Image("BlankProfile")
            .clipShape(Circle())
            .overlay {
                Circle().stroke(.gray, lineWidth: 4)
            }
            .shadow(radius: 7)
    }
}

struct ProfilePicture_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePicture()
    }
}
