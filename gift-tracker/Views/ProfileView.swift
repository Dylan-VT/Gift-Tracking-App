//
//  ProfileView.swift
//  gift-tracker
//
//  Created by Christian Rhodes on 10/22/22.
//

import SwiftUI
import Combine

let MonthList = ["Blank", "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]

struct CheckToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        return HStack {
            configuration.label
            Spacer()
            Image(systemName: configuration.isOn ? "checkmark.square" : "square")
                .resizable()
                .frame(width: 22, height: 22)
                .onTapGesture { configuration.isOn.toggle() }
        }
    }
}

struct Ideas: Codable, Identifiable{
    var id: String?
//    var id: String {
//        self.id
//    }
    //var id: UUID
    var ideas: [String]?
    //var ideas: String
}

func updateIdeas(_ username: Int, _ eventFor: Int, _ text: String) -> Void {
    print("handling TextField commit. value follows: ")
    print(text)
    
    //let url = URL(string: "http:/54.237.192.235/idea/\(username)/\(eventFor)/\(text)")!
    guard let url = URL(string: "http://54.237.192.235/idea/\(username)/\(eventFor)/\(text)") else {
                print("Error: cannot create URL")
                return
            }
    
    // Create the request
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("http://54.237.192.235/idea/\(username)/\(eventFor)/\(text)", forHTTPHeaderField: "Content-Type")

}

//get gift ideas data from URL
//NOTE - changed the escaping from "Ideas?" to "[Ideas]
func getIdeas(_ username: String, _ eventFor: String,_ completion: @escaping ([Ideas]) -> Void){
    let url = URL(string: "http://54.237.192.235/idea/\(username)/\(eventFor)")!
    let task = URLSession.shared.dataTask(with: url) {data, response, error in
        if let data = data {
            let decoder = JSONDecoder()
            do {
                print("HERE")
                let json = try decoder.decode([Ideas].self, from: data)
                print(json)
                print("after")
                completion(json)
            } catch {
                //completion(nil)
                print(error)
            }
        }
    }
    task.resume()
}

struct ProfileView: View {
    @State var user: FriendEvent
    @State var text = "\u{2022} "
    @State var ideaInput = ""
    @State var ideasForUser: [String] = [""]
    
    @Binding var loggedInUser: UserAccount //pass by ref or value - look into

    /*
    @StateObject var giftIdeasViewModel: GiftIdeasViewModel = GiftIdeasViewModel()
     */
    
    var body: some View {
        ZStack {
            Color.myBeige
                .ignoresSafeArea()
            
            VStack {
                ProfilePicture(image: Image("profile_picture_1"))
                    .offset(x: -80, y: -110)
                    .padding(.bottom, -150)
                VStack(alignment: .leading) {
                    VStack {
                        Text(user.username)
                            .font(.largeTitle)
                            .colorInvert()
                            .padding(.bottom, 1)
                        Text("???? " + formatBirthday(user.event_date))
                            .font(.title3)
                            .colorInvert()
                    }
                    .onAppear{ ideasForUser = saveIdeas(String(loggedInUser.user_id), String(user.event_for)) } //get all ideas on first element load
                    .padding(.top, 30)
                    
                    Divider()
                        .colorInvert()
                    
                    let daysToB = daysToBirthday(user.event_date)
                    
                    if daysToB == 0{
                        Text("??? " + "\(user.username)'s birthday is Today!")
                            .font(.title2)
                            .colorInvert()
                    }
                    else{
                        Text("??? " + "\(user.username)'s birthday is in \(daysToB) days.")
                            .font(.system(.title2, design: .rounded))
                            .colorInvert()
                    }
                    
                    //gift idea list
                    List {
                        //display all existing lists
                        ForEach(ideasForUser, id: \.self) { idea in
                            HStack{
                                Text(idea)
                                    .padding()
                            }
                            //.background(Color.myLightGreen)
                        }
                        //allow user to add new gift ideas
                        TextField(
                            "Enter Gift Idea",
                            text: $ideaInput,
                            onCommit: {
                                updateIdeas(loggedInUser.user_id, user.event_for, ideaInput)
                            }
                        )
                        .padding()
                        //.colorInvert()
                    }
                
                    //OLD VERSION WITH USERDEFAULTS - DELETE THIS
                    /*
                    NavigationView {
                        //GiftIdeasView()
                    }
                     
                    .environmentObject(giftIdeasViewModel)
                    .frame(width: UIScreen.screenWidth, height: 330)
                    .cornerRadius(20)
                    .background(Color.myLightGreen)
                    */
                }
                .padding()
            }
            .frame(height: 570)
            .offset(y: 10)
            //.offset(y: -150) use this for the private profile
            .background(Color.myDarkGreen)
            .offset(y: 20)
            Spacer()
        }
        
    }
    //function to get ideas from URL and store in @State var ideasForUser list of strings
    func saveIdeas(_ u: String, _ p: String) -> ([String]){//success: Bool, erMessage: String) {
        var suc: Bool = false
        let group = DispatchGroup()
        group.enter()
        getIdeas(u, p, {data in
            print(data)
//            if let dat = data{
//                suc = true
//                print("CHECK IT OUT")
//                print(dat)
//                //populate ideasList with values
//                if let ideas = dat {
//                    ideasForUser = ideas.map {String($0)}//.joined(separator: ",")
//                    print("Ideas: \(String(describing: ideasForUser))")
//                }
//            }
//            else{
//                print("UH OH")
//                suc = false
//            }
            group.leave()
        })
        group.wait()
        if suc{
            //return (suc, "\(u) Successfully logged on")
            return ideasForUser
        }
        else{
            //return (suc, "The credentials you entered are incorrect")
            return["gift idea"]
        }
    }
}

