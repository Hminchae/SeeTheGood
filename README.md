## SeeTheGood
> 네이버 쇼핑 검색 API를 활용하여 마음에 드는 상품을 저장할 수 있는 앱

Keyword : `CollectionView`, `TableView`, `UserDefault`, `NaverAPI`, `Keyword Highlighting`

OpenSource : `Alamofire`, `Kingfisher`, `SkeletonView`, `Toast`, `SnapKit`

| 시작화면 | 캐릭터 설정 | 닉네임 설정 | 메인 검색 | 검색 결과 | 설정 |
|--|--|--|--|--|--|
|![Simulator Screenshot - iPhone 15 Pro - 2024-06-19 at 17 27 29](https://github.com/Hminchae/SeeTheGood/assets/103357078/2e641339-a369-456f-a82b-d3bcc24866c6) | ![Simulator Screenshot - iPhone 15 Pro - 2024-06-19 at 17 27 37](https://github.com/Hminchae/SeeTheGood/assets/103357078/8e5aa252-8b9b-43c1-995e-517652755f7c) | ![Simulator Screenshot - iPhone 15 Pro - 2024-06-19 at 17 28 03](https://github.com/Hminchae/SeeTheGood/assets/103357078/02566a21-56b9-4423-8b4a-f80c894fbbe8) | ![Simulator Screenshot - iPhone 15 Pro - 2024-06-19 at 17 28 29](https://github.com/Hminchae/SeeTheGood/assets/103357078/3a76c28e-3195-4928-85fc-0e20ef7812df) | ![Simulator Screenshot - iPhone 15 Pro - 2024-06-19 at 17 29 18](https://github.com/Hminchae/SeeTheGood/assets/103357078/aaf1068b-235c-4d01-b9ac-e055ceb5ed01) | ![Simulator Screenshot - iPhone 15 Pro - 2024-06-19 at 17 28 51](https://github.com/Hminchae/SeeTheGood/assets/103357078/a72099ec-a0af-4619-ac38-42ec5be50fd0)

**주요 구현 내용**
- 가입
  - 가입여부에 따라 분기처리
  - 닉네임 설정 핸들링
- 검색
  - 중복검색의 경우 상단에 검색어가 올라오도록 구현
  - API 통신중 스켈레톤뷰 구현, 통신 실패시 토스트 메세지 구현
  - 장바구니에 넣는 기능 구현과 바로바로 반영하도록 뷰라이프사이클 활용
  - 검색 키워드에 하이라이팅 기능 구현
- 설정
  - 초기 진입시와 같은 뷰를 활용하여 분기처리
  - 탈퇴기능 구현 
