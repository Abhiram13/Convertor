//
//  ContentView.swift
//  Science
//
//  Created by Abhiram Nagadi on 12/09/21.
//

import SwiftUI
import CoreData

struct LoginBody: Codable {
    let empid: Int;
    let password: String;
}

//struct LoginSubmit {
//    @Binding var username: String;
//    @Binding var password: String;
//    private let loginRoute: URL;
//    private let request: URLRequest;
//
//    init(userName: Binding<String>, passWord: Binding<String>) {
//        self._username = userName;
//        self._password = passWord;
//        self.loginRoute = URL(string: "http://localhost:1995/Login")!;
//        self.request = URLRequest(url: self.loginRoute);
//    }
//
//    request
//}

func LoginSubmit() -> Void {
    let route: URL = URL(string: "http://localhost:1995/Login")!
    var request: URLRequest = URLRequest(url: route);
    let requestBody: [String: Any] = ["empid": 40005, "password": "123"];
    request.setValue("application/json", forHTTPHeaderField: "Content-Type");
    request.httpMethod = "POST";
    request.httpBody = try? JSONSerialization.data(withJSONObject: requestBody, options: .prettyPrinted)
    
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        guard let data = data, error == nil else {
            print(error?.localizedDescription ?? "No data")
            return
        }
        let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
        if let responseJSON = responseJSON as? [String: Any] {
            print(responseJSON)
        }
    }

    task.resume()
}

struct LoginForm: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var empid: String = "";
    @State private var password: String = "";
    private let screenWidth: CGFloat = UIScreen.main.bounds.width;
    private let screenHeight: CGFloat = UIScreen.main.bounds.height;
    let v: Void = LoginSubmit();
    var body: some View {
        VStack(spacing: nil) {
            TextField("Employee Id", text: $empid)
                .keyboardType(.numberPad)
                .frame(width: screenWidth - 50, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .border((colorScheme == .dark ? Color.white : Color.black), width: 1)
                .cornerRadius(/*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
                .multilineTextAlignment(.center)
            
            TextField("Password", text: $password)
                .keyboardType(.namePhonePad)
                .frame(width: screenWidth - 50, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .border((colorScheme == .dark ? Color.white : Color.black), width: 1)
                .cornerRadius(/*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
                .multilineTextAlignment(.center)
        }
    }
}

struct ContentView: View {
    var body: some View {
        LoginForm()
    }
}