extension Color {
    static let myBlue = Color("CustomColor_Blue")
    static let myBeige = Color("CustomColor_Beige")
    static let myLightGreen = Color("CustomColor_LightGreen")
    static let myDarkGreen = Color("CustomColor_DarkGreen")
    static let myLightBrown = Color("CustomColor_LightBrown")
    static let myDarkBrown = Color("CustomColor_DarkBrown")
}

extension UIScreen{
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}

func formatBirthday(_ birthday: String) -> String{
    let yeMoDa = birthday.components(separatedBy: "-")
    let year = Int(yeMoDa[0])
    let month = Int(yeMoDa[1])
    let day = Int(yeMoDa[2])
    var retStr = ""
    if let m = month{
        retStr.append(MonthList[m])
    }
    retStr.append(" ")
    if let d = day{
        retStr.append(String(d))
        switch d{
        case 1, 21, 31:
            retStr.append("st ")
        case 2, 22:
            retStr.append("nd ")
        case 3, 23:
            retStr.append("rd ")
        default:
            retStr.append("th ")
        }
    }
    if let y = year{
        retStr.append(String(y))
    }
    return retStr
}

func daysToBirthday(_ birthday: String) -> Int{
    let yeMoDa = birthday.components(separatedBy: "-")
    let bYear = Int(yeMoDa[0])
    let bMonth = Int(yeMoDa[1])
    let bDay = Int(yeMoDa[2])
    
    let date = Date()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd/MM/yyyy"
    let cYeMoDa = dateFormatter.string(from: date).components(separatedBy: "/")
    let cYear = Int(cYeMoDa[2])
    let cMonth = Int(cYeMoDa[1])
    let cDay = Int(cYeMoDa[0])
    
    //find how many days into year both are and subtract
    let monthLength = [0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    var BdayCount = 0
    
    if let mon = bMonth{
        for m in 0...mon-1{
            BdayCount += monthLength[m]
            if let y = bYear{
                if isLeapYear(y) && mon > 2{
                    BdayCount += 1
                }
            }
        }
    }
    if let d = bDay{
        BdayCount += d
    }
    
    var cDayCount = 0
    
    if let mon = cMonth{
        for m in 0...mon-1{
            cDayCount += monthLength[m]
            if let y = cYear{
                if isLeapYear(y) && mon > 2{
                    cDayCount += 1
                }
            }
        }
    }
    if let d = cDay{
        cDayCount += d
    }
    if cDayCount > BdayCount{
        return 365 - cDayCount + BdayCount
    }
    else{
        return BdayCount - cDayCount
    }
}

func isLeapYear(_ year: Int) -> Bool{
    return (year % 4 == 0 && (year%100 != 0 || year%400 == 0))
}


//struct ProfileView_Previews: PreviewProvider {
//    @State static var previewUser: FriendEvent = FriendEvent(event_for: 2, event_name: "event name", event_description: "event decription...", event_date: "event date", username: "user name")
//    static var previews: some View {
//        //ProfileView(user: previewUser), user: $loggedInUser
//        ProfileView(user: <#T##FriendEvent#>, loggedInUser: <#T##Binding<UserAccount>#>, ideasForUser: <#T##Binding<String?>#>)
//    }
//}


        //OLD USERDEAUTLS
//                    Toggle("Need Gift? ", isOn: $friendDetails.needGift)
//                        //.toggleStyle(CheckToggleStyle())
//                        .colorInvert()
//                        //.onChange(of: <#T##Equatable#>, perform: <#T##(Equatable) -> Void##(Equatable) -> Void##(_ newValue: Equatable) -> Void#>)

                    //gift ideas
//                    TextEditor(text: friendDetails.giftIdea)
//                        //.frame(height: 400)
//                        //.border(Color.black)
//                        //.colorInvert()
//                        .onChange(of: text) { [text] newText in
//                            if newText.suffix(1) == "\n" && newText > text {
//                                self.text.append("\u{2022} ")
//                            }
