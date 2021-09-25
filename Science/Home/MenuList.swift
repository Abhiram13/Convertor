import SwiftUI;

struct MenuList: View {
   private let rowHeight = 44;
   private let rowsCount = 5;
   private let screenWidth = UIScreen.main.bounds.width;
   private let screenHeight = UIScreen.main.bounds.height;
   var body: some View {
      VStack {
         List {
            ProfileView()
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
      }.frame(width: 300, height: screenHeight - 100, alignment: .top)
   }
}

struct ProfileView: View {
   var body: some View {
      VStack(alignment: .leading) {
         Text("Abhiram Nagadi")
            .bold()
            .font(.title2)
            .padding(.bottom, 1)
         Text("Admin")
      }
   }
}
