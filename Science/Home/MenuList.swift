import SwiftUI;

struct MenuList: View {
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
