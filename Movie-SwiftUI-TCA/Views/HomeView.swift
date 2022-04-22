//
//  HomeView.swift
//  Movie-SwiftUI-TCA
//
//  Created by XIAOCHUAN HE on R 4/04/21.
//

import SwiftUI
import ComposableArchitecture

struct HomeView: View {
    let store:Store<HomeState,HomeAction>
    
    var body: some View {
        NavigationView{
            ScrollView(.vertical){
                VStack{
                    WithViewStore(self.store.stateless){_ in
                        MovieListView(store:self.store.scope(state: \.popular, action: HomeAction.popular)){
                            Text("popular")
                                .font(.system(size: 18))
                        }
                        MovieListView(store:self.store.scope(state: \.toprated, action: HomeAction.topRated)){
                            Text("Top Rated")
                                .font(.system(size: 18))
                        }
                        MovieListView(store:self.store.scope(state: \.upcoming, action: HomeAction.upcoming)){
                            Text("Upcoming")
                                .font(.system(size: 18))
                        }
                        MovieListView(store:self.store.scope(state: \.nowplaying, action: HomeAction.nowPlaying)){
                            Text("Now Playing")
                                .font(.system(size: 18))
                        }
                    }
                }
                .navigationTitle("Movie Library")
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(
            store: Store(
                initialState: HomeState(),
                reducer: homeReducer,
                environment: HomeEnveroment()
            )
        )
    }
}
