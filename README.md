# connective_rect_animation_widget

## ConnectiveRectAnimationWidget

- 각각 애니메이션을 연결해서 구현
- ConnectiveRectModel 을 기준으로 사용
- preWork 애니메이션은 최초 빌드시 동작하는 1회성 애니메이션
- 메인 애니메이션은 List<ConnectiveRectModel> 를 기준으로 자동 연결
- 추가 옵션필요시 state를 extends하여 사용

## AddRotationWidget

- connective_rect_animation.dart + 회전 애니메이션
