import Foundation
import CoreLocation

struct PathNode {
    let id: String
    let coordinate: CLLocationCoordinate2D
}

struct PathEdge {
    let from: String
    let to: String
    let isAccessible: Bool
    let isBlocked: Bool
    let distanceMultiplier: Double

    init(
        from: String,
        to: String,
        isAccessible: Bool = true,
        isBlocked: Bool = false,
        distanceMultiplier: Double = 1.0
    ) {
        self.from = from
        self.to = to
        self.isAccessible = isAccessible
        self.isBlocked = isBlocked
        self.distanceMultiplier = distanceMultiplier
    }
}

struct CampusPathData {
    static let startNodeID = "main_gate"

    static let nodes: [PathNode] = [
        PathNode(
            id: "main_gate",
            coordinate: CLLocationCoordinate2D(
                latitude: 37.58242182870707,
                longitude: 127.01110631100151
            )
        ),
        PathNode(
            id: "main_gate_inner",
            coordinate: CLLocationCoordinate2D(
                latitude: 37.5824300,
                longitude: 127.0108800
            )
        ),
        PathNode(
            id: "future_south_east_walk",
            coordinate: CLLocationCoordinate2D(
                latitude: 37.5822800,
                longitude: 127.0107200
            )
        ),
        PathNode(
            id: "future_south_west_walk",
            coordinate: CLLocationCoordinate2D(
                latitude: 37.5823000,
                longitude: 127.0102600
            )
        ),
        PathNode(
            id: "sangsang_south_walk",
            coordinate: CLLocationCoordinate2D(
                latitude: 37.5822800,
                longitude: 127.0100600
            )
        ),
        PathNode(
            id: "research_east_walk",
            coordinate: CLLocationCoordinate2D(
                latitude: 37.5821900,
                longitude: 127.0099300
            )
        ),
        PathNode(
            id: "research_front_walk",
            coordinate: CLLocationCoordinate2D(
                latitude: 37.5821500,
                longitude: 127.0096500
            )
        ),
        PathNode(
            id: "west_spine_south",
            coordinate: CLLocationCoordinate2D(
                latitude: 37.5819000,
                longitude: 127.0097400
            )
        ),
        PathNode(
            id: "west_spine_middle",
            coordinate: CLLocationCoordinate2D(
                latitude: 37.5824500,
                longitude: 127.0096500
            )
        ),
        PathNode(
            id: "west_spine_north",
            coordinate: CLLocationCoordinate2D(
                latitude: 37.5830800,
                longitude: 127.0095200
            )
        ),
        PathNode(
            id: "tamgu_west_walk",
            coordinate: CLLocationCoordinate2D(
                latitude: 37.5834300,
                longitude: 127.0092600
            )
        ),
        PathNode(
            id: "cube_walk",
            coordinate: CLLocationCoordinate2D(
                latitude: 37.5837700,
                longitude: 127.0094300
            )
        ),
        PathNode(
            id: "center_cross_walk",
            coordinate: CLLocationCoordinate2D(
                latitude: 37.5825500,
                longitude: 127.0099500
            )
        ),
        PathNode(
            id: "jinri_south_walk",
            coordinate: CLLocationCoordinate2D(
                latitude: 37.5827600,
                longitude: 127.0097800
            )
        ),
        PathNode(
            id: "haksong_south_walk",
            coordinate: CLLocationCoordinate2D(
                latitude: 37.5831200,
                longitude: 127.0097800
            )
        ),
        PathNode(
            id: "woochon_west_walk",
            coordinate: CLLocationCoordinate2D(
                latitude: 37.5828400,
                longitude: 127.0103800
            )
        ),
        PathNode(
            id: "woochon_east_walk",
            coordinate: CLLocationCoordinate2D(
                latitude: 37.5829300,
                longitude: 127.0107400
            )
        ),
        PathNode(
            id: "naksan_entry_walk",
            coordinate: CLLocationCoordinate2D(
                latitude: 37.5822200,
                longitude: 127.0109500
            )
        ),
        PathNode(
            id: "changui_front_walk",
            coordinate: CLLocationCoordinate2D(
                latitude: 37.5820400,
                longitude: 127.0106500
            )
        ),
        PathNode(
            id: "village_access_walk",
            coordinate: CLLocationCoordinate2D(
                latitude: 37.5816500,
                longitude: 127.0099400
            )
        ),
        PathNode(
            id: "engineeringB_access_walk",
            coordinate: CLLocationCoordinate2D(
                latitude: 37.5816500,
                longitude: 127.0096500
            )
        ),

        PathNode(id: "jinri_node", coordinate: CLLocationCoordinate2D(latitude: 37.5830056, longitude: 127.0095493)),
        PathNode(id: "village_node", coordinate: CLLocationCoordinate2D(latitude: 37.5814749, longitude: 127.0100350)),
        PathNode(id: "haksong_node", coordinate: CLLocationCoordinate2D(latitude: 37.5833111, longitude: 127.0095215)),
        PathNode(id: "research_node", coordinate: CLLocationCoordinate2D(latitude: 37.5821500, longitude: 127.0095500)),
        PathNode(id: "naksan_node", coordinate: CLLocationCoordinate2D(latitude: 37.5820891, longitude: 127.0113547)),
        PathNode(id: "woochon_node", coordinate: CLLocationCoordinate2D(latitude: 37.5830056, longitude: 127.0106048)),
        PathNode(id: "insung_node", coordinate: CLLocationCoordinate2D(latitude: 37.5819224, longitude: 127.0107715)),
        PathNode(id: "tamgu_node", coordinate: CLLocationCoordinate2D(latitude: 37.5834222, longitude: 127.0091327)),
        PathNode(id: "changui_node", coordinate: CLLocationCoordinate2D(latitude: 37.5821168, longitude: 127.0107714)),
        PathNode(id: "engineeringA_node", coordinate: CLLocationCoordinate2D(latitude: 37.5818453, longitude: 127.0098608)),
        PathNode(id: "engineeringB_node", coordinate: CLLocationCoordinate2D(latitude: 37.5815344, longitude: 127.00958629)),
        PathNode(id: "grass_node", coordinate: CLLocationCoordinate2D(latitude: 37.5827000, longitude: 127.0095000)),
        PathNode(id: "sangsang_node", coordinate: CLLocationCoordinate2D(latitude: 37.5827687, longitude: 127.01021762)),
        PathNode(id: "jiseon_node", coordinate: CLLocationCoordinate2D(latitude: 37.5820255, longitude: 127.0097580)),
        PathNode(id: "future_node", coordinate: CLLocationCoordinate2D(latitude: 37.5825885, longitude: 127.0107298)),
        PathNode(id: "valley_node", coordinate: CLLocationCoordinate2D(latitude: 37.5840099, longitude: 127.00939697))
    ]

