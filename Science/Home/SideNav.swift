import SwiftUI;

struct SideMenu: View {
   let width: CGFloat
   let isOpen: Bool
//   let menuClose: () -> Void
   let menuClose: Bool
   
   var body: some View {
      ZStack {
         GeometryReader { _ in
            EmptyView()
         }
         .background(Color.gray.opacity(0.3))
         .opacity(self.isOpen ? 1.0 : 0.0)
         .animation(Animation.easeIn.delay(0.25))
//         .onTapGesture {
//            self.menuClose()
//         }
         
         HStack {
            MenuList()
               .frame(width: 300, height: 400)
               .background(Color.orange)
//               .offset(x: self.isOpen ? 0 : -self.width)
//               .animation(.default)
//               .ignoresSafeArea(.all)
            
//            Spacer()
         }
      }
   }
}
