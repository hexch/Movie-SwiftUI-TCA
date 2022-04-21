//
//  TestAppView.swift
//  Movie-SwiftUI-TCA
//
//  Created by XIAOCHUAN HE on R 4/04/21.
//

import SwiftUI
import ComposableArchitecture

struct TestAppView: View {
    let store : Store<TestAppState,TestAppAction>
    var body: some View {
        NavigationView{
            WithViewStore(store){viewStore in
                VStack{
                    if viewStore.loadingGenres{
                        ProgressView()
                        Text("Loading")
                    }else{
                        List{
                            ForEach(viewStore.genres,id:\.self){genre in
                                Text(genre.name)
                            }
                        }
                    }
                }.onAppear(perform: {
                    viewStore.send(.loadGenres)
                })
                .navigationTitle("Movie Library")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(trailing: Button(action: {
                    viewStore.send(.loadGenres)
                }){
                    Image(systemName: "arrow.clockwise.circle")
                })
            }
            
        }
    }
}

struct TestAppView_Previews: PreviewProvider {
    static var previews: some View {
        TestAppView(store: .init(
            initialState: TestAppState(),
            reducer: testAppReducer,
            environment: TestAppEnveroment.live
        ))
    }
}
