import SwiftUI
import CoreData

struct LoginResponseBody: Codable {
   var status: Int?;
   var response: String = "";
}

struct ContentView: View {
   @Environment(\.colorScheme) var colorScheme
   @State private var apiResponse: LoginResponseBody = LoginResponseBody();
   @State private var empid = "";
   @State private var password = "";
   @State private var alert = false;
   @State private var status = false;
   private let local: UserDefaults = UserDefaults.standard;
   private let screenWidth: CGFloat = UIScreen.main.bounds.width;
   private let screenHeight: CGFloat = UIScreen.main.bounds.height;
   
   var body: some View {
      NavigationView {
         if (status) {
            NavigationLink(destination: Home(), isActive: self.$status) {
               Text("")
            }
         } else {
            VStack {
               Text("Welcome")
                  .bold()
                  .font(.system(size: 30))
                  .foregroundColor(.black)
               VStack {
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
                  
                  Button(action: LoadData) {
                     Text("Login")
                        .foregroundColor(.white)
                        .frame(width: 100, height: 35)
                  }
                  .background(Color.blue)
                  .cornerRadius(8.0)
                  .alert(isPresented: $alert) {
                     Alert(title: Text(apiResponse.response))
                  }
               }
            }.frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/,maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .topLeading)
            .background(Color(.green))
            .ignoresSafeArea(.all)
         }
      }.navigationTitle("Login")
   }
   
   func LoadData() -> Void {
      let route: URL = URL(string: "http://localhost:1995/Login")!
      var request: URLRequest = URLRequest(url: route);
      let requestBody: [String: Any?] = ["empid": Int(empid), "password": String(password)];
      request.setValue("application/json", forHTTPHeaderField: "Content-Type");
      request.httpMethod = "POST";
      request.httpBody = try? JSONSerialization.data(withJSONObject: requestBody, options: .prettyPrinted)
      
      URLSession.shared.dataTask(with: request) { data, response, error in
         guard let data = data, error == nil else {
            print(error?.localizedDescription ?? "No data")
            return
         }
         
         if let decodedResponse = try? JSONDecoder().decode(LoginResponseBody.self, from: data) {
            DispatchQueue.main.async {
               self.apiResponse = decodedResponse;
               self.alert = true;
               self.status = decodedResponse.status == 200 ? true : false;
               local.set(decodedResponse.response, forKey: "token");
            }
            return;
         }
      }.resume();
   }
}
