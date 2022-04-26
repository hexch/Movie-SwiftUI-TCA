//
//  MovieDetail.swift
//  Movie-SwiftUI-TCA
//
//  Created by XIAOCHUAN HE on R 4/04/22.
//

import SwiftUI
import ComposableArchitecture
import MovieApiFramework

struct MovieDetail: View {
    let store: Store<MovieDetailState,MovieDetailAction>
    struct ViewState:Equatable{
        var movie:Movie
        init(state:MovieDetailState){
            self.movie = state.movie
        }
    }
    var body: some View {
        VStack{
            Text("temp")
            WithViewStore(store.scope(state: ViewState.init(state: ))){viewStore in
                List{
                    Text("\(viewStore.movie.id)")
                    MovieDetailMainInfoView(
                        movie: viewStore.movie
                    )
                    if !viewStore.movie.overview.isEmpty{
                        Section(header:Text("Overview")){
                            Text(viewStore.movie.overview)
                                .font(.body)
                        }
                    }
                    MovieDetailPeople(
                        store: store.scope(
                            state: \.peopleState,
                            action: MovieDetailAction.people
                        )
                    )
                }
                .onAppear{
                    viewStore.send(.load)
                    viewStore.send(.people(.load))
                }
                .onDisappear{
                    
                }
                .navigationTitle(viewStore.movie.title)
            }
        }
    }
}

struct MovieDetail_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetail(
            store: Store(
                initialState: MovieDetailState(movie: .sample),
                reducer: movieDetailReducer,
                environment: GlobalEveroment.live
            )
        )
    }
}
