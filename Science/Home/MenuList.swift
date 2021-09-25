import SwiftUI;

// single row height = 45

struct MenuList: View {
   private let rowHeight = 44;
   private let rowsCount = 3;
   var body: some View {
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
      }.frame(height: (CGFloat(rowsCount) * CGFloat(rowHeight)))
   }
}
