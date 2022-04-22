//
//  PeopleRoundedView.swift
//  Movie-SwiftUI-TCA
//
//  Created by XIAOCHUAN HE on R 4/04/22.
//

import SwiftUI
import MovieApiFramework
import Kingfisher

struct PeopleRoundedView: View {
    let people: People
    var body: some View {
        VStack{
            KFImage(people.profileUrl)
                .placeholder{
                    Rectangle()
                        .foregroundColor(.gray)
                        .peopleStyle()
                }
                .resizable()
                .renderingMode(.original)
                .aspectRatio(contentMode: .fit)
                .peopleStyle()
            Text(people.name)
                .font(.footnote)
        }
        .frame(width:80)
    }
}

struct PeopleRoundedView_Previews: PreviewProvider {
    static var previews: some View {
        PeopleRoundedView(people: CastResponse.sample[0])
    }
}
