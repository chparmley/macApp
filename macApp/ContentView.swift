//
//  ContentViewController.swift
//  macApp
//
//  Created by Charles Parmley on 3/15/22.
//
import SwiftUI
import Foundation
import Alamofire
import SwiftyJSON

struct ContentView: View {
    var pass = "admin"
    @State var loggedIn: Bool = false
    @State var password: String = ""
    @State var loginText = "Password:"
    @State var loginSymbol = "lock"
    @State var testData: Data? = Data()
    
    let lightGreyColor = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0)
    let width = CGFloat(1000)
    let height = CGFloat(1000)
    var Viewer = SwiftUIWebView(url: URL(string: "https://dfa.populiweb.com/router/user/my_course_offerings"))

    var body: some View {
        CurrentView
    }
    
    var CurrentView: some View {
            if !loggedIn {
                return AnyView(LoginView)
            } else {
                return AnyView(AnyView(Viewer))
            }
        }
    
    
    var LoginView: some View{
        VStack{
            ZoomLink
            Spacer()
            UserImage
            LoginLabel
            PasswordInput
            Spacer()
        }.frame(width: width, height: height)
    }
    var ZoomLink: some View{
        Text("[Join Class](https://dfa.zoom.us/j/84153881629)")
            .frame(maxWidth: .infinity, alignment: .topTrailing)
            .offset(x: -10, y: 10)
    }
    
    var LoginLabel: some View{
        Label(loginText, systemImage: loginSymbol)
            .font(.title)
    }
    
    var PasswordInput: some View{
        SecureField("Password", text: $password){
            reaction(password: password)
        }
        .background(lightGreyColor)
        .cornerRadius(5.0)
        .frame(width: 250)
        .foregroundColor(.black)
        .font(.title)
    }
    
    var UserImage: some View {
            Image("profile")
                .resizable()
                .scaledToFill()
                .frame(width: 150, height: 150)
                .clipped()
                .cornerRadius(150)
                .padding(.bottom, 30)
    }
    
    var WelcomeText : some View {
                Text("Welcome!")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .padding(.bottom, 40)
    }
    
    func reaction(password:String) {
        if password == "admin"{
            print("Password Accepted")
            loggedIn = true
            loginText = "Charles"
            loginSymbol = "lock.open"
            makeRequest()
        }
    }
        
    func makeRequest() {
        AF.request("https://httpbin.org/get").responseString { response in
            switch response.result{
                case .success:
                    let responseData = String(data: response.data!, encoding: .utf8)!
                    let dictionary = try? JSONSerialization.jsonObject(with: responseData.data(using: .utf8)!, options: .mutableLeaves)
                    let parsedJson = JSON(dictionary as Any)["origin"].string ?? "ERROR"
                    print(parsedJson)
                case .failure:
                    print("Error")
            }
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View{
//        Group {
//            ContentView()
//        }
//    }
//}
