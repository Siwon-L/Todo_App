# 📘TodoApp

> 해당 프로젝트는 야곰아카테미의 [ios-project-manager](https://github.com/yagom-academy/ios-project-manager)프로젝트를 iPhone 버전으로 리메이크한 프로젝트 입니다.
>
> [iPad 버전의 프로젝트 보러가기](https://github.com/saafaaari/ios-project-manager/tree/main)

## 사용한 라이브러리

| Local DB | Remote DB | UI | Reactive | Layout |
|---|---|---|---|---|
| `Realm` | `Firebase` | `RxCocoa` | `RxSwift` | `SnapKit` |

## 구조

| `MVVM-C` | `Clean Architecture` |
|---|---|


기본적으로 `RxSwift`를 이용한 `MVVM`구조에 추가적으로 `Coordinator`패턴과 `DIContainer`패턴을 사용하여 화면 전환및 의존성을 관리해주었습니다.

또한, 전체적인 구조를 `Clean Architecture`를 채택하여, 각 계층의 유연한 수정및 확장이 가능하도록 하였으며, protocol를 이용해 SOLID 원칙을 지킴과 동시에 Testable 할 수 있도록 하였습니다.

<img src="https://i.imgur.com/4BJlTVR.png" width="300">

추가적으로, `CustomUIKit`으로 특정 CustomUI 객체를 다른 모듈로 분리하여, 약간의 프로젝트 빌드 속도 단축과 해당 UI가 필요한 파일에만 import하여 사용할 수 있게 객체간 결합도를 낮췄습니다.

## 기능


| 메인 |
|-|
|<img src="https://i.imgur.com/b61i6VX.gif" width="200">|

- CustomSegmentControl과 ScrollView를 이용하여 Todo, Doing, Done 세 ViewController를 Pageing 할 수 있도록 구현하였습니다. 

| 추가 | 수정 |
|-|-|
|<img src="https://i.imgur.com/PJspzTV.gif" width="200">|<img src="https://i.imgur.com/2W65Nvv.gif" width="200">|

- 상단 NavigationBar의 Plus Button를 클릭하여, 추가를 위한 화면을 모달 형식으로 present하도록 하였습니다.
- Cell를 클릭하게 되면, 해당 Cell의 정보가 입력되어 있는 수정 화면이 push 되고, 상단의 Edit button을 Tap하면, 수정 기능이 활성화 됩니다.
- 추가및 수정된 데이터는 `Realm`을 이용한 Local DB 저장되고, App이 종료되면, 종료 시점에 입력되어있는 데이터를 `Firebase`를 이용한 Remote DB에 저장됩니다.
- `Firebase`에 저장되어 있는 데이터는 사용자가 App을 삭제하고, 다시 다운받았을 때 읽어오도록 하였습니다.

| 이동 및 삭제 | History |
|-|-|
|<img src="https://i.imgur.com/EJKGLaf.gif" width="200">|<img src="https://i.imgur.com/R0FI6SR.gif" width="200">|

- 해당 Cell을 longpress하게 되면 두개의 Moveing Button과 Delete Button이 popover 형식으로 나타나게 됩니다.
- 상단 NavigationBar의 Watch Button를 클릭면, History 화면으로 전환됩니다. 해당 화면에서 지금까지 기록을 볼 수 있습니다.

## 테스트

![](https://i.imgur.com/vPYZaCw.png)

UseCase와 각 화면의 ViewModel에 대해서 Unit Test를 진행하였습니다.

각 타입의 의존성을 의존성 주입과 protocol을 사용하여 Testable하게 구현하였으며, Test를 위한 Test Double 타입을 구현하여 독립적인 Test가 될 수 있도록 하였습니다.

