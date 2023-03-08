import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'connective_rect_model.dart';

// 각각 애니메이션을 연결해서 구현
// ConnectiveRectModel 을 기준으로 사용
// preWork 애니메이션은 최초 빌드시 동작하는 1회성 애니메이션
// 메인 애니메이션은 List<ConnectiveRectModel> 를 기준으로 자동 연결
// 추가 옵션필요시 state를 extends하여 사용

class CrawController extends ChangeNotifier {
  bool waitStartAnim = false;

  Function(int)? _startAnimation;

  forwardMain(int index) {
    _startAnimation?.call(index);
  }
}

class ConnectiveRectAnimationWidget extends StatefulWidget {
  const ConnectiveRectAnimationWidget({
    Key? key,
    this.preModel,
    required this.mainModels,
    this.onTap,
    required this.child,
    this.crawController,
  }) : super(key: key);

  final ConnectiveRectModel? preModel;
  final List<ConnectiveRectModel> mainModels;
  final GestureTapCallback? onTap;
  final Widget child;
  final CrawController? crawController;

  @override
  State<ConnectiveRectAnimationWidget> createState() => ConnectiveRectAnimationWidgetState();
}

class ConnectiveRectAnimationWidgetState extends State<ConnectiveRectAnimationWidget>
    with TickerProviderStateMixin {
  int _curIndex = 0;

  int get curIndex => _curIndex;

  AnimationController? preWorkController;
  Animation<RelativeRect>? preWorkAnimation;

  final List<AnimationController> controllers = [];
  final List<Animation<RelativeRect>> animations = [];

  // preWork 애니메이션 세팅
  _setPreWorkAnimation() {
    if (widget.preModel == null) return;

    preWorkController = AnimationController(vsync: this, duration: widget.preModel!.duration)
      ..forward();
    preWorkAnimation = widget.preModel!.relativeRectTween
        .animate(CurvedAnimation(parent: preWorkController!, curve: widget.preModel!.curve));
    preWorkAnimation!.addStatusListener((status) {
      preWorkController?.dispose();
      preWorkController = null;
      preWorkAnimation = null;
      setState(() {});
    });
  }

  // 메인 애니메이션 세팅
  _setAnimations() {
    for (int i = 0; i < widget.mainModels.length; i++) {
      final controller = AnimationController(vsync: this, duration: widget.mainModels[i].duration);
      controllers.add(controller);
      final anim = widget.mainModels[i].relativeRectTween
          .animate(CurvedAnimation(parent: controller, curve: widget.mainModels[i].curve));
      if (i == widget.mainModels.length - 1) {
        // 마지막 애니메이션은 index를 처음으로 변경하지만 자동재생은 하지 않음
        anim.addStatusListener((status) {
          if (status == AnimationStatus.completed && mounted) {
            _curIndex = 0;
            controllers[0].reset();
            setState(() {});
          }
        });
      } else {
        // 애니메이션 끝나면 자동으로 다음 애니메이션 재생
        anim.addStatusListener((status) {
          if (status == AnimationStatus.completed && mounted) {
            _curIndex = i + 1;
            controllers[_curIndex].reset();
            controllers[_curIndex].forward();
            setState(() {});
          }
        });
      }
      animations.add(anim);
    }
  }

  _startAnimation(int index) {
    if (mounted) {
      if (index > widget.mainModels.length - 1) {
        log('$runtimeType<$hashCode> :: Index Range Error!');
        return;
      }

      preWorkController?.reset();
      for (final c in controllers) {
        c.reset();
      }
      _curIndex = index;
      controllers[index].forward();
      setState(() {});
    } else {
      log('$runtimeType<$hashCode> :: is not mounted!');
    }
  }

  @override
  @mustCallSuper
  void initState() {
    super.initState();

    _setPreWorkAnimation();
    _setAnimations();

    widget.crawController?._startAnimation = _startAnimation;
  }

  @override
  @mustCallSuper
  void dispose() {
    preWorkController?.dispose();
    for (final c in controllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  @mustCallSuper
  Widget build(BuildContext context) {
    if (widget.mainModels.isEmpty) {
      log('$runtimeType<$hashCode> :: Animation List is Empty Error!');
      return widget.child;
    }

    return ChangeNotifierProvider<CrawController?>(
      create: (_) => widget.crawController,
      child: Consumer<CrawController?>(builder: (_, crawController, __) {
        return PositionedTransition(rect: _curAnimation, child: curBody);
      }),
    );
  }

  // 현재 위젯 애니메이션 가져오기
  Animation<RelativeRect> get _curAnimation =>
      preWorkAnimation != null ? preWorkAnimation! : animations[_curIndex];

  // 현재 위젯 탭 이벤트 가져오기
  // 0번 이벤트를 시작이벤트로 간주해서 동작
  @mustCallSuper
  Widget get curBody {
    return GestureDetector(
      onTap: () {
        if (controllers[_curIndex].isAnimating || preWorkController?.isAnimating == true) return;
        widget.onTap?.call();
        _curIndex = 0;
        if (_curIndex != 0) setState(() {});
        controllers[0].forward();
      },
      child: widget.child,
    );
  }
}
