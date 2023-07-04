//
//  ContentView.swift
//  SnowResorts
//
//  Created by Theós on 04/07/2023.
//

import SwiftUI

struct ContentView: View {
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    
    @StateObject var favorites = Favorites()
    @State private var searchText = ""
    @State private var sort: SortType = .default
    @State private var isShowingSort = false
        
    var body: some View {
        NavigationView {
            List(sortedResorts) { resort in
                NavigationLink {
                    ResortView(resort: resort)
                } label: {
                    HStack {
                        Image(resort.country)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 25)
                            .clipShape(
                                RoundedRectangle(cornerRadius: 5)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(.gray, lineWidth: 1)
                            )
                        
                        VStack(alignment: .leading) {
                            Text(resort.name)
                                .font(.headline)
                            Text("\(resort.runs) runs")
                                .foregroundColor(.secondary)
                        }
                        
                        if favorites.contains(resort) {
                            Spacer()
                            Image(systemName: "heart.fill")
                                .accessibilityLabel("This is a favorite resort")
                                .foregroundColor(.red)
                        }
                    }
                }
            }
            .navigationTitle("Resorts")
            .searchable(text: $searchText, prompt: "Search for a resort")
            .toolbar {
                Button {
                    isShowingSort.toggle()
                } label: {
                    Label("Sort", systemImage: "arrow.up.arrow.down")
                }
                .font(.headline)
            }
            .confirmationDialog("Sort resorts by", isPresented: $isShowingSort, titleVisibility: .visible) {
                Button("Default") {
                    sort = .`default`
                }
                Button("Name") {
                    sort = .name
                }
                Button("Country") {
                    sort = .country
                }
            }
            
            WelcomeView()
        }
        .environmentObject(favorites)
    }
    
    var filteredResorts: [Resort] {
        if searchText.isEmpty {
            return resorts
        } else {
            return resorts.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var sortedResorts: [Resort] {
        switch sort {
        case .`default`:
            return filteredResorts
        case .name:
            return filteredResorts.sorted { $0.name < $1.name }
        case .country:
            return filteredResorts.sorted {
                $0.country < $1.country
            }
        }
    }
}

extension ContentView {
    enum SortType {
        case `default`, name, country
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
