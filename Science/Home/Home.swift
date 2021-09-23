import Foundation
import SwiftUI
import CoreData

import SwiftUI

struct MenuContent: View {
   var body: some View {
      List {
         Text("My Profile").onTapGesture {
            print("My Profile")
         }
         Text("Posts").onTapGesture {
            print("Posts")
         }
         Text("Logout").onTapGesture {
            print("Logout")
         }
      }
   }
}

struct SideMenu: View {
   let width: CGFloat
   let isOpen: Bool
   let menuClose: () -> Void
   
   var body: some View {
      ZStack {
         GeometryReader { _ in
            EmptyView()
         }
         .background(Color.gray.opacity(0.3))
         .opacity(self.isOpen ? 1.0 : 0.0)
         .animation(Animation.easeIn.delay(0.25))
         .onTapGesture {
            self.menuClose()
         }
         
         HStack {
            MenuContent()
               .frame(width: self.width)
               .background(Color.white)
               .offset(x: self.isOpen ? 0 : -self.width)
               .animation(.default)
            
            Spacer()
         }
      }
   }
}

struct Home: View {
   @State private var token = "";
   @State var menuOpen: Bool = false
   
   var body: some View {
      ZStack {
         if !self.menuOpen {
            Button(action: {
               self.openMenu()
            }, label: {
               Text("Open")
            })
         }
         
//         VStack(spacing: nil) {
//            Text(token)
//         }.onAppear(perform: LoadToken)
         
         SideMenu(width: 270,
                  isOpen: self.menuOpen,
                  menuClose: self.openMenu)
      }
   }
   
   func openMenu() {
      self.menuOpen.toggle()
   }
   
   func LoadToken() -> Void {
      let storage: UserDefaults = UserDefaults.standard;
      self.token = storage.string(forKey: "token")!;
   }
}
