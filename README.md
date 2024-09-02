# Simple Animated Path

A Flutter package that allow to animate custom paths.

## Example

<img src="//misk/example.gif?raw=true" width="500" alt="">

## How to use

```code

/// create your Path
final path = Path();
//...

/// create a Paint and configure it
final paint = Paint();
//...

/// create animation
final anim = Tween<double>(begin: 0, end: 1); 
//...

/// add the widget with a list on path configuration
SimpleAnimatedPathWidget(
    animation: anim,
    size: Size(itemSize, itemSize),
    configurations: [
        PathConfiguration(
            paint: paint,
            path: path,
        ),
        ...
    ],
);

```
## License

* MIT License