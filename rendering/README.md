# Coding Dojo: Optimizing Flutter UI Performance
In mobile development, it's important to build lightweight apps that don’t overburden the device’s 
CPU or GPU. Even though Flutter is optimized for performance, careless widget structuring can lead 
to unnecessary work — especially in the form of rebuilds and repaints. This can make the app feel 
sluggish or unresponsive.

## 🔄 Rebuilds vs 🎨 Repaints
### Rebuild
Flutter re-executes the build() method to regenerate the widget tree. This is triggered by setState, 
Provider, Bloc, and other state management tools. It creates new widget instances but doesn't 
necessarily redraw pixels unless the visual appearance changes.
### Repaint
Flutter redraws the visual representation (pixels) on the screen. This happens when the render 
object needs to update its appearance, even if the widget tree hasn't changed — for example, during 
animations, scrolling, or when a CustomPainter is updated.

> Rebuilds don’t always lead to repaints, and repaints can happen without rebuilds. Even if rebuilds 
are efficient, painting can still be costly — especially for complex UIs or animations.

## 🔄 How to Limit Rebuilds
- Break down large widgets into smaller, reusable widgets.
- Use const constructors where possible, which helps Flutter short-circuit rebuilds by reusing widget instances.
- Prefer StatelessWidget when state is not needed.
- Use ValueListenableBuilder, AnimatedBuilder, ListenableBuilder or similar widgets to isolate updates.

## 🎨 How to Limit Repaints
Even if rebuilds are optimized, repaints can still be a bottleneck. Unnecessary redraws can be 
prevented with RepaintBoundary, a widget that creates a separate layer in the rendering tree. 
This means that it isolates a subtree for painting. When something inside it changes, only that 
part is repainted, not the entire screen.
Use RepaintBoundary when:
- You have complex widgets that don’t change often but are inside a frequently updating parent.
- You want to optimize animations or scrolling performance.
- You’re profiling your app using Flutter DevTools (it visually shows repaint boundaries).

> RepaintBoundary can increase memory usage if overused.

## 🧪 In This Assignment
You’ll explore and apply performance optimizations in a sample Flutter app.

### Tasks:
1) Profile performance using Flutter DevTools:
- Use the debugger with breakpoints inside your build() method to track rebuilds.
- Read this documentation https://docs.flutter.dev/tools/devtools/performance and use the 
Performance Overlay to visualize repaint boundaries and look at frame rebuilds.
- Have a look at the different options for tracking widget builds, layouts and paints.
- Have a look at disabling render layer types (clip, opacity, physical).
- Profile build is best for tracking these performance issues.

2) Identify which parts of the UI are unnecessarily rebuilding or repainting.
- Refactor the code using separate StatelessWidgets.
- Use RepaintBoundary to isolate repaint-heavy areas.
- Try to use ValueNotifier combined with AnimatedBuilder to rebuild Container 2.
- Has the example app improved its render performance?

3) Try applying the same optimizations to one of our own complex widget trees or pages!
- We don't want to call saveLayer any more than necessary! Where do we call it a lot?

4) Additional resources to explore when you're done: 
- Video on working with devtools: https://www.youtube.com/watch?v=_EYk-E29edo
- Info on best practices in performance: https://docs.flutter.dev/perf/best-practices
- Info on rendering performance: https://docs.flutter.dev/perf/rendering-performance
- Info on UI perfomrance: https://docs.flutter.dev/perf/ui-performance
- Blog on working properly with layers: https://medium.com/flutter-community/the-layer-cake-widgets-elements-renderobjects-7644c3142401

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
- This is a debug-only tool and should not be used in production builds.