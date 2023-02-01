//
//  Filter.swift
//  movies-test
//
//  Created by Paulo Lazarini on 30/01/23.
//

import SwiftUI
import Combine

struct Filter: View {
    
    @ObservedObject var viewModel: MainViewModel
    var coordinator: Coordinator
    @State var showGenre: Bool = false
    
    var body: some View {
        VStack {
            buildHeader()
            
            Spacer()
            
            buildBody()
        }
        .ignoresSafeArea()
    }
    
    
    func buildHeader() -> some View {
        ZStack {
            HStack {
                Button {
                    coordinator.presentFavoriteMovie()
                } label: {
                    Image(systemName: "chevron.backward")
                        .padding(.top, 30)
                        .padding()
                        .font(.title)
                        .foregroundColor(.black)
                        .bold()
                    
                    Spacer()
                }
            }
            
            HStack {
                
                Spacer()
                Text("Filter")
                    .foregroundColor(.black)
                    .font(.title2)
                    .padding(.top, 30)
                    .padding()
                Spacer()
                
            }
        }
        .background(Color.yellow.opacity(0.5))
        .frame(height: 150)
    }
    
    
    
    
    func buildBody() -> some View {
        ScrollView {
            VStack(spacing: 20) {

                VStack {
                    
                    Button {
                        coordinator.presentFilterGenre()
                    } label: {
                        ZStack {
                            HStack {
                                Text("Genre")
                                
                                Spacer()
                                
                                Image(systemName: "chevron.forward")
                                    .font(.title2)
                            }
                            .padding(.horizontal)
                        }
                    }
                }
                
                Divider()
                    .padding(.horizontal)
                
                Button {
                    coordinator.presentFilterDate()
                } label: {
                    ZStack {
                        HStack {
                            Text("Date")
                            
                            Spacer()
                            
                            Image(systemName: "chevron.forward")
                                .font(.title2)
                        }
                        .padding(.horizontal)
                    }
                }
                
                Divider()
                    .padding(.horizontal)
                
                Spacer()
                
                
            }
        }
        .foregroundColor(.black)
    }
}



struct Filter_Previews: PreviewProvider {
    static var previews: some View {
        Filter(viewModel: MainViewModel(networkProvider: NetworkManager()), coordinator: Coordinator(navigationController: UINavigationController()))
    }
}
