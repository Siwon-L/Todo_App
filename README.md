# πTodoApp

> ν΄λΉ νλ‘μ νΈλ μΌκ³°μμΉ΄νλ―Έμ [ios-project-manager](https://github.com/yagom-academy/ios-project-manager)νλ‘μ νΈλ₯Ό iPhone λ²μ μΌλ‘ λ¦¬λ©μ΄ν¬ν νλ‘μ νΈ μλλ€.
>
> [iPad λ²μ μ νλ‘μ νΈ λ³΄λ¬κ°κΈ°](https://github.com/saafaaari/ios-project-manager/tree/main)

## μ¬μ©ν λΌμ΄λΈλ¬λ¦¬

| Local DB | Remote DB | UI | Reactive | Layout |
|---|---|---|---|---|
| `Realm` | `Firebase` | `RxCocoa` | `RxSwift` | `SnapKit` |

## κ΅¬μ‘°

| `MVVM-C` | `Clean Architecture` |
|---|---|


κΈ°λ³Έμ μΌλ‘ `RxSwift`λ₯Ό μ΄μ©ν `MVVM`κ΅¬μ‘°μ μΆκ°μ μΌλ‘ `Coordinator`ν¨ν΄κ³Ό `DIContainer`ν¨ν΄μ μ¬μ©νμ¬ νλ©΄ μ νλ° μμ‘΄μ±μ κ΄λ¦¬ν΄μ£Όμμ΅λλ€.

λν, μ μ²΄μ μΈ κ΅¬μ‘°λ₯Ό `Clean Architecture`λ₯Ό μ±ννμ¬, κ° κ³μΈ΅μ μ μ°ν μμ λ° νμ₯μ΄ κ°λ₯νλλ‘ νμμΌλ©°, protocolλ₯Ό μ΄μ©ν΄ SOLID μμΉμ μ§ν΄κ³Ό λμμ Testable ν  μ μλλ‘ νμμ΅λλ€.

```
βββ CustomUIKit
βΒ Β  βββ CustomUIKit
βΒ Β  βΒ Β  βββ CustomUIHeaderView.swift
βΒ Β  βΒ Β  βββ CustomUIKit.docc
βΒ Β  βΒ Β  βΒ Β  βββ CustomUIKit.md
βΒ Β  βΒ Β  βββ CustomUIKit.h
βΒ Β  βΒ Β  βββ CustomUISegmentControl.swift
βΒ Β  βΒ Β  βββ CustomUITableView.swift
βΒ Β  βββ CustomUIKit.xcodeproj
βΒ Β  βΒ Β  βββ project.pbxproj
βΒ Β  βΒ Β  βββ project.xcworkspace
βΒ Β  βΒ Β  βΒ Β  βββ contents.xcworkspacedata
βΒ Β  βΒ Β  βΒ Β  βββ xcshareddata
βΒ Β  βΒ Β  βΒ Β      βββ IDEWorkspaceChecks.plist
βΒ Β  βΒ Β  βββ xcuserdata
βΒ Β  βΒ Β      βββ isiwon.xcuserdatad
βΒ Β  βΒ Β          βββ xcschemes
βΒ Β  βΒ Β              βββ xcschememanagement.plist
βΒ Β  βββ CustomUIKitTests
βΒ Β      βββ CustomUIKitTests.swift
βββ README.md
βββ TodoApp
    βββ ProjectManager
    βΒ Β  βββ Application
    βΒ Β  βΒ Β  βββ AppDelegate.swift
    βΒ Β  βΒ Β  βββ DIContainer
    βΒ Β  βΒ Β  βΒ Β  βββ MainSceneDIContainer.swift
    βΒ Β  βΒ Β  βββ GoogleService-Info.plist
    βΒ Β  βΒ Β  βββ SceneDelegate.swift
    βΒ Β  βββ Assets.xcassets
    βΒ Β  βΒ Β  βββ AccentColor.colorset
    βΒ Β  βΒ Β  βΒ Β  βββ Contents.json
    βΒ Β  βΒ Β  βββ AppIcon.appiconset
    βΒ Β  βΒ Β  βΒ Β  βββ Contents.json
    βΒ Β  βΒ Β  βββ Contents.json
    βΒ Β  βββ Base.lproj
    βΒ Β  βΒ Β  βββ LaunchScreen.storyboard
    βΒ Β  βββ Data
    βΒ Β  βΒ Β  βββ MappingEntities
    βΒ Β  βΒ Β  βΒ Β  βββ HistoryEntity+Realm.swift
    βΒ Β  βΒ Β  βΒ Β  βββ TodoEntity+Firebase.swift
    βΒ Β  βΒ Β  βΒ Β  βββ TodoEntity+Realm.swift
    βΒ Β  βΒ Β  βββ PersistentStorages
    βΒ Β  βΒ Β  βΒ Β  βββ FirebaseTodoListStorage.swift
    βΒ Β  βΒ Β  βΒ Β  βββ RealmHistoryStorage.swift
    βΒ Β  βΒ Β  βΒ Β  βββ RealmTodoListStorage.swift
    βΒ Β  βΒ Β  βββ Repositories
    βΒ Β  βΒ Β  βΒ Β  βββ DefaultHistoryRepository.swift
    βΒ Β  βΒ Β  βΒ Β  βββ DefaultTodoListRepository.swift
    βΒ Β  βΒ Β  βββ Uitils
    βΒ Β  βΒ Β      βββ Protocols
    βΒ Β  βΒ Β          βββ ErrorThrowble.swift
    βΒ Β  βββ Domain
    βΒ Β  βΒ Β  βββ Entities
    βΒ Β  βΒ Β  βΒ Β  βββ History.swift
    βΒ Β  βΒ Β  βΒ Β  βββ TodoModel.swift
    βΒ Β  βΒ Β  βββ Interfaces
    βΒ Β  βΒ Β  βΒ Β  βββ Repositories
    βΒ Β  βΒ Β  βΒ Β      βββ HistoryRepository.swift
    βΒ Β  βΒ Β  βΒ Β      βββ TodoListRepository.swift
    βΒ Β  βΒ Β  βββ UseCase
    βΒ Β  βΒ Β      βββ TodoListUseCase.swift
    βΒ Β  βββ Errors
    βΒ Β  βΒ Β  βββ TodoError.swift
    βΒ Β  βββ Info.plist
    βΒ Β  βββ Presentation
    βΒ Β  βΒ Β  βββ Edit&Create
    βΒ Β  βΒ Β  βΒ Β  βββ View
    βΒ Β  βΒ Β  βΒ Β  βΒ Β  βββ CommonView.swift
    βΒ Β  βΒ Β  βΒ Β  βΒ Β  βββ CreateView.swift
    βΒ Β  βΒ Β  βΒ Β  βΒ Β  βββ CreateViewController.swift
    βΒ Β  βΒ Β  βΒ Β  βΒ Β  βββ EditView.swift
    βΒ Β  βΒ Β  βΒ Β  βΒ Β  βββ EditViewController.swift
    βΒ Β  βΒ Β  βΒ Β  βββ ViewModel
    βΒ Β  βΒ Β  βΒ Β      βββ CreateViewModel.swift
    βΒ Β  βΒ Β  βΒ Β      βββ EditViewModel.swift
    βΒ Β  βΒ Β  βββ History
    βΒ Β  βΒ Β  βΒ Β  βββ View
    βΒ Β  βΒ Β  βΒ Β  βΒ Β  βββ HistoryCell.swift
    βΒ Β  βΒ Β  βΒ Β  βΒ Β  βββ HistoryViewController.swift
    βΒ Β  βΒ Β  βΒ Β  βββ ViewModel
    βΒ Β  βΒ Β  βΒ Β      βββ HistoryCellContent.swift
    βΒ Β  βΒ Β  βΒ Β      βββ HistoryViewModel.swift
    βΒ Β  βΒ Β  βββ MainFlowCoordinator.swift
    βΒ Β  βΒ Β  βββ MainList
    βΒ Β  βΒ Β  βΒ Β  βββ ContentList
    βΒ Β  βΒ Β  βΒ Β  βΒ Β  βββ View
    βΒ Β  βΒ Β  βΒ Β  βΒ Β  βΒ Β  βββ ContentListView.swift
    βΒ Β  βΒ Β  βΒ Β  βΒ Β  βΒ Β  βββ ContentListViewController.swift
    βΒ Β  βΒ Β  βΒ Β  βΒ Β  βββ ViewModel
    βΒ Β  βΒ Β  βΒ Β  βΒ Β      βββ ContentCellItem.swift
    βΒ Β  βΒ Β  βΒ Β  βΒ Β      βββ ContentListViewModel.swift
    βΒ Β  βΒ Β  βΒ Β  βββ View
    βΒ Β  βΒ Β  βΒ Β  βΒ Β  βββ PageViewController.swift
    βΒ Β  βΒ Β  βΒ Β  βΒ Β  βββ TodoListCell.swift
    βΒ Β  βΒ Β  βΒ Β  βββ ViewModel
    βΒ Β  βΒ Β  βΒ Β      βββ PageViewModel.swift
    βΒ Β  βΒ Β  βββ Move
    βΒ Β  βΒ Β  βΒ Β  βββ View
    βΒ Β  βΒ Β  βΒ Β  βΒ Β  βββ MoveViewController.swift
    βΒ Β  βΒ Β  βΒ Β  βββ ViewModel
    βΒ Β  βΒ Β  βΒ Β      βββ MoveViewModel.swift
    βΒ Β  βΒ Β  βββ Utils
    βΒ Β  βΒ Β      βββ Extensions
    βΒ Β  βΒ Β      βΒ Β  βββ CUIHeaderView+Reactive.swift
    βΒ Β  βΒ Β      βΒ Β  βββ Date+ToString.swift
    βΒ Β  βΒ Β      βββ Protocols
    βΒ Β  βΒ Β          βββ CellIdentifiable.swift
    βΒ Β  βββ Utils
    βΒ Β      βββ Extensions
    βΒ Β          βββ Collection+Subscript.swift
    βΒ Β          βββ Reactive+ItemSelected.swift
    βΒ Β          βββ Reactive+LongPress.swift
    βββ ProjectManager.xcodeproj
    βΒ Β  βββ project.pbxproj
    βΒ Β  βββ project.xcworkspace
    βΒ Β  βΒ Β  βββ contents.xcworkspacedata
    βΒ Β  βΒ Β  βββ xcshareddata
    βΒ Β  βΒ Β  βΒ Β  βββ IDEWorkspaceChecks.plist
    βΒ Β  βΒ Β  βΒ Β  βββ swiftpm
    βΒ Β  βΒ Β  βΒ Β      βββ Package.resolved
    βΒ Β  βΒ Β  βΒ Β      βββ configuration
    βΒ Β  βΒ Β  βββ xcuserdata
    βΒ Β  βΒ Β      βββ isiwon.xcuserdatad
    βΒ Β  βΒ Β          βββ UserInterfaceState.xcuserstate
    βΒ Β  βββ xcshareddata
    βΒ Β  βΒ Β  βββ xcschemes
    βΒ Β  βΒ Β      βββ ProjectManager.xcscheme
    βΒ Β  βββ xcuserdata
    βΒ Β      βββ isiwon.xcuserdatad
    βΒ Β          βββ xcschemes
    βΒ Β              βββ xcschememanagement.plist
    βββ ProjectManagerTests
        βββ UseCaseTests
        βΒ Β  βββ MockHistoryRepository.swift
        βΒ Β  βββ MockListRepository.swift
        βΒ Β  βββ TodoListUseCaseTest.swift
        βββ ViewModelTests
            βββ ContentListViewModelTest.swift
            βββ CreateViewModelTest.swift
            βββ EditViewModelTest.swift
            βββ HistoryViewModelTest.swift
            βββ MockUesCase.swift
            βββ MoveViewModelTest.swift
            βββ PageViewModelTest.swift

```

μΆκ°μ μΌλ‘, `CustomUIKit`μΌλ‘ νΉμ  CustomUI κ°μ²΄λ₯Ό λ€λ₯Έ λͺ¨λλ‘ λΆλ¦¬νμ¬, μ½κ°μ νλ‘μ νΈ λΉλ μλ λ¨μΆκ³Ό ν΄λΉ UIκ° νμν νμΌμλ§ importνμ¬ μ¬μ©ν  μ μκ² κ°μ²΄κ° κ²°ν©λλ₯Ό λ?μ·μ΅λλ€.

## κΈ°λ₯


| λ©μΈ |
|-|
|<img src="https://i.imgur.com/b61i6VX.gif" width="200">|

- CustomSegmentControlκ³Ό ScrollViewλ₯Ό μ΄μ©νμ¬ Todo, Doing, Done μΈ ViewControllerλ₯Ό Pageing ν  μ μλλ‘ κ΅¬ννμμ΅λλ€. 

| μΆκ° | μμ  |
|-|-|
|<img src="https://i.imgur.com/PJspzTV.gif" width="200">|<img src="https://i.imgur.com/2W65Nvv.gif" width="200">|

- μλ¨ NavigationBarμ Plus Buttonλ₯Ό ν΄λ¦­νμ¬, μΆκ°λ₯Ό μν νλ©΄μ λͺ¨λ¬ νμμΌλ‘ presentνλλ‘ νμμ΅λλ€.
- Cellλ₯Ό ν΄λ¦­νκ² λλ©΄, ν΄λΉ Cellμ μ λ³΄κ° μλ ₯λμ΄ μλ μμ  νλ©΄μ΄ push λκ³ , μλ¨μ Edit buttonμ Tapνλ©΄, μμ  κΈ°λ₯μ΄ νμ±ν λ©λλ€.
- μΆκ°λ° μμ λ λ°μ΄ν°λ `Realm`μ μ΄μ©ν Local DB μ μ₯λκ³ , Appμ΄ μ’λ£λλ©΄, μ’λ£ μμ μ μλ ₯λμ΄μλ λ°μ΄ν°λ₯Ό `Firebase`λ₯Ό μ΄μ©ν Remote DBμ μ μ₯λ©λλ€.
- `Firebase`μ μ μ₯λμ΄ μλ λ°μ΄ν°λ μ¬μ©μκ° Appμ μ­μ νκ³ , λ€μ λ€μ΄λ°μμ λ μ½μ΄μ€λλ‘ νμμ΅λλ€.

| μ΄λ λ° μ­μ  | History |
|-|-|
|<img src="https://i.imgur.com/EJKGLaf.gif" width="200">|<img src="https://i.imgur.com/R0FI6SR.gif" width="200">|

- ν΄λΉ Cellμ longpressνκ² λλ©΄ λκ°μ Moveing Buttonκ³Ό Delete Buttonμ΄ popover νμμΌλ‘ λνλκ² λ©λλ€.
- μλ¨ NavigationBarμ Watch Buttonλ₯Ό ν΄λ¦­λ©΄, History νλ©΄μΌλ‘ μ νλ©λλ€. ν΄λΉ νλ©΄μμ μ§κΈκΉμ§ κΈ°λ‘μ λ³Ό μ μμ΅λλ€.

## νμ€νΈ

![](https://i.imgur.com/vPYZaCw.png)

UseCaseμ κ° νλ©΄μ ViewModelμ λν΄μ Unit Testλ₯Ό μ§ννμμ΅λλ€.

κ° νμμ μμ‘΄μ±μ μμ‘΄μ± μ£Όμκ³Ό protocolμ μ¬μ©νμ¬ Testableνκ² κ΅¬ννμμΌλ©°, Testλ₯Ό μν Test Double νμμ κ΅¬ννμ¬ λλ¦½μ μΈ Testκ° λ  μ μλλ‘ νμμ΅λλ€.

