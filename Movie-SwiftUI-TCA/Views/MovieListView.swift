//
//  MovieList.swift
//  Movie-SwiftUI-TCA
//
//  Created by XIAOCHUAN HE on R 4/04/21.
//

import SwiftUI
import ComposableArchitecture
import MovieApiFramework

struct MovieListView<Content: View>: View {
    let store: Store<MovieListState,MovieListAction>
    let title: Content
    init(
        store:Store<MovieListState,MovieListAction>,
        @ViewBuilder title:()-> Content
    ) {
        self.store = store
        self.title = title()
    }
    var body: some View {
        VStack(alignment:.leading,spacing: 2){
            HStack{
                title
                Spacer()
            }
            WithViewStore(store){viewStore in
                VStack{
                    if viewStore.loading{
                        SimpleMoviePosterPlaceHolderView()
                    }else{
                        MoviePostersView(movies: viewStore.movies)
                    }
                }
                .onAppear{
                    viewStore.send(.load)
                }
                
            }
        }
        .padding(.leading, 5)
        .padding(.trailing, 5)
    }
}

struct MovieListView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView(
            store: Store(
                initialState: MovieListState(),
                reducer: movieListReducer,
                environment: PopularMovieListEnveroment()
            )
        ){
            Text("abc")
                .font(.system(size: 18))
        }
    }
}
