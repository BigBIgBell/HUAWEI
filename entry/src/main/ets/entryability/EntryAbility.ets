import UIAbility from '@ohos.app.ability.UIAbility';
import window from '@ohos.window';

export default class EntryAbility extends UIAbility {
  onWindowStageCreate(windowStage: window.WindowStage) {
    try {
      windowStage.loadContent('pages/Index');
    } catch (error) {
      console.error('加载页面错误:', error);
    }
  }
}