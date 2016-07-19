透明/不透明 PresentedVC 与 presentingViewController 生命周期函数之间的关系

总结:

整个 demo 流程为:  1⃣️ navigationController —> rootViewController : ViewController     2⃣️ —> push : pushedVC     3⃣️ —> addChildController : childVC      4⃣️—> 透明/不透明 present : presentVC1      5⃣️—> 正常 present : presentVC2

在第4⃣️步同样是 [self presentViewController:presentedVC1 animated:YES completion:nil]; (self 为 childVC)

区别:

以下2句决定透明与否.

self.definesPresentationContext = YES; (self 为 childVC)
A Boolean value that indicates whether this view controller’s view is covered when the view controller or one of its descendants presents a view controller.

presentedVC1.modalPresentationStyle = UIModalPresentationOverCurrentContext;
A presentation style where the content is displayed over a view controller’s content whose definesPresentationContext property is YES. UIKit may walk up the view controller hierarchy to find a view controller that wants to define the presentation context. The views beneath the presented content are not removed from the view hierarchy when the presentation finishes. So if the presented view controller does not fill the screen with opaque content, the underlying content shows through.

- 透明/不透明 VC (PresentedVC1) 的 presentingVC 的区别:


现象说明:
透明的话, (PresentedVC1的) presentingVC 就是上一个 VC (childVC); 不透明的话, (PresentedVC1的) presentingVC 是上个页面的 VC (childVC) 的 navigationController.

原因分析:
A presentation style where the content is displayed over a view controller’s content whose definesPresentationContext property is YES. UIKit may walk up the view controller hierarchy to find a view controller that wants to define the presentation context. The views beneath the presented content are not removed from the view hierarchy when the presentation finishes. So if the presented view controller does not fill the screen with opaque content, the underlying content shows through.

The object on which you call this method may not always be the one that handles the presentation. Each presentation style has different rules governing its behavior. For example, a full-screen presentation must be made by a view controller that itself covers the entire screen. If the current view controller is unable to fulfill a request, it forwards the request up the view controller hierarchy to its nearest parent, which can then handle or forward the request.

-  生命周期的区别:

现象说明:
childVC 透明 present presentedVC1, pushedVC 及 childVC 没有调用 viewWillAppear/viewDidAppear; 而当再 present 一个正常的 presentVC2的时候, pushedVC 及 childVC 的生命周期会跟着一起调用, 而 presentedVC1 的生命周期却没有调用;
相反, 不透明的页面, 就很正常, 在 presentedVC1 显示的时候, pushed/childVC 随即调用了 viewWillDisappear/viewDidDisappear. 之后的 presentedVC2 与 pushedVC /childVC 无关系.

原因分析:
A presentation style where the content is displayed over a view controller’s content whose definesPresentationContext property is YES. UIKit may walk up the view controller hierarchy to find a view controller that wants to define the presentation context. The views beneath the presented content are not removed from the view hierarchy when the presentation finishes. So if the presented view controller does not fill the screen with opaque content, the underlying content shows through.

- 透明/不透明 VC (presentedVC1) 再 present 另一个普通 VC (presentedVC2) 时, 另一个 VC (presentedVC2) 的 presentingVC的区别

现象说明:
即使都可以写成 [self presentViewController:presentedVC2 animated:YES completion:nil]; 但是实际执行 present操作的 controller 并不相同.
透明的 其实执行的是 [self.presentingViewController.navigationController presentViewController:vc2 animated:YES completion:nil];
而不透明的就真的是执行了[self presentViewController:presentedVC2 animated:YES completion:nil];

原因分析:
The object on which you call this method may not always be the one that handles the presentation. Each presentation style has different rules governing its behavior. For example, a full-screen presentation must be made by a view controller that itself covers the entire screen. If the current view controller is unable to fulfill a request, it forwards the request up the view controller hierarchy to its nearest parent, which can then handle or forward the request.

以下是调试日志, 区别已用特殊颜色标识

TRANSPARENT

