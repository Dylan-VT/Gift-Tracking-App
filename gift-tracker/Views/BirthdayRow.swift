//
//  BirthdayRow.swift
//  gift-tracker
//
//  Created by Christian Rhodes on 10/31/22.
//

import SwiftUI

struct BirthdayRow: View {
    var user: User
    
    var body: some View {
        HStack {
            user.image
                .resizable()
                .frame(width: 50, height: 50)
            Text(user.display_name)
            Text(user.birthday)
            
            Spacer()
        }
    }
}

/*
struct BirthdayRow_Previews: PreviewProvider {
    static var previews: some View {
        BirthdayRow(user: users[0]) //need to make users in ModelData
            .previewLayout(.fixed(width: 300, height: 70))
    }
}
 */

