//
//  know.swift
//  FYP
//
//  Created by Waiyi on 15/5/2024.
//


import Foundation
struct Level {
  let title: String
  let imageName: String
    let id = UUID()
}

extension Level: Identifiable { }
let leveldata = [
    Level(title: "dayNightCycle", imageName: "1"),
    Level(title: "timeZones", imageName: "2"),
    Level(title: "temperatureVariation", imageName: "3"),
    Level(title: "seasons", imageName: "4"),
    Level(title: "moonSurface", imageName: "5"),
    Level(title: "moonPhases", imageName: "6"),
    Level(title: "solarEclipse", imageName: "7"),
    Level(title: "lunarEclipse", imageName: "8"),
    Level(title: "solarSystem", imageName: "9"),
    Level(title: "spaceExploration", imageName: "10"),
    Level(title: "telescopes", imageName: "11"),
    Level(title: "rockets", imageName: "12"),
    Level(title: "spaceMilestones", imageName: "13"),
    Level(title: "spaceEnvironment", imageName: "14"),
    Level(title: "spaceBenefits", imageName: "15"),
    Level(title: "satellites", imageName: "16"),
    Level(title: "spaceJunk", imageName: "17"),
    
]
