//
//  ContentView.swift
//  Quotes
//
//  Created by Leo Lu on 2022-02-22.
//

import SwiftUI

struct ContentView: View {
    @State var currentQuote: Quote = Quote(quoteText: "", quoteAuthor: "", senderName: "", senderLink: "", quoteLink: "")
    @State var favourites: [Quote] = []
    @State var currentQuoteAddedToFavourites: Bool = false
    
    var body: some View {
        VStack {
            VStack(spacing: 30) {
                Text(currentQuote.quoteText)
                    .minimumScaleFactor(0.5)
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
                .onTapGesture {
                    if currentQuoteAddedToFavourites == false {
                        favourites.append(currentQuote)
                        currentQuoteAddedToFavourites = true
                    }
                }
                .foregroundColor(currentQuoteAddedToFavourites == true ? .red : .secondary)
            
            Button(action:{
                print("I've been pressed")
                Task {
                    await loadNewQuote()
                }
            }, label: {
                Text("Another one!")
            })
                .buttonStyle(.bordered)
            
            HStack {
                Text("Favourites")
                    .bold()
                
                Spacer()
                
            }
            
            List(favourites, id: \.self) { currentQuote in
                Text(currentQuote.quoteText)
            }
            
            Spacer()
                        
        }
        .task {
            await loadNewQuote()
            print("Have just attempted to load a new quote.")
        }
        .navigationTitle("Quotes")
        .padding()
    }
    
    func loadNewQuote() async {
        let url = URL(string: "https://api.forismatic.com/api/1.0/?method=getQuote&key=457653&format=json&lang=en")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        let urlSession = URLSession.shared
        do {
            let (data, _) = try await urlSession.data(for: request)
            currentQuote = try JSONDecoder().decode(Quote.self, from: data)
            currentQuoteAddedToFavourites = false
        } catch {
            print("Could not retrieve or decode the JSON from endpoint")
            print(error)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContentView()
        }
    }
}
