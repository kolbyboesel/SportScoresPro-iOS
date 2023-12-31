//
//  HomeView.swift
//  SportScoresPro
//
//  Created by Kolby Boesel on 12/22/23.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var logoFetcher : LogoFetcher
    @EnvironmentObject var settings: UserSettings
    
    @State var notificationToggle: Bool = false
    @State var locationUsage: Bool = false
    
    @State var showDropdownBtn: Bool = false
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationStack{
            VStack(spacing: 0) {
                if(settings.userFavorites.count == 0 && settings.teamFavorites.count == 0){
                    WelcomeMessage()
                        .environmentObject(settings)
                        .padding()
                    Spacer()
                    
                } else {
                    FavoritesView(logoFetcher: logoFetcher)
                        .environmentObject(settings)
                }
            }
            .frame(maxWidth: .infinity)
            .frame(maxHeight: .infinity)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack {
                        Image("home-logo")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 30)
                    }
                    .padding()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: FavoritesSelection(logoFetcher: logoFetcher)
                        .environmentObject(settings)) {
                            HStack {
                                Image(systemName: "star.fill" )
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 25, height: 25)
                                    .padding(.top, 5)
                                    .padding(.trailing, 5)
                                    .padding(.bottom, 5)
                                    .foregroundColor(.white)
                                
                            }
                        }
                }
            }
            .background(Color(.systemGray6))
            .frame(maxHeight: .infinity)
        }
    }
}

struct WelcomeMessage: View {
    @EnvironmentObject var settings: UserSettings

    @State var notificationToggle: Bool = false
    @State var locationUsage: Bool = false
    
    var body: some View {
        VStack(spacing: 20) {
            
            Text("Welcome to Sport Scores")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(Color.SportScoresRed)
                .multilineTextAlignment(.center)
            
            Text("Click the star in the top right to choose your favorite sports, and they will appear here!")
                .font(.body)
                .multilineTextAlignment(.center)
                .foregroundColor(Color.secondary)
            
            if(!settings.loggedIn) {
                Text("You can also create an account for $5 per month with a 7 day free trial. See the about section for more information about the benefits of creating an account.")
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color.secondary)
            }
        }
        .padding(20)
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .padding()
    }
}