2016-07-19 15:24:23.887 testPresent[3000:127671] presentingVC viewDidLoad
2016-07-19 15:24:23.890 testPresent[3000:127671] ++++++++presentingVC viewWillAppear
2016-07-19 15:24:23.897 testPresent[3000:127671] presentingVC viewDidAppear
2016-07-19 15:24:25.530 testPresent[3000:127671] self = <ViewController: 0x7fea2c92b4b0>, self.navigationController = <UINavigationController: 0x7fea2d012800>
2016-07-19 15:24:25.530 testPresent[3000:127671] presentingVC viewWillDisappear
2016-07-19 15:24:25.530 testPresent[3000:127671] PushedVC viewDidLoad
2016-07-19 15:24:25.531 testPresent[3000:127671] ++++++++PushedVC viewWillAppear
2016-07-19 15:24:26.035 testPresent[3000:127671] presentingVC viewDidDisappear
2016-07-19 15:24:26.035 testPresent[3000:127671] PushedVC viewDidAppear
2016-07-19 15:24:26.036 testPresent[3000:127671] self = <PushedVC: 0x7fea2cc12ce0>, self.navigationController = <UINavigationController: 0x7fea2d012800>
2016-07-19 15:24:27.810 testPresent[3000:127671] ChildVC viewDidLoad
2016-07-19 15:24:27.810 testPresent[3000:127671] ++++++++ChildVC viewWillAppear
2016-07-19 15:24:27.811 testPresent[3000:127671] ChildVC viewDidAppear
2016-07-19 15:24:27.811 testPresent[3000:127671] self = <ChildVC: 0x7fea2b628480>, self.navigationController = <UINavigationController: 0x7fea2d012800>
2016-07-19 15:24:28.967 testPresent[3000:127671] presentedVC  1 viewDidLoad
2016-07-19 15:24:35.817 testPresent[3000:127671] presentedVC  1 viewWillAppear
2016-07-19 15:24:36.318 testPresent[3000:127671] presentedVC  1 viewDidAppear
2016-07-19 15:24:36.319 testPresent[3000:127671] self = <PresentedVC1: 0x7fea2c969650>, self.presentingViewController = <ChildVC: 0x7fea2b628480>, self.presentingViewController.navigationController = <UINavigationController: 0x7fea2d012800>
2016-07-19 15:24:37.620 testPresent[3000:127671] PresentedVC  2 viewDidLoad
2016-07-19 15:24:37.622 testPresent[3000:127671] PushedVC viewWillDisappear
2016-07-19 15:24:37.622 testPresent[3000:127671] ChildVC viewWillDisappear
2016-07-19 15:24:37.622 testPresent[3000:127671] PresentedVC  2 viewWillAppear
2016-07-19 15:24:38.124 testPresent[3000:127671] PresentedVC  2 viewDidAppear
2016-07-19 15:24:38.124 testPresent[3000:127671] PushedVC viewDidDisappear
2016-07-19 15:24:38.124 testPresent[3000:127671] ChildVC viewDidDisappear
016-07-19 15:25:14.104 testPresent[3163:136396] PresentedVC  2 viewWillDisappear
2016-07-19 15:25:14.105 testPresent[3163:136396] ++++++++PushedVC viewWillAppear
2016-07-19 15:25:14.105 testPresent[3163:136396] ++++++++ChildVC viewWillAppear
2016-07-19 15:25:14.609 testPresent[3163:136396] PushedVC viewDidAppear
2016-07-19 15:25:14.609 testPresent[3163:136396] self = <PushedVC: 0x7ff1eb615c80>, self.navigationController = <UINavigationController: 0x7ff1ec813c00>
2016-07-19 15:25:14.609 testPresent[3163:136396] ChildVC viewDidAppear
2016-07-19 15:25:14.610 testPresent[3163:136396] self = <ChildVC: 0x7ff1eb61b700>, self.navigationController = <UINavigationController: 0x7ff1ec813c00>
2016-07-19 15:25:14.610 testPresent[3163:136396] PresentedVC  2 viewDidDisappear
2016-07-19 15:25:14.610 testPresent[3163:136396] PresentedVC  2 dealloc

