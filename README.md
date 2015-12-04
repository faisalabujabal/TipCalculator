# Pre-work - Tip Calculator

Tip Calculator is a tip calculator application for iOS.

Submitted by: Faisal Abu Jabal

Time spent: 15 hours spent in total

## User Stories

The following **required** functionality is complete:

* [yes] User can enter a bill amount, choose a tip percentage, and see the tip and total values.
* [yes] Settings page to change the default tip percentage.

The following **optional** features are implemented:
* [yes] UI animations
* [not yet] Remembering the bill amount across app restarts (if <10mins)
* [yes] Using locale-specific currency and currency thousands separators.
* [yes] Making sure the keyboard is always visible and the bill amount is always the first responder. This way the user doesn't have to tap anywhere to use this app. Just launch the app and start typing.

The following **additional** features are implemented:

- [yes] calculate the tip by percentage
- [yes] a different view controller to calculate tip by the service rating
- [yes] tab controller to handle 3 different view controllers
- [yes] the user can change the tip amount by using a slider or typing it manually
- [yes] settings menu to handle the minimum and maximum values for the slider and the ability to change the the star rating          tip representation
- [yes] A stepper that allows the user to split the tab into a cetain number of people
- [yes] the bill amount is passed through every view controller
- [yes] swipe gestures to move to different view controllers and to dismiss the keyboard 

## Video Walkthrough 

Here's a walkthrough of implemented user stories:

<img src='http://i.imgur.com/b8jXDHn.gif' title='Video Walkthrough Part 1' width='' alt='Video Walkthrough Part 1' />
<img src="http://i.imgur.com/ipwQUhW.gifv" title = "Video Walkthrough Part 2"/>
GIF created with [LiceCap](http://www.cockos.com/licecap/).


## Notes

- the application is designed to work on 4" display, but can work on larger displays
- the hardest part was understanding how to pass the billing amount through view controllers

## License

    Copyright 2015 Faisal Abu Jabal

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
