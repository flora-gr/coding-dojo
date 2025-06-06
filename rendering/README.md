# Coding Dojo: Optimizing Flutter UI Performance
In mobile development, especially with Flutter, it's important to build lightweight apps that don’t 
overburden the device’s CPU or GPU. Even though Flutter is optimized for performance, careless widget 
structuring can lead to unnecessary work — especially in the form of rebuilds and repaints. This makes
an app feel 'heavy' when running on the device.

## 🔄 Rebuilds vs 🎨 Repaints
### Rebuild
Flutter re-executes the build() method to regenerate the widget tree. This is triggered by setState, 
Provider, Bloc, and other state management tools. It creates new widget instances but doesn't 
necessarily redraw pixels unless the visual appearance changes.
### Repaint
Flutter redraws the visual representation (pixels) on the screen. This happens when the render 
object needs to update its appearance, even if the widget tree hasn't changed — for example, during 
animations, scrolling, or when a CustomPainter is updated.

Even if rebuilds are efficient, painting can still be costly — especially for complex UIs or 
animations.

## 🧩 How to Limit Rebuilds
- Break down large widgets into smaller, reusable widgets.
- Use const constructors where possible.
- Prefer StatelessWidget when state is not needed.
- Use ValueListenableBuilder, AnimatedBuilder, or similar widgets to isolate updates.

## 🖼️ How to Limit Repaints
Even if rebuilds are optimized, repaints can still be a bottleneck. Unnecessary redraws can be 
prevented with RepaintBoundary, a widget that creates a separate layer in the rendering tree. 
This means that it isolates a subtree for painting. When something inside it changes, only that 
part is repainted, not the entire screen.
Use RepaintBoundary when:
- You have complex widgets that don’t change often but are inside a frequently updating parent.
- You want to optimize animations or scrolling performance.
- You’re profiling your app using Flutter DevTools (it visually shows repaint boundaries).

## 🧪 In This Assignment
You’ll explore and apply performance optimizations in a sample Flutter app.

### Tasks:
1) Profile performance using Flutter DevTools:
- Use the Debugger with break points inside your build method to track rebuilds.
- Read this documentation https://docs.flutter.dev/tools/devtools/performance and use the 
Performance Overlay to visualize repaint boundaries and look at frame rebuilds.

2) Identify which parts of the UI are unnecessarily rebuilding or repainting.
- Refactor the code using separate StatelessWidgets.
- Use RepaintBoundary to isolate repaint-heavy areas.
- Try to use ValueNotifier combined with AnimatedBuilder to rebuild Container 2.
- Has the example app improved its render performance?

3) Try to do the same for one of our own complex app widget trees/pages

4) Follow-up if you're done: https://www.youtube.com/watch?v=_EYk-E29edo

### 🔍 Where to Find the Performance Overlay in Flutter
1) Using Flutter DevTools
- Run your app in debug mode.
- Open DevTools: you can launch it from your IDE (right side in Android Studio
  or https://docs.flutter.dev/tools/devtools/vscode for vscode).
- Go to the Performance tab.
- Enable "Show Performance Overlay".
2) From Code
- Add this to your MaterialApp: showPerformanceOverlay: true
- This will display the overlay directly on your app screen.