    static let edges: [PathEdge] = [
        PathEdge(from: "main_gate", to: "main_gate_inner"),
        PathEdge(from: "main_gate_inner", to: "future_south_east_walk"),
        PathEdge(from: "future_south_east_walk", to: "future_south_west_walk"),
        PathEdge(from: "future_south_west_walk", to: "sangsang_south_walk"),
        PathEdge(from: "sangsang_south_walk", to: "research_east_walk"),
        PathEdge(from: "research_east_walk", to: "research_front_walk"),

        PathEdge(from: "research_front_walk", to: "west_spine_south"),
        PathEdge(from: "research_front_walk", to: "west_spine_middle"),
        PathEdge(from: "west_spine_middle", to: "west_spine_north"),
        PathEdge(from: "west_spine_north", to: "tamgu_west_walk"),
        PathEdge(from: "tamgu_west_walk", to: "cube_walk"),
        PathEdge(from: "west_spine_middle", to: "center_cross_walk"),
        PathEdge(from: "center_cross_walk", to: "jinri_south_walk"),
        PathEdge(from: "jinri_south_walk", to: "haksong_south_walk"),
        PathEdge(from: "haksong_south_walk", to: "tamgu_west_walk"),

        PathEdge(from: "center_cross_walk", to: "sangsang_south_walk"),
        PathEdge(from: "sangsang_south_walk", to: "woochon_west_walk"),
        PathEdge(from: "woochon_west_walk", to: "woochon_east_walk"),
        PathEdge(from: "future_south_east_walk", to: "naksan_entry_walk"),
        PathEdge(from: "future_south_west_walk", to: "changui_front_walk"),
        PathEdge(from: "changui_front_walk", to: "naksan_entry_walk"),

        PathEdge(from: "west_spine_south", to: "village_access_walk"),
        PathEdge(from: "village_access_walk", to: "engineeringB_access_walk"),

        PathEdge(from: "jinri_south_walk", to: "jinri_node"),
        PathEdge(from: "haksong_south_walk", to: "haksong_node"),
        PathEdge(from: "tamgu_west_walk", to: "tamgu_node"),
        PathEdge(from: "cube_walk", to: "valley_node", distanceMultiplier: 1.2),
        PathEdge(from: "research_front_walk", to: "research_node"),
        PathEdge(from: "west_spine_south", to: "jiseon_node"),
        PathEdge(from: "west_spine_south", to: "engineeringA_node"),
        PathEdge(from: "village_access_walk", to: "village_node"),
        PathEdge(from: "engineeringB_access_walk", to: "engineeringB_node"),
        PathEdge(from: "west_spine_middle", to: "grass_node"),
        PathEdge(from: "sangsang_south_walk", to: "sangsang_node"),
        PathEdge(from: "woochon_east_walk", to: "woochon_node"),
        PathEdge(from: "future_south_east_walk", to: "future_node"),
        PathEdge(from: "changui_front_walk", to: "changui_node"),
        PathEdge(from: "changui_front_walk", to: "insung_node"),
        PathEdge(from: "naksan_entry_walk", to: "naksan_node")
    ]

