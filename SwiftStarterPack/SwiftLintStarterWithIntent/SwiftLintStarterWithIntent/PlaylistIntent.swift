//
//  PlaylistIntent.swift
//  SwiftLintStarterWithIntent
//
//  Created by Greem on 8/7/25.
//

import Foundation
import AppIntents

enum MusicGenre: String, AppEnum, CaseIterable {
    case popp = "popp"
    case rock = "rock"
    case jazz = "jazz"
    
    static var typeDisplayRepresentation: TypeDisplayRepresentation = .init(name: "음악 장르")
    
    static var caseDisplayRepresentations: [MusicGenre : DisplayRepresentation] = [
        .popp: DisplayRepresentation(title: "Pop", subtitle: "대중 음악"),
        .rock: DisplayRepresentation(title: "Rock", subtitle: "록 음악"),
        .jazz: DisplayRepresentation(title: "Jazz")
    ]
}

// 재생 모드 - 고정된 선택지
enum PlayMode: String, AppEnum {
    case shuffle = "shuffle"
    case `repeat` = "repeat"
    case repeatOne = "repeatOne"
    case normal = "normal"
    
    static var typeDisplayRepresentation: TypeDisplayRepresentation =
        TypeDisplayRepresentation(name: "Play Mode")
    
    static var caseDisplayRepresentations: [PlayMode: DisplayRepresentation] = [
        .shuffle: DisplayRepresentation(title: "셔플", subtitle: "무작위 재생"),
        .repeat: DisplayRepresentation(title: "반복", subtitle: "전체 반복"),
        .repeatOne: DisplayRepresentation(title: "한곡 반복", subtitle: "현재 곡 반복"),
        .normal: DisplayRepresentation(title: "순서대로", subtitle: "일반 재생")
    ]
}

/// 이건 런타임에서 실행하니깐...
struct Playlist: AppEntity {
    static var defaultQuery = PlaylistQuery()
    static var typeDisplayRepresentation: TypeDisplayRepresentation = TypeDisplayRepresentation(name: "Playlist")
    
    var displayRepresentation: DisplayRepresentation {
        DisplayRepresentation(
            title: "\(name)",
            subtitle: "\(songCount)곡 • \(createdDate.formatted(.dateTime.month().day()))"
        )
    }
    
    var id: String
    var name: String
    var songCount: Int
    var createdDate: Date
    
}

// PlaylistQuery - 플레이리스트 검색 및 필터링
struct PlaylistQuery: EntityQuery {
    func entities(for identifiers: [String]) async throws -> [Playlist] {
        // ID로 특정 플레이리스트들을 찾아서 반환
        let allPlaylists = await getAllPlaylists()
        return allPlaylists.filter { identifiers.contains($0.id) }
    }
    
    func entities(matching string: String) async throws -> [Playlist] {
        // 검색어로 플레이리스트 이름을 검색
        let allPlaylists = await getAllPlaylists()
        return allPlaylists.filter { 
            $0.name.localizedCaseInsensitiveContains(string) 
        }
    }
    
    func suggestedEntities() async throws -> [Playlist] {
        // 추천 플레이리스트 (최근에 만든 것들 우선)
        let allPlaylists = await getAllPlaylists()
        return Array(allPlaylists.sorted { $0.createdDate > $1.createdDate }.prefix(3))
    }
    
    private func getAllPlaylists() async -> [Playlist] {
        // 실제로는 Core Data나 서버에서 가져올 것
        return [
            Playlist(id: "favorites", name: "즐겨듣는 음악", songCount: 25, createdDate: Date().addingTimeInterval(-86400 * 7)),
            Playlist(id: "workout", name: "운동할 때", songCount: 18, createdDate: Date().addingTimeInterval(-86400 * 3)),
            Playlist(id: "study", name: "공부할 때", songCount: 32, createdDate: Date().addingTimeInterval(-86400 * 1)),
            Playlist(id: "party", name: "파티 음악", songCount: 15, createdDate: Date()),
            Playlist(id: "chill", name: "힐링 음악", songCount: 22, createdDate: Date().addingTimeInterval(-86400 * 5)),
            Playlist(id: "driving", name: "드라이브", songCount: 28, createdDate: Date().addingTimeInterval(-86400 * 2))
        ]
    }
}

// 동적으로 플레이리스트 목록 제공
struct PlaylistOptionsProvider: DynamicOptionsProvider {
    typealias Result = IntentItemCollection<Playlist>
    func results() async throws -> IntentItemCollection<Playlist> {
        // 실제로는 Core Data나 서버에서 가져올 것
        let userPlaylists = [
            Playlist(id: "favorites", name: "즐겨듣는 음악", songCount: 25, createdDate: Date().addingTimeInterval(-86400 * 7)),
            Playlist(id: "workout", name: "운동할 때", songCount: 18, createdDate: Date().addingTimeInterval(-86400 * 3)),
            Playlist(id: "study", name: "공부할 때", songCount: 32, createdDate: Date().addingTimeInterval(-86400 * 1)),
            Playlist(id: "party", name: "파티 음악", songCount: 15, createdDate: Date())
        ]
        
        return IntentItemCollection(items: userPlaylists)
    }
}

struct PlayMusicIntent: AppIntent {
    static var title: LocalizedStringResource = "음악 재생"
    
    @Parameter(title: "플레이리스트", optionsProvider: PlaylistOptionsProvider())
    var playlist: Playlist?
    
    @Parameter(title: "장르", description: "재생할 음악 장르를 선택하세요")
    var genre: MusicGenre?
    
    @Parameter(title: "재생 모드", default: .normal)
    var playMode: PlayMode
    
    func perform() async throws -> some IntentResult & ProvidesDialog {
        var message = ""
        // 장르가 비어있다면 실행 시점에 사용자에게 값 요청
        var selectedGenre: MusicGenre? = genre
        
        
        if let playlist = playlist {
            message = "\(playlist.name) 플레이리스트를"
        } else if let genre = selectedGenre {
            message = "\(String(localized: MusicGenre.caseDisplayRepresentations[genre]?.title ?? "선택한")) 장르 음악을"
        } else {
            message = "음악을"
        }
        
        let modeText: String = String(localized: PlayMode.caseDisplayRepresentations[playMode]?.title ?? "일반")
        
        message += " \(modeText) 모드로 재생합니다"
        
        return .result(dialog: IntentDialog(stringLiteral: message))
    }
}
