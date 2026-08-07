//
//  main.swift
//  ButteryServer
//
//  Created by Jason Zhang on 8/6/26.
//

import Hummingbird

let router = Router()

router.get("/ping") {
    request, context in return "pong"
}

let app = Application(router: router, configuration: .init(address: .hostname("localhost", port: 8080)))

try await app.runService()