    static let buildingNodeMap: [String: String] = [
        "진리관": "jinri_node",
        "상상빌리지": "village_node",
        "학송관": "haksong_node",
        "연구관": "research_node",
        "낙산관": "naksan_node",
        "우촌관": "woochon_node",
        "인성관": "insung_node",
        "탐구관": "tamgu_node",
        "창의관": "changui_node",
        "공학관A": "engineeringA_node",
        "공학관B": "engineeringB_node",
        "잔디광장": "grass_node",
        "상상관": "sangsang_node",
        "지선관": "jiseon_node",
        "미래관": "future_node",
        "상상밸리": "valley_node"
    ]

    private static let nodeByID: [String: PathNode] = Dictionary(
        uniqueKeysWithValues: nodes.map { ($0.id, $0) }
    )

    static func shortestPathCoordinates(
        from startID: String = startNodeID,
        to destinationID: String,
        requiresAccessibleRoute: Bool = true
    ) -> [CLLocationCoordinate2D]? {
        guard nodeByID[startID] != nil, nodeByID[destinationID] != nil else {
            return nil
        }

        var distances = Dictionary(uniqueKeysWithValues: nodes.map { ($0.id, Double.infinity) })
        var previousNodes: [String: String] = [:]
        var unvisitedNodeIDs = Set(nodes.map { $0.id })

        distances[startID] = 0

        while let currentID = unvisitedNodeIDs.min(by: { (distances[$0] ?? .infinity) < (distances[$1] ?? .infinity) }) {
            let currentDistance = distances[currentID] ?? .infinity
            if currentDistance == .infinity { break }
            if currentID == destinationID { break }

            unvisitedNodeIDs.remove(currentID)

            for connection in connections(from: currentID, requiresAccessibleRoute: requiresAccessibleRoute) {
                guard unvisitedNodeIDs.contains(connection.nodeID) else { continue }

                let candidateDistance = currentDistance + connection.cost
                if candidateDistance < (distances[connection.nodeID] ?? .infinity) {
                    distances[connection.nodeID] = candidateDistance
                    previousNodes[connection.nodeID] = currentID
                }
            }
        }

        guard distances[destinationID] != .infinity else {
            return nil
        }

        let pathIDs = makePathIDs(to: destinationID, previousNodes: previousNodes)
        return pathIDs.compactMap { nodeByID[$0]?.coordinate }
    }

    static func pathCoordinates(toBuildingName buildingName: String) -> [CLLocationCoordinate2D]? {
        guard let destinationID = buildingNodeMap[buildingName] else {
            return nil
        }

        return shortestPathCoordinates(to: destinationID)
    }

    private static func connections(
        from nodeID: String,
        requiresAccessibleRoute: Bool
    ) -> [(nodeID: String, cost: Double)] {
        edges.compactMap { edge in
            guard !edge.isBlocked else { return nil }
            guard !requiresAccessibleRoute || edge.isAccessible else { return nil }

            let connectedNodeID: String
            if edge.from == nodeID {
                connectedNodeID = edge.to
            } else if edge.to == nodeID {
                connectedNodeID = edge.from
            } else {
                return nil
            }

            guard let fromNode = nodeByID[nodeID], let toNode = nodeByID[connectedNodeID] else {
                return nil
            }

            let distance = CLLocation(
                latitude: fromNode.coordinate.latitude,
                longitude: fromNode.coordinate.longitude
            ).distance(from: CLLocation(
                latitude: toNode.coordinate.latitude,
                longitude: toNode.coordinate.longitude
            ))

            return (connectedNodeID, distance * edge.distanceMultiplier)
        }
    }

    private static func makePathIDs(to destinationID: String, previousNodes: [String: String]) -> [String] {
        var path = [destinationID]
        var currentID = destinationID

        while let previousID = previousNodes[currentID] {
            path.insert(previousID, at: 0)
            currentID = previousID
        }

        return path
    }
}
