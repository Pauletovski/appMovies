//
//  FavoriteView.swift
//  movies-test
//
//  Created by Paulo Lazarini on 27/01/23.
//

import SwiftUI


struct FavoriteView: View {
    
    @ObservedObject var viewModel: MainViewModel
    var coordinator: Coordinator
    @State var searchText: String = ""
    
    var body: some View {
        ZStack {
            
            VStack {
                HeaderView(viewModel: viewModel, searchText: searchText, title: "Favorite")
                
                Spacer()
                
                if viewModel.movieSearchedResult.isEmpty {
                    if viewModel.searchText == "" {
                        FavoriteMovieGridView(viewModel: viewModel).onAppear {
                            viewModel.getFavoriteMovies()
                        }
                    } else {
                        NotFound(viewModel: viewModel)
                    }
                } else {
                    ResultFavoriteMovieGridView(viewModel: viewModel)
                }

                
                Spacer()
                
                FooterView(viewModel: viewModel, coordinator: coordinator)
            }
            
        }.onAppear {
            self.viewModel.movieSearchedResult = []
            self.viewModel.movieSearchedResultFavorite = []
        }
        .ignoresSafeArea()
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
}

struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteView(viewModel: MainViewModel(networkProvider: NetworkManager()), coordinator: Coordinator(navigationController: UINavigationController()))
    }
}
