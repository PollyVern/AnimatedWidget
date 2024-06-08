# AnimatedWidget on LockScreen
# From task to AppStore release
## Task
Create an animated widget for a plant app ["Cucullata"](https://apps.apple.com/ru/app/cucullata/id6463136584) on LockedScreen

## First problems
1. Apple does not provide methods to add animation of a format such as gif to the code
2. By timer to achieve the program method of changing images - does not work
3. There was a possible option to change the static picture through the API every second, but by doing so it loads the back, processor and apple rejects the apps. This solution doesn't work

## MARK

## Solutions

### Stopwatch
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
