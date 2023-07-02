//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Shaun Hevey on 2/7/2023.
//

import SwiftUI

//struct Response: Codable {
//    var results: [Result]
//}
//
//struct Result: Codable {
//    var trackId: Int
//    var trackName: String
//    var collectionName: String
//}

struct ContentView: View {
    //    @State private var results = [Result]()
    //
    @State private var username = ""
    @State private var email = ""
    
    var body: some View {
        Form {
            Section {
                TextField("Username", text: $username)
                TextField("Email", text: $email)
            }
            
            Section {
                Button("Create account") {
                    print("Creating account…")
                }
            }
            .disabled(disableForm)
        }
    //        AsyncImage(url: URL(string: "https://hws.dev/img/logo.png")) { phase in
    //            if let image = phase.image {
    //                image
    //                    .resizable()
    //                    .scaledToFit()
    //            } else if phase.error != nil {
    //                Text("There was an error loading the image.")
    //            } else {
    //                ProgressView()
    //            }
    //        }
    //        .frame(width: 200, height: 200)
    
    //        List(results, id: \.trackId) { item in
    //            VStack(alignment: .leading) {
    //                Text(item.trackName)
    //                    .font(.headline)
    //                Text(item.collectionName)
    //            }
    //        }
    //        .task {
    //            await loadData()
    //        }
}
    
    var disableForm: Bool {
        username.count < 5 || email.count < 5
    }
//
//    func loadData() async {
//        guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song") else {
//            print("Invalid URL")
//            return
//        }
//
//        do {
//            let (data, _) = try await URLSession.shared.data(from: url)
//
//            if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
//                results = decodedResponse.results
//            }
//
//        } catch {
//            print("Invalid data")
//        }
//    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
