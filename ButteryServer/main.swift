//
//  main.swift
//  ButteryServer
//
//  Created by Jason Zhang on 8/6/26.
//
import Hummingbird
import Foundation

//Load data
let loader = try await ServerDataLoader.load()
let route = CostRoutes(loader: loader)
//Build router
let router = Router()

router.get("/api/ping", use: route.ping)
router.get("/api/metadata", use: route.getMetaData)
router.get("/api/costs", use: route.getCosts)
router.get("/api/costs/drilldown", use: route.getDrillDown)

let app = Application(router: router, configuration: .init(address: .hostname("localhost", port: 8080)))

print("ButteryServer running on localhost:8080")
try await app.runService()
