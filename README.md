# 🎬 Box Office

## 🍀 소개
영화진흥위원회 API를 활용하여 일일 박스오피스 조회 및 영화 개별 상세 조회를 진행합니다.
사용자에게 날짜를 입력받아 해당 날짜의 박스오피스를 보여주고, 클릭하면 영화의 상세 정보를 보여줍니다.

* 주요 개념: `URLSession`, `UICollectionView`, `refreshControl`, `UICalendarView`, `Dynamic Type`, `Networking Test`

<br>

## 📖 목차
[1. 프로젝트 구조](#-프로젝트-구조) <br/>

[2. 실행 화면](#-실행-화면) <br/>

[3. 고민했던 점](#-고민했던-점) <br/>

[4. 트러블 슈팅](#-트러블-슈팅) <br/>

[5. 참고 링크](#-참고-링크) <br/>

<br>

## 👀 프로젝트 구조

<details>
    <summary> Class Diagram </summary>

![boxoffice_classdiagram](https://github.com/MaryJo-github/ios-box-office/assets/42026766/46223082-1943-4556-96e1-a9b5e7b37f5c)
</details>

<br>

<details>
    <summary> File Tree </summary>
    
```
.
└── BoxOffice
    ├── Model
    │   ├── Network
    │   │   └── NetworkManager
    │   ├── Image
    │   │   ├── ImageEndPoint
    │   │   └── ImageManager
    │   ├── MovieInformation
    │   │   ├── MovieInformationEndPoint
    │   │   └── MovieInformationManager
    │   └── DataTransferObject
    │       ├── DailyBoxOffice
    │       │   ├── BoxOffice
    │       │   ├── BoxOfficeResult
    │       │   └── DailyBoxOffice
    │       ├── MovieInformation
    │       │   ├── DetailInformation
    │       │   ├── MovieInformation
    │       │   └── MovieInformationResult
    │       └── ImageSearch
    │           ├── Document
    │           └── ImageSearch
    ├── View
    │   ├── Base.lproj
    │   │   └── LaunchScreen.storyboard
    │   ├── DailyBoxOfficeCollectionViewGridCell
    │   ├── DailyBoxOfficeCollectionViewListCell
    │   ├── LoadingView
    │   └── MovieInformationScrollView
    ├── Controller
    │   ├── CalendarViewController
    │   ├── DailyBoxOfficeViewController
    │   └── MovieInformationViewController
    ├── Enum
    │   └── BoxOfficeViewMode
    ├── Extension
    │   ├── Array+
    │   ├── CALayer+
    │   ├── String+
    │   └── Date+
    ├── Protocol
    │   ├── Requestable
    │   ├── NetworkManageable
    │   └── CalendarDelegate
    ├── Error
    │   ├── NetworkError
    │   ├── StringError
    │   └── URLError
    ├── Application
    │   ├── AppDelegate
    │   └── SceneDelegate
    └── Resource
        ├── Assets.xcassets
        └── Info.plist
```

</details>

<br>

## 💻 실행 화면 
| 박스오피스 리스트 및 상세 화면 | 화면 모드 변경 | 날짜 변경 |
|:--:|:--:|:--:|
|<img src="https://github.com/MaryJo-github/ios-box-office/assets/42026766/60c1fefc-4427-4e84-b10d-1936178b0f7c" width="200">|<img src="https://github.com/MaryJo-github/ios-box-office/assets/42026766/088130e1-794e-445e-bf32-b55b14919149" width="200">|<img src="https://github.com/MaryJo-github/ios-box-office/assets/42026766/ae202d19-ebd0-4936-adf6-9b1dbbbad1e7" width="200">|


</br>

## 🧠 고민했던 점

### 1️⃣ Deployment target version
- `tableViewCell`을 사용할 때 `accessory`타입의 `.disclosureIndicator`를 활용해서 각각의 셀에 `>`모양을 표시했습니다. 하지만 `UICollectionViewCell`은 해당 기능이 없었고, 검색해 본 결과 `UICollectionViewListCell`이 있었습니다. 하지만 이는 **iOS14**부터 지원합니다.
- 사용자에게 날짜를 입력받을 때 `UICalendarView`를 활용하라는 요구사항이 있었고, 이는 **iOS16**부터 지원합니다. 
- 처음에 만들어진 프로젝트의 버전은 **iOS13**이며, 위 두 기능은 기존 버전보다 높아서 사용할 수 없었습니다.

- 처음에는 기존 프로젝트 설정 그대로 가려고 했지만, 프로젝트에서 요구사항에는 `iOS`버전에 대한 이야기가 없었습니다. 찾아본 결과 공식페이지에 [iOS점유율](https://developer.apple.com/kr/support/app-store/)을 확인하는 곳이 있었고 아이폰의 81%가 **iOS16**을 사용하고 있다는 통계를 찾았고 이것이 저희가 버전을 수정하려는 이유가 될 수 있다고 생각했기 때문에 프로젝트 버전을 **iOS16**으로 변경하였습니다.

### 2️⃣ 여러개의 비동기 작업이 끝나는 시점
- `MovieInformationViewController`클래스에서 `receiveImageData()`메서드와 `receiveBoxOfficeData()` 메서드에서 비동기로 데이터를 처리하고 있습니다. 
- 뷰 업데이트(로딩뷰가 사라지고 영화 상세 정보를 보여주는 것)는 두 비동기 작업 처리가 끝날 때 이루어져야 하기 때문에 해당 시점을 어떻게 알 수 있을지 고민하였습니다.

- 결과적으로 프로퍼티 값의 변화를 관찰할 수 있는 `프로퍼티 옵저버`를 활용하였습니다.
- 완료된 task의 개수를 셀 `completionCount` 프로퍼티를 생성하여 각 task가 끝날 때 `completionCount` 값을 1 증가시킵니다.
- `completionCount` 값의 변화가 있을 때마다 완료된 task가 2개인지 확인합니다. 해당 조건이 true이면 로딩 뷰가 사라지도록 설정했습니다.
    <details>
        <summary> 코드 </summary>

    ``` swift
    private var completionCount: Int = 0 {
        didSet {
            if completionCount == 2 {
                loadingView.hide()
            }
        }
    }

    private func receiveBoxOfficeData() {
        guard let urlRequest = MovieInformationManager
            .shared
            .receiveDetailURLRequest(movieCode: dailyBoxOfficeData.movieCode) else {
                return
            }

        MovieInformationManager.shared.receiveDetailData(urlRequest: urlRequest) { result in
            switch result {
            case .success(let data):
                self.detailInformationData = data
                self.updateScrollView()
                self.completionCount += 1
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    ```
    </details>

### 3️⃣ ViewController 데이터 전달
- `CalendarViewController`에서 사용자가 선택한 날짜에 따라 BoxOffice를 업데이트해야 했습니다.
- `CalendarDelegate` 프로토콜을 활용하여 `CalendarViewController`에서 날짜가 변경되었을 때 `DailyBoxOfficeViewController`의 `updateBoxOffice(date: Date)`메서드를 호출하도록 구현하였습니다.

    <details>
        <summary> 코드 </summary>

    ```swift
    protocol CalendarDelegate: AnyObject {
        func updateBoxOffice(date: Date)
    }

    final class DailyBoxOfficeViewController: UIViewController {
        ...
        extension DailyBoxOfficeViewController: CalendarDelegate {
            func updateBoxOffice(date: Date) {
                targetDate = date
                receiveData()
                setNavigationTitle()
            }
        }
        ...
    }

    final class CalendarViewController: UIViewController {
        weak var delegate: CalendarDelegate?
        ...
    }

    extension CalendarViewController: UICalendarSelectionSingleDateDelegate {
        func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
            guard let date = dateComponents?.date else { return }

            delegate?.updateBoxOffice(date: date)
            dismiss(animated: true)
        }
    }

    ```
    </details>

### 4️⃣ Networking Test
- network 상태와 관련 없이 로직을 검증할 수 있도록 다음 과정을 거쳐 테스트 코드를 작성하였습니다.
    1) testable한 코드로 만들기
        - Requestable 프로토콜 생성 및 Requester 채택
          network 통신을 하지 않기 위해 URLSessionDataTask를 가짜로 만드는 방법이 있지만, iOS 14.0부터 URLSessionDataTask의 init이 deprecated되었습니다. 따라서 dataTask 메서드를 가지는 Requestable 프로토콜을 만들고 NetworkManager에서 requester를 주입받는 형태로 수정하였습니다.
            <details>
            <summary> 코드 </summary>

            ```swift
            protocol Requestable {
                func dataTask(with urlRequest: URLRequest, completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
            }

            final class NetworkManager: NetworkManageable {    
                private(set) var requester: Requestable

                init(requester: Requestable = DefaultRequester()) {
                    self.requester = requester
                }

                func fetchData(urlRequest: URLRequest, completion: @escaping NetworkResult) {
                    let task: URLSessionDataTask = requester.dataTask(with: urlRequest) { data, response, error in
                        ...
                    }

                    task.resume()
                }
            }
            ```
            </details>
        - NetworkManageable 프로토콜 생성 및 NetworkManager 채택
          NetworkManager에 의존하고 있는 ImageManager와 MovieInformationManager를 NetworkManager의 동작과 관계없이 테스트하기 위해 NetworkManageable 프로토콜을 생성하고 각 객체를 생성할 때 NetworkManageable 타입을 주입받도록 수정하였습니다.
            <details>
            <summary> 코드 </summary>

            ```swift
            protocol NetworkManageable: AnyObject {
                var requester: Requestable { get }

                func fetchData(urlRequest: URLRequest, completion: @escaping NetworkResult)
            }

            final class ImageManager {
                private let networkManager: NetworkManageable

                init(networkManager: NetworkManageable = NetworkManager(requester: DefaultRequester())) {
                    self.networkManager = networkManager
                }
                ...
            }

            final class MovieInformationManager {
                private let networkManager: NetworkManageable

                init(networkManager: NetworkManageable = NetworkManager(requester: DefaultRequester())) {
                    self.networkManager = networkManager
                }
                ...
            }
            ```
            </details>
    
    2) Test Double 만들기
        - StubRequesters 생성
          NetworkManager를 테스트하기 위해 정해진 출력값을 반환하는 Stub Requester를 만들었습니다. 성공하는 Requester와 실패하는 Requester를 각각 만들어서 모든 케이스에 대해 테스트하였습니다.
            <details>
            <summary> 코드 </summary>

            ```swift
            // StubRequesters.swift
            final class SuccessRequester: Requestable {
                private let data: Data

                init(data: Data = Data()) {
                    self.data = data
                }

                func dataTask(with urlRequest: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
                    completionHandler(data, HTTPURLResponse(url: urlRequest.url!, statusCode: 200, httpVersion: nil, headerFields: nil), nil)
                    return URLSession.shared.dataTask(with: urlRequest)
                }
            }

            final class FailureRequester: Requestable {
                func dataTask(with urlRequest: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
                    completionHandler(nil, nil, NetworkError.requestFail)
                    return URLSession.shared.dataTask(with: urlRequest)
                }
            }

            final class ResponseFailureRequester: Requestable {
                ...
            }

            final class StatusCodeFailureRequester: Requestable {
                ...
            }

            final class DataFailureRequester: Requestable {
                ...
            }
            ```
            ```swift
            // NetworkManagerTests.swift
            // 성공하는 케이스
            func testSuccess() {
                let expectation = XCTestExpectation(description: "requestSuccess")
                var resultData: Data?

                networkManager = NetworkManager(requester: SuccessRequester())
                networkManager.fetchData(urlRequest: URLRequest(url: URL(string: "success")!)) { result in
                    switch result {
                    case .success(let data):
                        resultData = data
                        expectation.fulfill()
                    case .failure:
                        XCTFail()
                    }
                }

                wait(for: [expectation], timeout: 5.0)
                XCTAssertNotNil(resultData)
            }
            ```
            </details>
        - DummyRequester, MockNetworkManager 생성
          NetworkManager에 의존하고 있는 ImageManager와 MovieInformationManager를 테스트하기 위해 성공, 실패하는 Mock NetworkManager를 만들었습니다. 이 때 NetworkManager의 requester 프로퍼티의 초기화가 필요하기 때문에 Dummy Requester도 만들어 테스트를 진행하였습니다.
          
            <details>
            <summary> 코드 </summary>

            ```swift
            // DummyRequester.swift
            final class DummyRequester: Requestable {
                func dataTask(with urlRequest: URLRequest, completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
                    return URLSession.shared.dataTask(with: URL(string: "")!)
                }
            }
            ```
            ```swift
            // MockSuccessNetworkManager.swift
            final class MockSuccessNetworkManager: NetworkManageable {
                var requester: Requestable
                private var data: Data
                private var delay: DispatchTime
                private var callCount: Int = 0

                init(data: Data = Data(), delay: DispatchTime = .now()) {
                    requester = DummyRequester()
                    self.data = data
                    self.delay = delay
                }

                func fetchData(urlRequest: URLRequest, completion: @escaping NetworkResult) {
                    callCount += 1

                    DispatchQueue.global().asyncAfter(deadline: delay) {
                        completion(.success(self.data))
                    }
                }

                func verify(callCount: Int = 1) {
                    XCTAssertEqual(self.callCount, callCount)
                }
            }
            ```
            </details>


<br>

## 🧨 트러블 슈팅
### 1️⃣ cell 재사용으로 인한 text 색상 문제
⚠️ **문제점** <br>
- 영화 순위 등락을 표시하는 `rankChangeValueLabel`은 등락에 따라 텍스트의 색상을 변경해주었습니다. 첫 실행화면은 정상적으로 보여지지만, 화면을 아래로 드래그하여 새로고침을 하거나, `collectionView`를 아래로 스크롤하면 다음과 같이 색상이 잘못 나타나는 현상이 발생하였습니다.
<img width="300" src="https://user-images.githubusercontent.com/42026766/258487087-fd4cf6dd-9219-4239-9770-590c08e8fa05.png"> 

✅ **해결방법** <br>
- 해당 문제는 셀을 재사용하기 전에 초기화를 해주지 않았기 때문에 발생한 문제였습니다. `UICollectionViewCell`의 `prepareForReuse`메서드를 오버라이딩하여 `Label`의 `text`와 `textColor`를 초기화 해줌으로써 문제를 해결하였습니다.
```swift
override func prepareForReuse() {
    super.prepareForReuse()

    rankLabel.text = nil
    titleLabel.text = nil
    visitorLabel.text = nil
    rankChangeValueLabel.text = nil
    rankChangeValueLabel.textColor = nil
}
```

<br>

## 📚 참고 링크
- [🍎 Apple Docs: JSONDecoder](https://developer.apple.com/documentation/foundation/jsondecoder)
- [🍎 Apple Docs: URLComponents](https://developer.apple.com/documentation/foundation/urlcomponents)
- [🍎 Apple Docs: URLSession](https://developer.apple.com/documentation/foundation/urlsession)
- [🍎 Apple Docs: Fetching Website Data into Memory](https://developer.apple.com/documentation/foundation/url_loading_system/fetching_website_data_into_memory)
- [🍎 Apple Docs: dataTask with completionHandler](https://developer.apple.com/documentation/foundation/urlsession/1410330-datatask?changes=_8)
- [🍎 Apple Docs: refreshControl](https://developer.apple.com/documentation/uikit/uirefreshcontrol)
- [🍎 Apple Docs: URLRequest](https://developer.apple.com/documentation/foundation/urlrequest)
- [🍎 Apple Docs: UICollectionView](https://developer.apple.com/documentation/uikit/uicollectionview)
- [🍎 Apple Docs: UICalendarView](https://developer.apple.com/documentation/uikit/uicalendarview)
- [🍎 Apple Docs: DateInterval](https://developer.apple.com/documentation/foundation/dateinterval)
- [🍎 Apple Docs: UIToolbar](https://developer.apple.com/documentation/uikit/uitoolbar)
- [🌐 Blog: iOS 서버통신 연결하기](https://vanillacreamdonut.tistory.com/254)
- [🌐 Blog: subscript](https://limjs-dev.tistory.com/104)
- [🌐 Blog: Dynamic Type](https://limjs-dev.tistory.com/103)
- [🌐 Article: Mocks Aren't Stubs](https://martinfowler.com/articles/mocksArentStubs.html)
- [🌐 Blog: iOS Networking and Testing](https://techblog.woowahan.com/2704/)

<br>
