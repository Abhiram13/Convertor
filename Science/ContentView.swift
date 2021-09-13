//
//  ContentView.swift
//  Science
//
//  Created by Abhiram Nagadi on 12/09/21.
//

import SwiftUI
import CoreData

struct LoginBody {
    let empid: Int;
    let password: String;
}

struct LoginForm: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var empid: String = "";
    @State private var password: String = "";
    private let screenWidth: CGFloat = UIScreen.main.bounds.width;
    private let screenHeight: CGFloat = UIScreen.main.bounds.height;
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

