//
//  GiftIdeasAddView.swift
//  gift-tracker
//
//  Created by Christian Rhodes on 12/2/22.
//

import SwiftUI

struct GiftIdeasAddView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var giftIdeasViewModel: GiftIdeasViewModel
    @State var textFieldText: String = ""
    
    @State var alertTitle: String = ""
    @State var showAlert: Bool = false
    
    var body: some View {
        ScrollView {
            VStack {
                TextField("Enter a gift idea ...", text: $textFieldText)
                    .padding(.horizontal)
                    .frame(height: 55)
                    .background(Color.myLightBrown)
                .cornerRadius(10)
                
                Button(action: saveButtonPressed, label: {
                    Text("Save".uppercased())
                        .foregroundColor(.white)
                        .font(.headline)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color.accentColor)
                        .cornerRadius(10)
                })
            }
            .padding(14)
        }
        .navigationTitle("Add a gift idea")
        .alert(isPresented: $showAlert, content: getAlert)
    }
    
    func saveButtonPressed() {
        if textIsValid() {
            giftIdeasViewModel.addItem(title: textFieldText)
            //go back one view
            presentationMode.wrappedValue.dismiss()
        }
    }
    
    func textIsValid() -> Bool {
        if textFieldText.count < 2 {
            alertTitle = "Your gift idea must be at least 2 characters long!"
            showAlert.toggle()
            return false
        }
        return true
    }
    
    func getAlert() -> Alert {
        return Alert(title: Text(alertTitle))
    }
    
}

struct GiftIdeasAddView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            GiftIdeasAddView()
        }
        .environmentObject(GiftIdeasViewModel())
    }
}
