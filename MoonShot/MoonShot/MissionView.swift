//
//  MissionView.swift
//  MoonShot
//
//  Created by Cao Mai on 5/25/21.
//

import SwiftUI

struct MissionView: View {
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }
    let astronauts: [CrewMember]
    let mission: Mission

    var body: some View {
        GeometryReader { geometry in
                    ScrollView(.vertical) {
                        VStack {
                            Image(self.mission.image)
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: geometry.size.width * 0.7)
                                .padding(.top)

                            Text(self.mission.description)
                                .padding()

                            Spacer(minLength: 25)
                            
                            ForEach(self.astronauts, id: \.role) { crewMember in
                                HStack {
                                    Image(crewMember.astronaut.id)
                                        .resizable()
                                        .frame(width: 83, height: 60)
                                        .clipShape(Capsule())
                                        .overlay(Capsule().stroke(Color.primary, lineWidth: 1))

                                    VStack(alignment: .leading) {
                                        Text(crewMember.astronaut.name)
                                            .font(.headline)
                                        Text(crewMember.role)
                                            .foregroundColor(.secondary)
                                    }

                                    Spacer()
                                }
                                .padding(.horizontal)
                            }
                        }
                    }
                }
                .navigationBarTitle(Text(mission.displayName), displayMode: .inline)
    }
    
    init(mission: Mission, astronauts: [Astronaut]) {
        self.mission = mission
        var matches = [CrewMember]()

        for member in mission.crew {
            if let matchAstronaut = astronauts.first(where: { $0.id == member.name }) {
                matches.append(CrewMember(role: member.role, astronaut: matchAstronaut))
            } else {
                fatalError("Missing \(member)")
            }
        }
        self.astronauts = matches
    }
}

struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")

    static var previews: some View {
        MissionView(mission: missions[0], astronauts: astronauts)
    }
}
