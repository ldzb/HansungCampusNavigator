# 🗺️ HansungBoogi (한성부기)

<div align="center">
  <img src="https://capsule-render.vercel.app/api?type=waving&color=auto&height=200&section=header&text=HansungBoogi&subtitle=한성대학교%20iOS%20캠퍼스%20길찾기%20내비게이션&fontSize=50&animation=fade&fontColor=ffffff" width="100%">
</div>

> **"지도는 복잡하게, 길찾기는 단순하게!"**  
> 한성대학교 학생들이 건물과 강의실 위치를 쉽고 빠르게 찾을 수 있도록 돕는 UIKit 기반의 iOS 캠퍼스 내비게이션 앱입니다.

<br>

## 📌 목차
1. [프로젝트 소개 및 목적](#-프로젝트-소개-및-목적)
2. [앱 화면 구성 (미리보기)](#-앱-화면-구성-미리보기)
3. [주요 기능 및 체크리스트](#-주요-기능-및-체크리스트)
4. [기술 스택 및 아키텍처](#-기술-스택-및-아키텍처)
5. [데이터 구조](#-데이터-구조)
6. [실행 방법](#-실행-방법)

---

## 🏫 프로젝트 소개 및 목적

한성대학교 캠퍼스는 고저차가 있고 건물 내부 구조가 복잡하여 초행 학생이나 방문자가 특정 강의실을 찾기 어려운 불편함이 있습니다. **HansungBoogi**는 이러한 문제를 해결하기 위해 직관적인 UI와 위치 기반 서비스를 결합한 **iOS 전용 캠퍼스 길찾기 솔루션**입니다.

- **강의실 탐색 효율화:** 건물 단위의 핀(Annotation)과 세부 장소 검색을 통해 이동 동선 최소화
- **사용자 편의성 극대화:** 최근 검색어와 즐겨찾기 연동으로 반복적인 탐색 과정 단축
- **장애인 편의 고려:** 캠퍼스 맵(장애인 보행로) 데이터를 참고한 접근성 정보 제공 지향

---

## 📱 앱 화면 구성 (미리보기)

| 홈 화면 | 지도 화면 (정보 패널) | 즐겨찾기 & 설정 |
| :---: | :---: | :---: |
| <img src="images/home.png" width="220" alt="홈 화면"> | <img src="images/map.png" width="220" alt="지도 화면"> | <img src="images/favorites.png" width="220" alt="즐겨찾기"> |
| 마스코트 인사말 및<br>최근 검색어 퀵 링크 | MapKit 기반 건물 핀 표시 및<br>하단 정보 패널 바텀시트 | 자주 찾는 장소 관리 및<br>데이터 초기화 설정 |

---

## ✨ 주요 기능 및 체크리스트

- [x] **홈 화면 (Main Dashboard)**
  - [x] 한성대 마스코트 '상상부기' 환영 메시지 및 애니메이션 UI
  - [x] 최근 검색어 목록 제공 및 즉시 검색 기능
- [x] **지도 기반 내비게이션 (MapKit)**
  - [x] 한성대 캠퍼스 주요 건물 맞춤형 커스텀 핀(Annotation) 표시
  - [x] 핀 선택 시 상세 정보(건물명, 장소 설명, 출입 방향 등) 패널 노출
  - [x] 캠퍼스 내 주요 지점 간 경로 탐색 및 시각화 (`CampusPathData` 활용)
- [x] **스마트 검색 및 히스토리**
  - [x] 건물명/강의실명 통합 검색
  - [x] 검색 기록 자동 저장 및 개별/전체 삭제 (`RecentSearchManager`)
- [x] **사용자 편의 기능**
  - [x] 장소 즐겨찾기(Favorites) 등록 및 관리 (`UserDefaults` 기반 영속성)
  - [x] 다크 모드 지원 및 설정 화면을 통한 데이터 초기화

---

## 🛠 기술 스택 및 아키텍처

### Tech Stack
- **Language**: `Swift 5`
- **iOS SDK**: `iOS 15.0+`
- **Frameworks**: `UIKit`, `MapKit`, `CoreLocation`
- **UI Implementation**: `Auto Layout` (Storyboard), `UIStackView`, `UITableView`
- **Data Persistence**: `UserDefaults` (Codable 활용 데이터 직렬화)

### Project Directory Structure
```plaintext
HansungBoogi
├── AppDelegate.swift / SceneDelegate.swift
├── ViewControllers
│   ├── HomeViewController.swift       # 상상부기 인사 및 검색 이력
│   ├── MapViewController.swift        # 지도 렌더링 및 경로 탐색
│   ├── FavoritesViewController.swift   # 즐겨찾기 목록 관리
│   └── SettingsViewController.swift    # 앱 정보 및 초기화 설정
├── Managers
│   ├── FavoritesManager.swift         # 즐겨찾기 로컬 데이터 관리
│   └── RecentSearchManager.swift      # 최근 검색어 캐싱 처리
├── Models
│   └── CampusModels.swift             # Building, Place, PathData 모델
├── Resources
│   ├── CampusData.swift               # 건물 및 장소 메타데이터
│   ├── CampusPathData.swift           # 길찾기 경로 노드 및 가중치 데이터
│   ├── Assets.xcassets                # 이미지 및 컬러 에셋 (상상부기 등)
│   └── Base.lproj                     # Main & LaunchScreen 스토리보드
└── Documents
    └── 캠퍼스맵(장애인보행로).pdf          # 데이터 설계 참조 자료
```

---

## 💾 데이터 구조

앱 내의 모든 장소와 경로 데이터는 `struct`와 `enum`을 통해 체계적으로 모델링되어 있습니다.

### 🏢 핵심 모델 예시

```swift
// 장소 카테고리
enum PlaceCategory: String, Codable {
    case room, cafe, office, facility, elevator
}

// 건물 정보 모델
struct Building: Codable {
    let id: Int
    let name: String
    let latitude: Double
    let longitude: Double
    let places: [Place]
}

// 경로 탐색 데이터
struct PathNode {
    let id: Int
    let connection: [Int] // 연결된 노드 ID들
    let description: String
}
```

---

## 🎬 시연 영상

| 핵심 시나리오 (홈 ➡️ 검색 ➡️ 경로 시각화 ➡️ 즐겨찾기) |
| :---: |
| [![HansungBoogi Video](https://img.shields.io/badge/YouTube-%23FF0000.svg?style=for-the-badge&logo=YouTube&logoColor=white)](https://youtu.be/Bdmv1M8MZKw) |
| 👆 **위 버튼을 클릭하면 기능 시연 영상(YouTube)으로 이동합니다.** (3분 내외 소요) |

---

## 🏃‍♂️ 실행 방법

### 1. 저장소를 Clone 합니다.
```bash
git clone https://github.com/pangdasian/HansungCampusNavigator.git
```

### 2. Xcode 프로젝트를 엽니다.
```bash
cd HansungCampusNavigator
open HansungBoogi.xcodeproj
```

### 3. 빌드 및 실행
- 외부 라이브러리 의존성이 없으므로 바로 `Cmd + R`을 눌러 시뮬레이터(iPhone 15 이상 추천)에서 실행할 수 있습니다.
- **주의:** 런치화면 이미지가 보이지 않을 경우 `Clean Build Folder (Shift + Cmd + K)` 후 다시 실행해 주세요.

---
<div align="center">
  © 2026 HansungBoogi Team. All Rights Reserved.
</div>
