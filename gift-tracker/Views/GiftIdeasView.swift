//
//  GiftIdeasView.swift
//  gift-tracker
//
//  Created by Christian Rhodes on 12/2/22.
//

import SwiftUI

struct GiftIdeasView: View {
    
    @EnvironmentObject var giftIdeasViewModel: GiftIdeasViewModel
    
    var body: some View {
        List {
            ForEach(giftIdeasViewModel.items) { idea in
                GiftIdeasRowView(idea: idea)
                    .onTapGesture {
                        withAnimation(.linear) {
                            giftIdeasViewModel.updateItem(item: idea)
                        }
                    }
            }
            .onDelete(perform: giftIdeasViewModel.deleteItem)
            .onMove(perform: giftIdeasViewModel.moveItem)
        }
        .navigationTitle("Gift Ideas")
        .listStyle(PlainListStyle())
        .navigationBarItems(
            leading: EditButton(),
            trailing:
                NavigationLink("Add", destination: GiftIdeasAddView())
        )
    }
}

struct GiftIdeasView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            GiftIdeasView()
        }
        .environmentObject(GiftIdeasViewModel())
    }
}
