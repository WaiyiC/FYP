//
//  know.swift
//  FYP
//
//  Created by Waiyi on 15/5/2024.
//


import Foundation
struct know {
  let title: String
  let imageName: String

}


let jsonData: [String: Any] = [
    "dayNightCycle": [
        imageName: "1"
    ],
    "timeZones": [
        "description": "Different places receive sunlight at different times as the Earth rotates. Therefore, the Earth is divided into different time zones."
    ],
    "temperatureVariation": [
        "description": "The Earth is round, so different areas receive sunlight at different angles. Sunlight is more focused in areas with overhead sunlight, so the temperature there is generally higher. Sunlight is less focused in areas with slanted sunlight, so the temperature there is generally lower."
    ],
    "seasons": [
        "description": "A complete revolution of the Earth takes a year. Since the axis of rotation is tilted, different places receive overhead sunlight at different times. This results in the changes of seasons."
    ],
    "moonSurface": [
        "description": "The surface of the Moon is rough and full of craters."
    ],
    "moonPhases": [
        "description": "We can see different phases of the Moon when it is in different positions during its revolution around the Earth. It takes about 30 days to complete one lunar cycle."
    ],
    "solarEclipse": [
        "description": "A solar eclipse occurs when the Moon moves in between the Earth and the Sun. As a result, we see that the Sun is blocked by the Moon."
    ],
    "lunarEclipse": [
        "description": "A lunar eclipse occurs when the Earth moves in between the Moon and the Sun, as the Earth blocks sunlight from shining on the Moon."
    ],
    "solarSystem": [
        "description": "There are many galaxies in the universe. The Earth is a member of the Solar System, which is a planetary system in the Milky Way Galaxy."
    ],
    "spaceExploration": [
        "description": "Humans explore space to improve world safety, develop new technology, search for resources, know more about changes on the Earth, learn more about science and the universe, and find other celestial bodies to live on."
    ],
    "telescopes": [
        "description": "Scientists invent and use telescopes to study space."
    ],
    "rockets": [
        "description": "Rockets are used to launch machines such as spacecraft and artificial satellites into space. A large amount of gas is produced to launch the rocket."
    ],
    "spaceMilestones": [
        [
            "year": 1957,
            "event": "The first artificial satellite was sent to orbit the Earth."
        ],
        [
            "year": 1969,
            "event": "Two American astronauts became the first humans to walk on the Moon."
        ],
        [
            "year": 2000,
            "event": "The International Space Station came into operation. It allows astronauts to stay in space longer."
        ],
        [
            "year": 2003,
            "event": "China launched its first manned spacecraft."
        ],
        [
            "year": 2013,
            "event": "China's first lunar rover landed on the Moon."
        ]
    ],
    "spaceEnvironment": [
        "description": "The environment in space is very different from the environment on the Earth's surface. There is no oxygen or air pressure in space. The level of radiation is high and dust flies at great speed. Temperatures are extreme. People and objects float in space."
    ],
    "spaceBenefits": [
        "description": "Many everyday products and technologies such as air-cushioned shoes and drink pouches are developed using space technology. The weightless environment in space allows scientists to conduct different kinds of scientific research including space farming to improve the nutrition and yield of crops."
    ],
    "satellites": [
        "description": "Artificial satellites orbiting the Earth can be used for communication, navigation, and weather forecasts."
    ],
    "spaceJunk": [
        "description": "Space technology brings many benefits, but it also causes problems. Space junk such as non-functional and used rocket stages can affect operating artificial satellites and space stations. They may cause damage if they fall to the Earth."
    ]
]

do {
    let jsonData = try JSONSerialization.data(withJSONObject: jsonData, options: .prettyPrinted)
    if let jsonString = String(data: jsonData, encoding: .utf8) {
        print(jsonString)
    }
} catch {
    print("Error: Unable to convert data to JSON")
}
```

This code creates a dictionary called `jsonData` where each section of the provided information isstored as a key-value pair. The keys represent the different topics, such as "dayNightCycle," "timeZones," "temperatureVariation," and so on. The values are dictionaries with a single key-value pair, where the key is "description" and the value is the corresponding description for that topic.

The code then uses `JSONSerialization` to convert the `jsonData` dictionary into JSON data. Finally, it converts the JSON data into a string (`jsonString`) and prints it.

When you run this code, you'll see the JSON representation of the provided information printed in the console in a formatted manner.

Note: The code assumes the use of Swift 4 or later.
