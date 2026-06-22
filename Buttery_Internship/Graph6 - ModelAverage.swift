//
//  Graph6 - ModelAverage.swift
//  Buttery_Internship
//
//  Created by Jason Zhang on 6/21/26.
//
let modelsLookUp = Dictionary(uniqueKeysWithValues: sampleData.models.map { ($0.id, $0.displayName) })


let modelsGraphData = MakeGenericGraph(groupBy: {modelLookUp[$0.modelId] ?? "Unknown"},
                                      metric: {$0.costCents / Double($0.queryCount)}, dayLimit: 30)


//MARK: Graph4 View
let modelsGraph = GenericGraph(data: modelGraphData,
                              title: "Model Average Cost-Time Graph (2026)",
                              ylabel: "Average Cost (Cents)",
                              isDelta: false)
//MARK: Database 4
let modelsDataTable = GenericDataTable(data: modelGraphData,
                                      title: "Model Average Cost-Time Table",
                                      category: "ModelId",
                                      isDelta: false)

