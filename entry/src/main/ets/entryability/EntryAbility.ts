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
    // Main window is created, set main page for this ability
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageCreate');

    windowStage.loadContent('pages/Index', (err, data) => {
      if (err.code) {
        hilog.error(0x0000, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
        return;
      }
      hilog.info(0x0000, 'testTag', 'Succeeded in loading the content. Data: %{public}s', JSON.stringify(data) ?? '');
    });

    windowStage.getMainWindow().then((data) => {
      try {
        let SystemBarProperties = {
          statusBarColor: '#ffffff',
          navigationBarColor: '#fffff1',
          //以下两个属性从API Version8开始支持
          statusBarContentColor:'#000000',
          navigationBarContentColor:'#000000'
        };
        let promise = data.setWindowSystemBarProperties(SystemBarProperties);
        promise.then(()=> {
          console.info('Succeeded in setting the system bar properties.');
        }).catch((err)=>{
          console.error('Failed to set the system bar properties. Cause: ' + JSON.stringify(err));
        });
      } catch (exception) {
        console.error('Failed to set the system bar properties. Cause: ' + JSON.stringify(exception));
      }
      // data.setWindowSystemBarEnable(['navigation'])
/*      let names:Array<string>= ['navigation']
      try {
        data.setWindowSystemBarEnable(names, (err) => {
          if (err.code) {
            console.error('Failed to set the system bar to be invisible. Cause:' + JSON.stringify(err));
            return;
          }
          console.info('Succeeded in setting the system bar to be invisible.');
        });
      } catch (exception) {
        console.error('Failed to set the system bar to be invisible. Cause:' + JSON.stringify(exception));
      }*/
    })
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
