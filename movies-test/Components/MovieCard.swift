//
//  MovieCard.swift
//  movies-test
//
//  Created by Paulo Lazarini on 27/12/22.
//

import SwiftUI
import NukeUI
import Combine

struct MovieCard: View {
    
    @State var showBottomSheet = false
    
    let text:String
    let image:String
    let id: Int
    let releaseDate: String
    let overview: String
    

    @State var isFavorite: Bool
    var toggleFavorite = PassthroughSubject<Bool, Never>()

    
    var body: some View {
        VStack(spacing: 0) {
            
            Button {
                showBottomSheet.toggle()
            } label: {
                ZStack {
                    LazyImage(source: URL(string: "https://image.tmdb.org/t/p/w500\(image)"))
                }
                .sheet(isPresented: $showBottomSheet) {
                    BottomSheet(image: self.image, title: self.text, id: self.id, overview: self.overview, releaseDate: self.releaseDate)
                        .presentationDetents([.large])
                        .presentationDragIndicator(.visible)
                }
            }

            
            ZStack(alignment: .center) {
                Color.gray
                HStack {

                    Text(text)
                        .bold()
                        .padding(.leading)
                

                    
                    Spacer()
                    
                    Button {
                        isFavorite.toggle()
                        toggleFavorite.send(isFavorite)
                    } label: {
                        
                        if isFavorite == true {
                            favoriteSelected()
                        } else {
                            favoriteUnselected()
                        }
                    }
                }
                .padding(.trailing)
            }
            .frame(height: 50)
        }
    }
    func favoriteUnselected() -> some View {
        Image(systemName: "heart.fill")
            .imageScale(.large)
            .foregroundColor(.white)
    }
    
    func favoriteSelected() -> some View {
        Image(systemName: "heart.fill")
            .imageScale(.large)
            .foregroundColor(.yellow)


    }

    
}