NON-TRANSPARENT

2016-07-19 15:25:22.306 testPresent[3055:129404] presentingVC viewDidLoad
2016-07-19 15:25:22.309 testPresent[3055:129404] ++++++++presentingVC viewWillAppear
2016-07-19 15:25:22.317 testPresent[3055:129404] presentingVC viewDidAppear
2016-07-19 15:25:25.345 testPresent[3055:129404] self = <ViewController: 0x7f88fac3c0b0>, self.navigationController = <UINavigationController: 0x7f88fd037600>
2016-07-19 15:25:25.346 testPresent[3055:129404] presentingVC viewWillDisappear
2016-07-19 15:25:25.346 testPresent[3055:129404] PushedVC viewDidLoad
2016-07-19 15:25:25.346 testPresent[3055:129404] ++++++++PushedVC viewWillAppear
2016-07-19 15:25:25.854 testPresent[3055:129404] presentingVC viewDidDisappear
2016-07-19 15:25:25.854 testPresent[3055:129404] PushedVC viewDidAppear
2016-07-19 15:25:25.854 testPresent[3055:129404] self = <PushedVC: 0x7f88fc913bf0>, self.navigationController = <UINavigationController: 0x7f88fd037600>
2016-07-19 15:25:26.645 testPresent[3055:129404] ChildVC viewDidLoad
2016-07-19 15:25:26.646 testPresent[3055:129404] ++++++++ChildVC viewWillAppear
2016-07-19 15:25:26.647 testPresent[3055:129404] ChildVC viewDidAppear
2016-07-19 15:25:26.647 testPresent[3055:129404] self = <ChildVC: 0x7f88fad4fff0>, self.navigationController = <UINavigationController: 0x7f88fd037600>
2016-07-19 15:25:27.802 testPresent[3055:129404] presentedVC  1 viewDidLoad
2016-07-19 15:25:27.804 testPresent[3055:129404] PushedVC viewWillDisappear
2016-07-19 15:25:27.804 testPresent[3055:129404] ChildVC viewWillDisappear
2016-07-19 15:25:27.804 testPresent[3055:129404] presentedVC  1 viewWillAppear
2016-07-19 15:25:28.306 testPresent[3055:129404] presentedVC  1 viewDidAppear
2016-07-19 15:25:28.306 testPresent[3055:129404] self = <PresentedVC1: 0x7f88fae2a640>, self.presentingViewController = <UINavigationController: 0x7f88fd037600>, self.presentingViewController.navigationController = (null)
2016-07-19 15:25:28.309 testPresent[3055:129404] PushedVC viewDidDisappear
2016-07-19 15:25:28.309 testPresent[3055:129404] ChildVC viewDidDisappear
2016-07-19 15:25:29.357 testPresent[3055:129404] PresentedVC  2 viewDidLoad
2016-07-19 15:25:29.359 testPresent[3055:129404] presentedVC  1 viewWillDisappear
2016-07-19 15:25:29.359 testPresent[3055:129404] PresentedVC  2 viewWillAppear
2016-07-19 15:25:29.861 testPresent[3055:129404] PresentedVC  2 viewDidAppear
2016-07-19 15:25:29.861 testPresent[3055:129404] presentedVC  1 viewDidDisappear
2016-07-19 15:26:56.819 testPresent[3204:138341] PresentedVC  2 viewWillDisappear
2016-07-19 15:26:56.819 testPresent[3204:138341] presentedVC  1 viewWillAppear
2016-07-19 15:26:57.321 testPresent[3204:138341] presentedVC  1 viewDidAppear
2016-07-19 15:26:57.321 testPresent[3204:138341] self = <PresentedVC1: 0x7fa778421310>, self.presentingViewController = <UINavigationController: 0x7fa778846800>, self.presentingViewController.navigationController = (null)
2016-07-19 15:26:57.322 testPresent[3204:138341] PresentedVC  2 viewDidDisappear
2016-07-19 15:26:57.322 testPresent[3204:138341] PresentedVC  2 dealloc