import Foundation
import SwiftUI
import CoreData

struct Home: View {
    @State private var token = "";
    @State var menuOpen: Bool = false;
    
    var body: some View {
        ZStack {
            if !self.menuOpen {
                VStack {
                    Rectangle().fill(.red).frame(width: 100, height: 100)                    
                    Button(action: {self.openMenu()}, label: {Text("Open")})
                    Rectangle().fill(.green).frame(width: 100, height: 100)
                }
            }
            SideMenu(width: 350, isOpen: self.menuOpen, menuClose: self.openMenu)
        }
        .ignoresSafeArea(.all)
    }
    
    func openMenu() {
        self.menuOpen.toggle()
    }
    
    func LoadToken() -> Void {
        let storage: UserDefaults = UserDefaults.standard;
        self.token = storage.string(forKey: "token")!;
    }
}

struct Home_Preview: PreviewProvider {
    static var previews: some View {
        Home()
            .environment(\.sizeCategory, .medium)
            .previewLayout(.device)
            .previewDevice("iPhone 11");
    }
}
