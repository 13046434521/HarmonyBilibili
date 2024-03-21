import AbilityConstant from '@ohos.app.ability.AbilityConstant';
import hilog from '@ohos.hilog';
import UIAbility from '@ohos.app.ability.UIAbility';
import Want from '@ohos.app.ability.Want';
import window from '@ohos.window';
import { UiWindow } from '@ohos.UiTest';
import colorSpaceManager from '@ohos.graphics.colorSpaceManager';

export default class EntryAbility extends UIAbility {
  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam) {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onCreate');
  }

  onDestroy() {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onDestroy');
  }

  onWindowStageCreate(windowStage: window.WindowStage) {
    // 开发者可以在适当的时机，如主窗口上按钮点击事件等，创建子窗口。并不一定需要在onWindowStageCreate调用，这里仅作展示
    // 1.获取应用主窗口。
    let windowClass = null;
    windowStage.getMainWindow((err, data) => {
      if (err.code) {
        console.error('Failed to obtain the main window. Cause: ' + JSON.stringify(err));
        return;
      }
      windowClass = data;
      console.info('Succeeded in obtaining the main window. Data: ' + JSON.stringify(data));

      // 2.实现沉浸式效果：设置导航栏、状态栏不显示。
      let names = [];
      windowClass.setWindowSystemBarEnable(names, (err) => {
        if (err.code) {
          console.error('Failed to set the system bar to be visible. Cause:' + JSON.stringify(err));
          return;
        }
        console.info('Succeeded in setting the system bar to be visible.');
      });
    })
    // 导航栏设置颜色
    // try {
    //   let SystemBarProperties = {
    //     statusBarColor: '#ffffff',
    //     navigationBarColor: '#fffff1',
    //     //以下两个属性从API Version8开始支持
    //     statusBarContentColor: '#000000',
    //     navigationBarContentColor: '#000000'
    //   };
    //   let promise = data.setWindowSystemBarProperties(SystemBarProperties);
    //   promise.then(() => {
    //     console.info('Succeeded in setting the system bar properties.');
    //   }).catch((err) => {
    //     console.error('Failed to set the system bar properties. Cause: ' + JSON.stringify(err));
    //   });
    // } catch (exception) {
    //   console.error('Failed to set the system bar properties. Cause: ' + JSON.stringify(exception));
    // }

    // 3.为沉浸式窗口加载对应的目标页面。
    windowStage.loadContent("pages/SplashPage", (err) => {
      if (err.code) {
        console.error('Failed to load the content. Cause:' + JSON.stringify(err));
        return;
      }
      console.info('Succeeded in loading the content.');
    });
  }

  onWindowStageDestroy() {
    // Main window is destroyed, release UI related resources
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');
  }

  onForeground() {
    // Ability has brought to foreground
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onForeground');
  }

  onBackground() {
    // Ability has back to background
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onBackground');
  }
}
