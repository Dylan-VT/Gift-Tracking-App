//
//  GiftIdeasRowView.swift
//  gift-tracker
//
//  Created by Christian Rhodes on 12/2/22.
//

import SwiftUI

struct GiftIdeasRowView: View {
    
    let idea: GiftIdeasModel
    
    var body: some View {
        HStack {
            Image(systemName: idea.isCompleted ? "checkmark.circle" : "circle")
                .foregroundColor(idea.isCompleted ? .green : .red)
            Text(idea.title)
            Spacer()
        }
        .font(.title2)
        .padding(.vertical, 8)
        .background(Color.myBeige)
    }
}

struct GiftIdeasRowView_Previews: PreviewProvider {
    
    static var idea1 = GiftIdeasModel(title: "first idea", isCompleted: false)
    static var idea2 = GiftIdeasModel(title: "second idea", isCompleted: true)
    
    static var previews: some View {
        Group {
            GiftIdeasRowView(idea: idea1)
            GiftIdeasRowView(idea: idea2)
        }
        .previewLayout(.sizeThatFits)
    }
}
