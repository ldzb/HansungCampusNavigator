import Foundation

struct CampusData {
    static let buildings: [Building] = [
        
        Building(
            id: 1,
            name: "진리관",
            latitude: 37.5830056,
            longitude: 127.0095493,
            places: [
                Place(id: 101, name: "장애학생지원센터", category: .office, accessSide: .both, guideText: "진리관 1층 장애학생지원센터는 중앙 출입구를 통해 접근할 수 있습니다."),
                Place(id: 102, name: "학생장학팀", category: .office, accessSide: .both, guideText: "진리관 1층 학생장학팀은 중앙 로비를 이용하세요."),
                Place(id: 103, name: "컴퓨터실습실", category: .facility, accessSide: .both, guideText: "진리관 컴퓨터실습실은 중앙 계단 또는 엘리베이터를 이용하세요."),
                Place(id: 104, name: "패션실습실", category: .facility, accessSide: .both, guideText: "진리관 패션실습실은 중앙 복도를 따라 이동하세요."),
                Place(id: 105, name: "HBS방송국", category: .facility, accessSide: .both, guideText: "진리관 2층 HBS방송국은 중앙 계단을 이용하면 편리합니다.")
            ]
        ),
        
        Building(
            id: 2,
            name: "상상빌리지",
            latitude: 37.5814749,
            longitude: 127.0100350,
            places: [
                Place(id: 201, name: "행정실", category: .office, accessSide: .both, guideText: "상상빌리지 1층 행정실은 중앙 출입구를 통해 접근 가능합니다."),
                Place(id: 202, name: "CU", category: .cafe, accessSide: .both, guideText: "상상빌리지 B1층 CU는 중앙 계단 또는 엘리베이터를 이용하세요."),
                Place(id: 203, name: "휴게라운지", category: .facility, accessSide: .both, guideText: "상상빌리지 B1층 휴게라운지는 중앙 통로를 이용하세요."),
                Place(id: 204, name: "독서실", category: .facility, accessSide: .both, guideText: "상상빌리지 독서실은 B1층에 있으며 중앙 통로 접근이 편합니다."),
                Place(id: 205, name: "IBK기업은행 세미나실", category: .facility, accessSide: .both, guideText: "상상빌리지 B1층 세미나실은 중앙 엘리베이터 근처에서 접근 가능합니다.")
            ]
        ),
        
        Building(
            id: 3,
            name: "학송관",
            latitude: 37.5833111,
            longitude: 127.0095215,
            places: [
                Place(id: 301, name: "세미나실", category: .facility, accessSide: .both, guideText: "학송관 세미나실은 중앙 통로를 이용하세요."),
                Place(id: 302, name: "컴퓨터실습실", category: .facility, accessSide: .both, guideText: "학송관 2층 컴퓨터실습실은 중앙 계단을 이용하세요."),
                Place(id: 303, name: "강의실", category: .room, accessSide: .both, guideText: "학송관 강의실은 중앙 복도를 따라 이동하세요."),
                Place(id: 304, name: "언어교육원", category: .office, accessSide: .both, guideText: "학송관 언어교육원은 2층 중앙 복도 방향에 있습니다."),
                Place(id: 305, name: "대학원교학팀", category: .office, accessSide: .both, guideText: "학송관 대학원교학팀은 중앙 계단 또는 엘리베이터를 이용하세요.")
            ]
        ),
        
        Building(
            id: 4,
            name: "연구관",
            latitude: 37.5823115, // [수정] 그라찌에 건물 위치로 이동
            longitude: 127.00982414,
            places: [
                Place(id: 401, name: "상상파크", category: .facility, accessSide: .both, guideText: "연구관 1층 상상파크는 정문 출입구를 통해 접근 가능합니다."),
                Place(id: 402, name: "그라찌에", category: .cafe, accessSide: .both, guideText: "연구관 1층 그라찌에는 중앙 로비 방향으로 이동하세요."),
                Place(id: 403, name: "회의실", category: .facility, accessSide: .both, guideText: "연구관 회의실은 중앙 통로를 이용하세요."),
                Place(id: 404, name: "VR/AR 체험존", category: .facility, accessSide: .both, guideText: "연구관 B2층 VR/AR 체험존은 엘리베이터 이용이 편리합니다.")
            ]
        ),
        
        Building(
            id: 5,
            name: "낙산관",
            latitude: 37.5820891,
            longitude: 127.0113547,
            places: [
                Place(id: 501, name: "체육관", category: .facility, accessSide: .both, guideText: "낙산관 3층 체육관은 중앙 계단 또는 엘리베이터를 이용하세요."),
                Place(id: 502, name: "대강당", category: .facility, accessSide: .both, guideText: "낙산관 2층 대강당은 중앙 복도를 따라 이동하세요."),
                Place(id: 503, name: "체력단련실", category: .facility, accessSide: .both, guideText: "낙산관 4층 체력단련실은 중앙 출입구 방향으로 접근하세요."),
                Place(id: 504, name: "무용학과 실습실", category: .facility, accessSide: .both, guideText: "낙산관 1층 무용학과 실습실은 정문 출입구를 이용하세요.")
            ]
        ),
        
        Building(
            id: 6,
            name: "우촌관",
            latitude: 37.5830056,
            longitude: 127.0106048,
            places: [
                Place(id: 601, name: "학사운영팀", category: .office, accessSide: .both, guideText: "우촌관 3층 학사운영팀은 중앙 계단 또는 엘리베이터를 이용하세요."),
                Place(id: 602, name: "국제교류팀", category: .office, accessSide: .both, guideText: "우촌관 3층 국제교류팀은 중앙 복도를 따라 이동하세요."),
                Place(id: 603, name: "우체국", category: .facility, accessSide: .both, guideText: "우촌관 1층 우체국은 정문 출입구에서 바로 접근 가능합니다."),
                Place(id: 604, name: "구내서점", category: .facility, accessSide: .both, guideText: "우촌관 1층 구내서점은 중앙 로비 방향으로 이동하세요."),
                Place(id: 605, name: "자유열람실", category: .facility, accessSide: .both, guideText: "우촌관 1층 자유열람실은 중앙 출입구를 이용하세요.")
            ]
        ),
        
        Building(
            id: 7,
            name: "인성관",
            latitude: 37.5819224,
            longitude: 127.0107715,
            places: [
                Place(id: 701, name: "동아리연합회", category: .facility, accessSide: .both, guideText: "인성관 동아리연합회는 중앙 복도를 따라 접근하세요."),
                Place(id: 702, name: "오케스트라", category: .facility, accessSide: .both, guideText: "인성관 오케스트라실은 중앙 통로 방향에 있습니다."),
                Place(id: 703, name: "테니스부", category: .facility, accessSide: .both, guideText: "인성관 테니스부실은 중앙 계단을 이용하세요."),
                Place(id: 704, name: "JOY", category: .facility, accessSide: .both, guideText: "인성관 JOY 동아리실은 중앙 통로에서 접근 가능합니다.")
            ]
        ),
        
        Building(
            id: 8,
            name: "탐구관",
            latitude: 37.5834222,
            longitude: 127.0091327,
            places: [
                Place(id: 801, name: "B101호", category: .room, accessSide: .both, guideText: "탐구관 B101호는 중앙 통로를 이용해 접근하세요."),
                Place(id: 802, name: "일반열람실", category: .facility, accessSide: .both, guideText: "탐구관 1층 일반열람실은 중앙 출입구를 이용하세요."),
                Place(id: 803, name: "휴게실", category: .facility, accessSide: .both, guideText: "탐구관 1층 휴게실은 중앙 복도를 따라 이동하세요."),
                Place(id: 804, name: "매점", category: .cafe, accessSide: .both, guideText: "탐구관 1층 매점은 중앙 출입구에서 쉽게 찾을 수 있습니다."),
                Place(id: 805, name: "실습실", category: .facility, accessSide: .both, guideText: "탐구관 실습실은 중앙 계단을 이용하면 편리합니다.")
            ]
        ),
        
        Building(
            id: 9,
            name: "창의관",
            latitude: 37.5821168,
            longitude: 127.0107714,
            places: [
                Place(id: 901, name: "애니메이션 스튜디오", category: .facility, accessSide: .both, guideText: "창의관 5층 애니메이션 스튜디오는 중앙 계단 또는 엘리베이터를 이용하세요."),
                Place(id: 902, name: "제품 스튜디오", category: .facility, accessSide: .both, guideText: "창의관 제품 스튜디오는 중앙 복도를 따라 이동하세요."),
                Place(id: 903, name: "패션드로잉실", category: .facility, accessSide: .both, guideText: "창의관 2층 패션드로잉실은 중앙 통로를 이용하세요."),
                Place(id: 904, name: "학생식당", category: .cafe, accessSide: .both, guideText: "창의관 B1층 학생식당은 중앙 출입구에서 접근 가능합니다."),
                Place(id: 905, name: "이마트24", category: .cafe, accessSide: .both, guideText: "창의관 B1층 매점은 중앙 통로를 이용하세요.")
            ]
        ),
        
        Building(
            id: 10,
            name: "공학관A",
            latitude: 37.5818453, // [수정] 지도 왼쪽 블록으로 확 내리고 이동
            longitude: 127.0098608,
            places: [
                Place(id: 1001, name: "201호", category: .room, accessSide: .left, guideText: "공학관 A 201호는 왼쪽 통로로만 접근할 수 있습니다."),
                Place(id: 1002, name: "202호", category: .room, accessSide: .left, guideText: "공학관 A 202호는 왼쪽 통로를 이용해야 합니다."),
                Place(id: 1003, name: "203호", category: .room, accessSide: .right, guideText: "공학관 A 203호는 오른쪽 통로로만 접근할 수 있습니다."),
                Place(id: 1004, name: "컴퓨터공학부 사무실", category: .office, accessSide: .both, guideText: "공학관 A 2층 컴퓨터공학부 사무실은 중앙 복도를 따라 이동하세요."),
                Place(id: 1005, name: "소프트웨어 실습실", category: .facility, accessSide: .both, guideText: "공학관 A 4층 소프트웨어 실습실은 중앙 계단 또는 엘리베이터를 이용하세요."),
                Place(id: 1006, name: "모바일 연구실", category: .facility, accessSide: .both, guideText: "공학관 A 4층 모바일 연구실은 중앙 복도를 이용하세요."),
                Place(id: 1007, name: "데이터베이스 연구실", category: .facility, accessSide: .both, guideText: "공학관 A 4층 데이터베이스 연구실은 중앙 통로 접근이 가능합니다."),
                Place(id: 1008, name: "컴퓨터 실습실", category: .facility, accessSide: .both, guideText: "공학관 A 1층 컴퓨터 실습실은 정문 출입구에서 접근이 쉽습니다.")
            ]
        ),
        
        Building(
            id: 11,
            name: "공학관B",
            latitude: 37.5815344,
            longitude: 127.00958629,
            places: [
                Place(id: 1101, name: "프로그래밍 실습실", category: .facility, accessSide: .both, guideText: "공학관 B 2층 프로그래밍 실습실은 중앙 계단 또는 엘리베이터를 이용하세요."),
                Place(id: 1102, name: "인공지능 실험실", category: .facility, accessSide: .both, guideText: "공학관 B 4층 인공지능 실험실은 중앙 복도를 따라 이동하세요."),
                Place(id: 1103, name: "정보처리 실습실", category: .facility, accessSide: .both, guideText: "공학관 B 4층 정보처리 실습실은 중앙 통로 접근이 가능합니다."),
                Place(id: 1104, name: "세미나실", category: .facility, accessSide: .both, guideText: "공학관 B 세미나실은 중앙 출입구 방향에서 접근하세요."),
                Place(id: 1105, name: "메카트로닉스 실습실", category: .facility, accessSide: .both, guideText: "공학관 B 6층 메카트로닉스 실습실은 엘리베이터 이용이 편리합니다.")
            ]
        ),
        
        Building(
            id: 12,
            name: "잔디광장",
            latitude: 37.5827000,
            longitude: 127.0095000,
            places: [
                Place(id: 1201, name: "테니스장", category: .cafe, accessSide: .both, guideText: "잔디광장 테니스장은 정면에 위치합니다."),
                Place(id: 1202, name: "테이블", category: .cafe, accessSide: .both, guideText: "잔디광장 테이블은 자유롭게 이용가능합니다.")
            ]
        ),
        
        Building(
            id: 14,
            name: "상상관",
            latitude: 37.5827687, // [수정] 학술정보관 바로 왼쪽 건물
            longitude: 127.01021762,
            places: [
                Place(id: 1401, name: "밀가옥", category: .cafe, accessSide: .both, guideText: "상상관 12층에 위치한 식당/카페입니다."),
                Place(id: 1402, name: "팥고당", category: .cafe, accessSide: .both, guideText: "상상관 2층에 위치한 베이커리 카페입니다."),
                Place(id: 1403, name: "상상부기 기념품 상점", category: .facility, accessSide: .both, guideText: "상상관 1층 로비 쪽에 위치해 있습니다."),
                Place(id: 1404, name: "건강관리실", category: .office, accessSide: .both, guideText: "상상관 1층에서 이용 가능합니다."),
                Place(id: 1405, name: "카페테리아", category: .cafe, accessSide: .both, guideText: "상상관 지하 1층, 지하 2층에 위치해 있습니다.")
            ]
        ),
        
        Building(
            id: 15,
            name: "지선관",
            latitude: 37.5820255, // 임의 배치 (필요시 수정)
            longitude: 127.0097580,
            places: [
                Place(id: 1501, name: "IT공과대학 학장실/교학팀", category: .office, accessSide: .both, guideText: "지선관 1층에 위치해 있습니다."),
                Place(id: 1502, name: "사진 스튜디오", category: .facility, accessSide: .both, guideText: "지선관 2층 사진실 곁에 있습니다."),
                Place(id: 1503, name: "서양화 실기실", category: .facility, accessSide: .both, guideText: "지선관 1~4층에 걸쳐 학년별로 분포되어 있습니다."),
                Place(id: 1504, name: "동양화 실기실", category: .facility, accessSide: .both, guideText: "지선관 2~4층에 걸쳐 학년별로 분포되어 있습니다.")
            ]
        ),
        
        Building(
            id: 16,
            name: "미래관",
            latitude: 37.5825885, // 도서관(학술정보관) 인근으로 배치
            longitude: 127.0107298,
            places: [
                Place(id: 1601, name: "상상커먼스", category: .facility, accessSide: .both, guideText: "미래관 5층에 위치한 학습 공간입니다."),
                Place(id: 1602, name: "집중열람실", category: .facility, accessSide: .both, guideText: "미래관 4층에 위치해 있습니다."),
                Place(id: 1603, name: "러닝커먼스", category: .facility, accessSide: .both, guideText: "미래관 3층에 위치해 있습니다."),
                Place(id: 1604, name: "학술정보팀/인포데스크", category: .office, accessSide: .both, guideText: "미래관 2층, 상상관 2층과 연결되어있습니다."),
                Place(id: 1605, name: "디지털스튜디오", category: .facility, accessSide: .both, guideText: "미래관 1층에 위치해 있습니다.")
            ]
        ),
        
        Building(
            id: 17,
            name: "상상큐브",
            latitude: 37.5840099,
            longitude: 127.00939697,
            places: [
                Place(id: 1701, name: "104호", category: .facility, accessSide: .right, guideText: "상상큐브 대학원생들이 살고있습니다.")
            ]
        )
    ]
}
