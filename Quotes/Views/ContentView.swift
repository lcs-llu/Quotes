//
//  ContentView.swift
//  Quotes
//
//  Created by Leo Lu on 2022-02-22.
//

import SwiftUI

struct ContentView: View {
    @State var currentQuote: Quote = Quote(quoteText: "", quoteAuthor: "", senderName: "", senderLink: "", quoteLink: "")
    var body: some View {
        VStack {
            VStack(spacing: 30) {
                Text(currentQuote.quoteText)
                HStack {
                    Spacer()
                    Text("- \(currentQuote.quoteAuthor)")
                        .font(.caption)
                        .italic()
                }
            }
                .multilineTextAlignment(.leading)
                .padding(30)
                .overlay(
                    Rectangle()
                        .stroke(Color.primary, lineWidth: 4)
                )
                .padding(10)
            
           Image(systemName: "heart.circle")
                .resizable()
                .frame(width: 40, height: 40)
            
            Button(action:{
                print("I've been pressed")
            }, label: {
                Text("Another one!")
            })
                .buttonStyle(.bordered)
            
            HStack {
                Text("Favourites")
                    .bold()
                
                Spacer()
                
            }
            
            List {
                Text("Which side of the chicken has more feathers? The outside.")
                Text("Why did the Clydesdale give the pony a glass of water? Because he was a little horse!")
                Text("The great thing about stationery shops is they're always in the same place...")
            }
            
            Spacer()
                        
        }
        .task {
            let url = URL(string: "https://api.forismatic.com/api/1.0/?method=getQuote&key=457653&format=json&lang=en")!
            var request = URLRequest(url: url)
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            let urlSession = URLSession.shared
            do {
                let (data, _) = try await urlSession.data(for: request)
                currentQuote = try JSONDecoder().decode(Quote.self, from: data)
            } catch {
                print("Could not retrieve or decode the JSON from endpoint")
                print(error)
            }
        }
        .navigationTitle("Quotes")
        .padding()
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContentView()
        }
    }
}
