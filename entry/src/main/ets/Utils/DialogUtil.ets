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
import { CommonConstants } from '../common/CommonConstant';
import Logger from './Logger';

/**
 * Pop up a message box.
 *
 * @param message Message.
 */
export function showDialog(title:string='',message: ResourceStr=''): void {
  let newMessage = message.toString();
  if (newMessage.length > CommonConstants.SUB_LENGTH) {
    message = newMessage.substring(0, CommonConstants.SUB_LENGTH);
  }
  AlertDialog.show(
    {
      title: title,
      message: message,
      confirm: {
        value: '确认',
        action: () => {
          Logger.info('Button-clicking callback');
        }
      },
      cancel: () => {
        Logger.info('Closed callbacks');
      }
    }
  )
}