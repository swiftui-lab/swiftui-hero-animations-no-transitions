[![MIT License](https://img.shields.io/github/license/ApolloZhu/swift_qrcodejs.svg)](./LICENSE) [![Swift 5.3](https://img.shields.io/badge/Swift-5.3-green.svg)](https://swift.org) [![iOS 14.0](https://img.shields.io/badge/iOS-14.0-green)](https://developer.apple.com)

# Description

This project is part of the article ["MatchedGeometryEffect - Part 2"](https://swiftui-lab.com/matchedGeometryEffect-part2), which describes the concepts needed to create a hero animation using **`matchedGeometryEffect()`**. Unlike part 1, it does so without using custom transitions.

# How to Use the Project
The project was tested on an iPad. Launching the project on an iPhone may requiring some tweaking. Especially, the modal size.

# Source Code

To better navigate the project, here is a list of all the source code files, together with a quick description.

## SwiftUI Views

### `ContentView.swift`
At the top of the hierarchy, the ContentView just creates the Wildlife view.

### `Wildlife.swift`
This is the main view of the project. It assembles everything together. It is a large `ZStack`, with the following three layers:

* **Layer 1**, `zIndex = 1`: Main view containing the header (title + favorites).
* **Layer 2**, `zIndex = 2`: In the middle layer, there is a backdrop that blurs the first layer when there is modal present.
* **Layer 3**, `zIndex = 3`: When there is a grid or a favorite item selected, this top layer displays the modal that presents the data.

### `AnimalImage.swift`
A small view for drawing the images of the grid cells.

### `BlurView.swift` and `VisualEffectView.swift`
A view used to blur the grid, using a `UIViewRepresentable` of UIKit's `UIVisualEffect`

### `FavoriteView.swift`
This view draws the favorite icon shown at the top. Since this icons should morph between the cell where they fly from, to their final look, it needs to be animatable. To achieve that, this view is really an `EmptyView()` with an animatable modifier which actually does all the work.
```swift
EmptyView().modifier(FavoriteMod(image: image, pct: pct))
```

The modifier uses an animatable `pct` value, which represent a percentage of how much along the flight we are. (0.0 when the view is at the grid cell size and position, and 1.0 when the view is already at its final size and position in the favorites area).


### `StarView.swift`
A small view with a star symbol to show in a grid cell, when the item is marked as favorite.

### `ModalView.swift`
This view represents the modal shown when either a grid cell or a favorite icon is tapped once. Since the modal should morph between the cell where it flies from, to its final look, size and position, it needs to be animatable. To achieve that, this view is really an `EmptyView()` with an animatable modifier which actually does all the work.

```swift
EmptyView().modifier(ModalModMod(image: image, pct: pct))
```

The modifier uses an animatable `pct` value, which represent a percentage of how much along the flight we are. (0.0 when the view is at the grid cell size and position, and 1.0 when the view is already at the modal final size and position).


### `RectangleToCircle.swift`
This view is used to morph between a rectangle and a circle and vice-versa. It is useful to gradually change the shape of images so it adjusts from one look to another. For example, if an image is a rounded circle in the grid, but a full circle in the favorite area, this view will gradually morph from one shape to the other.


### `TitleView.swift`
A small view that draws the title. The title can be tapped to enable animation debug (i.e., very slow animations).

<hr>

## Extensions

### `CGSize+Random.swift`
A useful extension to generate random sizes in a given range. Used by the favorite area to apply a random offset when a new icon is added. It creates a little shake illusion.

### `Animation.swift`
Provides a name for the animations used in the project so they are centralized and consistent in one place.

### `EnvironmentValues.swift`
Defines to environment keys:

|EnvironmentKey name|Description|
|-------------------|-----------|
|`\.gridRadiusPct`|Use this key to set the corner radius used by grid cells.|
|`\.gridShadow`|Use this key to set the shadow radius used by grid cells.|
|`\.favRadiusPct`|Use this key to set the corner radius used by favorite icons.|
|`\.favShadow`|Use this key to set the shadow radius used by favorite icons.|

There are also some helpful modifiers that can be used to set the environment for these keys. You may call it like this:

```swift
struct ContentView: View {
    var body: some View {
        Wildlife()
            .gridLook(radiusPercent: 0.12, shadowRadius: 8.0)
            .favoriteLook(radiusPercent: 1.0, shadowRadius: 3.0)
    }
}
```

All parameters are optional, and if not specified, the default for each key is used.

<hr>

## Data Model

### `DataModel.swift`
Provides the text and image names.

