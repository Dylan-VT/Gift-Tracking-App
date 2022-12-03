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
        ZStack {
            if giftIdeasViewModel.items.isEmpty {
                Text("No Ideas 😞")
            } else {
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
                .listStyle(PlainListStyle())
            }
        }
        .navigationTitle("Gift Ideas")
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
