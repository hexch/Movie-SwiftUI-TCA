//
//  MovieDetail.swift
//  Movie-SwiftUI-TCA
//
//  Created by XIAOCHUAN HE on R 4/04/22.
//

import SwiftUI
import ComposableArchitecture

struct MovieDetail: View {
    let store: Store<MovieDetailState,MovieDetailAction>
    
    var body: some View {
        WithViewStore(store){viewStore in
            List{
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
            .navigationTitle(viewStore.movie.title)
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
