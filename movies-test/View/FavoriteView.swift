//
//  FavoriteView.swift
//  movies-test
//
//  Created by Paulo Lazarini on 27/01/23.
//

import SwiftUI


struct FavoriteView: View {
    
    @ObservedObject var viewModel: MainViewModel
    @State var searchText: String = ""
    var coordinator: Coordinator
    
    var body: some View {
        ZStack { 
            VStack(spacing: .zero) {
                
                HeaderView(viewModel: viewModel, searchText: searchText, title: "Favorite")
                
                if !viewModel.hasFilter {
                    Button {
                        coordinator.presentFilter()
                    } label: {
                        Rectangle()
                            .frame(height: 50)
                            .foregroundColor(.black.opacity(0.7))
                            .overlay {
                                Text(verbatim: "Add Filter")
                                    .font(.system(size: 25))
                                    .bold()
                                    .foregroundColor(.yellow)
                            }
                    }
                    
                } else {
                    Button {
                        viewModel.hasFilter = false
                        viewModel.genreMovieList = []
                        viewModel.dateMovieList = []
                        coordinator.presentFavoriteMovie()
                    } label: {
                        Rectangle()
                            .frame(height: 50)
                            .foregroundColor(.black.opacity(0.7))
                            .overlay {
                                Text(verbatim: "Remove Filter")
                                    .font(.system(size: 25))
                                    .bold()
                                    .foregroundColor(.yellow)
                            }
                        
                    }
                }

                Spacer()
                
                if viewModel.movieSearchedResult.isEmpty {
                    if viewModel.searchText == "" {
                        FavoriteMovieGridView(viewModel: viewModel)
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
            if !viewModel.hasFilter {
                viewModel.getFavoriteMovies()
            }
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
