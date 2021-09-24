import SwiftUI;

struct MenuList: View {
   var body: some View {
      VStack {
         Text("asjhdgajs")
         List {
            Text("My Profile").onTapGesture {
               print("My Profile")
            }.listRowBackground(Color.green)
            Text("Posts").onTapGesture {
               print("Posts")
            }.listRowBackground(Color.green)
            Text("Logout").onTapGesture {
               print("Logout")
            }.listRowBackground(Color.green)
         }.listStyle(DefaultListStyle())
      }.background(Color.black)
   }
}
