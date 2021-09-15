import Foundation
import SwiftUI
import CoreData

struct Home: View {
    @State private var token = "";
    
    func LoadToken() -> Void {
        let storage: UserDefaults = UserDefaults.standard;
        self.token = storage.string(forKey: "token")!;
    }
    
    var body: some View {
        VStack(spacing: nil) {
            Text(token)
        }.onAppear(perform: LoadToken)
    }
}
