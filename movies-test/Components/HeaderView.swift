//
//  HeaderView.swift
//  movies-test
//
//  Created by Paulo Lazarini on 27/12/22.
//

import SwiftUI
import Combine

struct HeaderView: View {
    
    @ObservedObject var viewModel: MainViewModel
    let title: String
    
    @State var searchText: String
    
    init(viewModel: MainViewModel, searchText: String, title: String) {
        self.viewModel = viewModel
        self.title = title
        self.searchText = searchText
    }
    
    
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color.yellow.opacity(0.6)
            VStack(alignment: .center) {
                Text(title)
                    .font(.system(size: 20))
                    .bold()
                    .padding()
                
                
                SearchBar(text: $searchText, viewModel: viewModel).onChange(of: searchResults) { newValue in
                    viewModel.movieSearchedResult = []
                    viewModel.movieSearchedResultFavorite = []
                    for i in 0..<searchResults.count {
                        viewModel.movieSearched.send(newValue[i])
                    }
                }
            }
            .frame(height: 100)
        }
        .frame(height: 140)
        .ignoresSafeArea()
    }

    var searchResults: [String] {
        let sampleData = viewModel.moviesViewData
            .map { String($0.title) }
        
        if searchText.isEmpty {
            return []
        } else {
            return sampleData.filter {
                $0.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    
}

struct SearchBar: View {
    @Binding var text: String
    @ObservedObject var viewModel: MainViewModel

    var body: some View {
        HStack(alignment: .center) {
            TextField("Search...", text: $text)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)
                .multilineTextAlignment(.center)
                .onChange(of: text) { newValue in
                    viewModel.searchTextSubject.send(newValue)
                }

                Button(action: {
                    self.text = ""
                }) {
                    if !text.isEmpty {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                            .font(.system(size: 20))
                            .padding(.horizontal, 5)
                    }
                }
        }
        .padding(.horizontal)
    }
}
