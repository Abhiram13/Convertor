import SwiftUI
import CoreData

struct LoginResponseBody: Codable {
   var status: Int?;
   var response: String = "";
}

struct WelcomeView: View {
   private let screenWidth: CGFloat = UIScreen.main.bounds.width;
   private let screenHeight: CGFloat = UIScreen.main.bounds.height;
   
   var body: some View {
      VStack(alignment: .leading, spacing: 0) {
         Text("Welcome to")
            .font(.system(size: 20))
            .foregroundColor(.black)
         
         Text("CRM")
            .font(.system(size: 80))
            .fontWeight(.heavy)
            .foregroundColor(.black)
      }
      .frame(maxWidth: screenWidth - 40, maxHeight: 100, alignment: .leading)
      .padding(.top, 130)
      .padding(.horizontal, 50)
   }
}

struct FormView: View {
   @Environment(\.colorScheme) var colorScheme
   @Binding var empid: String;
   @Binding var password: String;
   @Binding var alert: Bool;
   @Binding var apiResponse: LoginResponseBody;
   private let screenWidth: CGFloat = UIScreen.main.bounds.width;
   private let screenHeight: CGFloat = UIScreen.main.bounds.height;
   var load: () -> Void;
   
   init(loadData: @escaping () -> Void, id: Binding<String>, passWord: Binding<String>, Alert: Binding<Bool>, Response: Binding<LoginResponseBody>) {
      self.load = loadData;
      self._empid = id;
      self._password = passWord;
      self._alert = Alert;
      self._apiResponse = Response;
   }
   
   var body: some View {
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
         
         Button(action: self.load) {
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
      .padding(.top, 150)
   }
}

struct ContentView: View {
   @Environment(\.colorScheme) var colorScheme
   @State private var apiResponse: LoginResponseBody = LoginResponseBody();
   @State private var empid = "";
   @State private var password = "";
   @State private var token = "";
   @State private var alert = false;
   @State private var status = true;
   @State private var statusCode = 200;
   private let local: UserDefaults = UserDefaults.standard;
   
   var body: some View {
      NavigationView {
          NavigationLink(destination: Home(), isActive: self.$status) {
              Text("")
          }
//         if token != "" && statusCode == 200 {
//
//         } else {
//            VStack {
//               WelcomeView()
//               FormView(loadData: LoadData, id: $empid, passWord: $password, Alert: $alert, Response: $apiResponse)
//               Text(token)
//            }
//            .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/,maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .topLeading)
//            .ignoresSafeArea(.all)
//         }
      }.navigationTitle("Login")
//      .onAppear(perform: self.LoadToken)
   }
   
   func LoadToken() -> Void {
      let storage: UserDefaults = UserDefaults.standard;
      self.token = storage.string(forKey: "token")!;
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
               self.token = decodedResponse.response;
               self.statusCode = decodedResponse.status!;
               local.set(decodedResponse.response, forKey: "token");
            }
            return;
         }
      }.resume();
   }
}
