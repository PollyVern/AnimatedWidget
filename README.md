# AnimatedWidget on LockScreen
# From task to AppStore release
| Image | Video |
| --- | --- |
| <img src="https://github.com/PollyVern/AnimatedWidget/blob/main/Resources/jpg_static.jpg" width="300"> | <img src="https://github.com/PollyVern/AnimatedWidget/blob/main/Resources/screen.mov" width="300"> |



## Task
Create an animated widget for a plant app ["Cucullata"](https://apps.apple.com/ru/app/cucullata/id6463136584) on LockedScreen

## Problems
1. Apple does not provide methods to add animation of a format such as gif to the code
2. By timer to achieve the program method of changing images - does not work
3. There was a possible option to change the static picture through the API every second, but by doing so it loads the back, processor and apple rejects the apps. This solution doesn't work

## Solutions

### Step 1: Stopwatch
The only method that can update every second in LockScreen is a stopwatch.
```swift
Text(Calendar.current.startOfDay(for: Date()), style: .timer)
```
It shows consecutive numbers as 1 → 2 → 3 → ...
```swift
Text(Calendar.current.startOfDay(for: Date()), style: .timer)
            .contentTransition(.identity) // numbers animation
            .lineLimit(1) // one line
            .multilineTextAlignment(.center) // set alignment center or trailing
            .truncationMode(.head) // remove first characters
```
### Step 2: Font and design logic
Since the timer consists of a font, or rather characters from 0 to 9. So we need to create a font. The logic will be as follows:

<img src="https://github.com/PollyVern/AnimatedWidget/blob/main/Resources/png_stopwatch.png" width="600">

Create a font in [https://glyphsapp.com](https://glyphsapp.com) or any other editor you need for your tasks.
Based on the bugs, found the best solution for the image:
- png format to 1x size 300х300 (in Sketch)
- in Artboard, leave the left part empty, because otherwise you will see part of the text on a fully turned off screen (I'll tell you about it below).
It should work like this in Glyph:

<img src="https://github.com/PollyVern/AnimatedWidget/blob/main/Resources/png_font_unit.png" width="300">

Set different images in symbols 0 to 9. And export font with parameters: `TrueType`, `.ttf`, `delete overlay`

### Step 3: Font and code
Set font and oddset to timer. Offset maybe different for different pictures. Don't forget install font in XCode.
```swift
            .font(Font.custom("DynamicFont-Regular", size: 48))
            .offset(x: -68, y: 10)
```
### Step 4: Show widget and new problem
Yay! We animated the widget! But we faced a problem that it doesn't work when the screen is turned off in Always-On-Display mode. 
You can use `UIApplicationProtectedDataWillBecomeUnavailable` and `UIApplicationProtectedDataDidBecomeAvailable` through the main target to check the locked screen. But, it doesn't work always and if the application is in the background. That's why you can get crafty and put a static picture under the font

### Step 5: Finish! You create animated widget!
| Examples |  |
| --- | --- |
| AnimatedWidgetExtension | [Link](https://github.com/PollyVern/AnimatedWidget/blob/main/ResourcesXCode/AnimatedWidgetExtension.swift) |
| Font | [Link](https://github.com/PollyVern/AnimatedWidget/blob/main/ResourcesXCode/DynamicFont.ttf) |
| Image | [Link](https://github.com/PollyVern/AnimatedWidget/blob/main/ResourcesXCode/png_grassUnit1.png) |

## Example in AppStore
|<img src="https://github.com/PollyVern/AnimatedWidget/blob/main/Resources/png_CucullataIcon.png" width="50">| [https://apps.apple.com/ru/app/cucullata/id6463136584](https://apps.apple.com/ru/app/cucullata/id6463136584)|
| --- | --- |


# Liked the project?
Tap to star ⭐️ and spread the word!
