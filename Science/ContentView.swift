import SwiftUI
import CoreData

struct LoginResponseBody: Codable {
    var status: Int?;
    var response: String = "";
}

struct LoginRequestBody: Codable {
    var empid = 40005;
    var password = "123";
}

func LoginSubmit() -> Void {
    let route: URL = URL(string: "http://localhost:1995/Login")!
    var request: URLRequest = URLRequest(url: route);
    let requestBody: [String: Any] = ["empid": 40005, "password": "123"];
    request.setValue("application/json", forHTTPHeaderField: "Content-Type");
    request.httpMethod = "POST";
    request.httpBody = try? JSONSerialization.data(withJSONObject: requestBody, options: .prettyPrinted)
    
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        guard let data = data, error == nil else {
            print(error?.localizedDescription ?? "No data")
            return
        }
        let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
        if let responseJSON = responseJSON as? [String: Any] {
            print(responseJSON)
        }
    }

    task.resume();
}

struct LoginForm: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var empid: String = "";
    @State private var password: String = "";
    private let screenWidth: CGFloat = UIScreen.main.bounds.width;
    private let screenHeight: CGFloat = UIScreen.main.bounds.height;
    let v: Void = LoginSubmit();
    var body: some View {
        VStack(spacing: nil) {
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
        }
    }
}

struct ContentView: View {
    @State private var x = LoginResponseBody();
    @Environment(\.colorScheme) var colorScheme
    @State private var empid: String = "";
    @State private var password: String = "";
    @State private var alert = false;
    private let screenWidth: CGFloat = UIScreen.main.bounds.width;
    private let screenHeight: CGFloat = UIScreen.main.bounds.height;
    var body: some View {
        VStack(spacing: nil) {
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
                Alert(title: Text(x.response))
            }
        }
    }
    
    func LoadData() -> Void {
        let route: URL = URL(string: "http://localhost:1995/Login")!
        var request: URLRequest = URLRequest(url: route);
        let requestBody: [String: Any] = ["empid": 40005, "password": "123"];
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
                    self.x = decodedResponse;
                    self.alert = true;
                }
                
                return;
            }
        }.resume();
    }
}

