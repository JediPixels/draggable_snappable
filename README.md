# Draggable Snappable Sheet.

## Getting Started

DraggableScrollableSheet currently does not have two states, open or closed but user can
drag anywhere. I used a combination NotificationListener's, ScrollNotification,
DraggableScrollableNotification, and DraggableScrollableSheet to create the effect.
Changing the DraggableScrollableSheet Key is the key to achieving the snap
by changing the initialChildSize to _minExtent or _maxExtent.

## [License: MIT](LICENSE.md)