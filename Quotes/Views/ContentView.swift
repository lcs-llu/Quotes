//
//  ContentView.swift
//  Quotes
//
//  Created by Leo Lu on 2022-02-22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            
            Text("How do you organize a space party? You planet.")
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
                Text("Favourates")
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
