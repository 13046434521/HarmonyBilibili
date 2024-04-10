/*
 * Copyright (c) 2022 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

/**
 * Common constants for all features.
 */
export class CommonConstants {

  /**
   * User Center Link.
   */
  static readonly USER_CENTER_URL = 'https://id1.cloud.huawei.com/AMW/portal/userCenter/index.html?' +
  'service=http://developer.huawei.com/consumer/cn/#/accountCenter/userCenter';

  /**
   * About Links.
   */
  static readonly USER_ABOUT_URL = 'https://id1.cloud.huawei.com/AMW/portal/userCenter/index.html?' +
  'service=http://developer.huawei.com/consumer/cn/#/accountCenter/about';

  /**
   * Font size of navigation text.
   */
  static readonly NAVIGATOR_SIZE = '20fp';

  /**
   * Font size of page title text.
   */
  static readonly TITLE_SIZE = '18fp';

  /**
   * Font size of button text.
   */
  static readonly BUTTON_SIZE = '14fp';

  /**
   * Margin of divider.
   */
  static readonly DIVIDER_MARGIN = 12;

  /**
   * Height of divider.
   */
  static readonly DIVIDER_HEIGHT = '2.2%';

  /**
   * Url of verify page.
   */
  static readonly PAGE_VERIFY = 'pages/Verify';

  /**
   * Url of index page.
   */
  static readonly PAGE_INDEX = 'pages/WebIndex';

  /**
   * Maximum of width.
   */
  static readonly FULL_WIDTH = '100%';

  /**
   * Maximum of height.
   */
  static readonly FULL_HEIGHT = '100%';

  /**
   * Width of back icon.
   */
  static readonly BACK_WIDTH = '6.7%';

  /**
   * Height of back icon.
   */
  static readonly BACK_HEIGHT = '3.1%';

  /**
   * Height of web component.
   */
  static readonly WEB_HEIGHT = '60%';

  /**
   * Width of web component.
   */
  static readonly WEB_WIDTH = '90%';

  /**
   * Height of page title text.
   */
  static readonly PAGE_TITLE_HEIGHT = '3.1%';

  /**
   * Width of page title text.
   */
  static readonly PAGE_TITLE_WIDTH = '25.6%';

  /**
   * Top margin of navigation.
   */
  static readonly NAVIGATOR_MARGIN_TOP = '1.7%';

  /**
   * Left margin of navigation.
   */
  static readonly NAVIGATOR_MARGIN_LEFT = '10%';

  /**
   * Deeper font weight than normal font.
   */
  static readonly FONT_WEIGHT_DEEPER = 500;

  /**
   * Top margin of app title.
   */
  static readonly APP_TITLE_MARGIN_TOP = '15vp';

  /**
   * Left margin of app title.
   */
  static readonly APP_TITLE_MARGIN_LEFT = '26vp';

  /**
   * Bottom margin of web.
   */
  static readonly WEB_MARGIN_BOTTOM = '90vp';

  /**
   * Length of truncated.
   */
  static readonly SUB_LENGTH: number = 300;
}

/**
 * Type of cookie Operation.
 */
export enum CookieOperation {
  GET_COOKIE = '读取cookie',
  SET_COOKIE = '设置cookie',
  DELETE_COOKIE = '删除cookie',
  VERIFY_COOKIE = '验证cookie'
}