//
//  MovieDetailPeople.swift
//  Movie-SwiftUI-TCA
//
//  Created by XIAOCHUAN HE on R 4/04/22.
//

import SwiftUI
import ComposableArchitecture
import MovieApiFramework

struct MovieDetailPeople: View {
    let store:Store<MovieDetailPeopleState,MovieDetailPeopleAction>
    
    var body: some View {
        
        WithViewStore(store){viewStore in
            Section{
                Text("People")
                    .onAppear{
                        viewStore.send(.load)
                    }
                PeopleList(values: viewStore.casts, title: "Casts")
                PeopleList(values: viewStore.crews, title: "Crews")
            }
            
        }
        
    }
}

struct MovieDetailPeople_Previews: PreviewProvider {
    static var previews: some View {
        List{
            
            MovieDetailPeople(
                store: Store(
                    initialState: MovieDetailPeopleState(movieId: 414906),
                    reducer: movieDetailPeopleReducer,
                    environment: GlobalEveroment.live
                )
            )
        }
    }
}

struct PeopleList: View {
    let values: [People]
    let title: String
    var body: some View {
        VStack(alignment: .leading){
            Text(title)
                .font(.subheadline)
            if values.isEmpty{
                Text("No infomation")
            }else{
                ScrollView(.horizontal){
                    HStack(alignment: .top){
                        ForEach(values,id: \.id){
                            people in
                            PeopleRoundedView(people: people)
                        }
                    }
                }
            }
        }
    }
}
