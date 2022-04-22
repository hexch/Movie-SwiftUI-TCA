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
                    movieId: viewStore.movieId,
                    backdropUrl: viewStore.backdropUrl,
                    releaseDate: viewStore.releaseDate,
                    runtime: viewStore.runtime,
                    rating: viewStore.rating,
                    voteCount: viewStore.voteCount,
                    genres: viewStore.genres
                )
                if !viewStore.overview.isEmpty{
                    Section(header:Text("Overview")){
                        Text(viewStore.overview)
                            .font(.body)
                    }
                }
            }
            .onAppear{
                viewStore.send(.load)
            }
            .navigationTitle(viewStore.title)
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
