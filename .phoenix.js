// https://github.com/kasper/phoenix/blob/master/docs/API.mds

Phoenix.set({
  daemon: true,
  openAtLogin: true
});

var SMALL_WINDOW_HEIGHT = 600;
var SMALL_WINDOW_WIDTH = 800;

var MOD_KEYS = ["ctrl", "shift"];

/* KEY HANDLERS */

Key.on("up", MOD_KEYS, function() {
  Phoenix.log("Mod+up");
  var screen = Screen.main().flippedVisibleFrame();
  var window = Window.focused();

  logProperties(screen, window);

  if (!window) {
    return;
  }

  if (isWindowMaximised(screen, window)) {
    setWindowTopHalf(window, screen);
  } else {
    setWindowMaximised(window);
  }
});

Key.on("down", MOD_KEYS, function() {
  Phoenix.log("Mod+down");
  var screen = Screen.main().flippedVisibleFrame();
  var window = Window.focused();

  logProperties(screen, window);

  if (!window) {
    return;
  }

  if (isWindowCentered(window)) {
    setWindowBottomHalf(window, screen);
  } else {
    setWindowSmallCentered(screen, window);
  }
});

Key.on("left", MOD_KEYS, function() {
  Phoenix.log("Mod+left");
  var screen = Screen.main().flippedVisibleFrame();
  var window = Window.focused();

  logProperties(screen, window);

  if (!window) {
    return;
  }

  setWindowSplitLeft(window, screen);
});

Key.on("right", MOD_KEYS, function() {
  Phoenix.log("Mod+right");
  var screen = Screen.main().flippedVisibleFrame();
  var window = Window.focused();

  logProperties(screen, window);

  if (!window) {
    return;
  }

  setWindowSplitRight(window, screen);
});

/* Helpers */

function setWindowSmallCentered(screen, window) {
  Phoenix.log("setWindowSmallCentered", window.title());
  window.setTopLeft({
    x: screen.width / 2 - SMALL_WINDOW_WIDTH / 2,
    y: screen.height / 2 - SMALL_WINDOW_HEIGHT / 2
  });
  window.setSize({
    width: SMALL_WINDOW_WIDTH,
    height: SMALL_WINDOW_HEIGHT
  });
}

function setWindowMaximised(window) {
  Phoenix.log("setWindowMaximised", window.title());
  window.maximise();
}

function setWindowSplitLeft(window, screen) {
  Phoenix.log("setWindowSplitLeft", window.title());
  window.setTopLeft({
    x: 0,
    y: 0
  });
  window.setSize({
    width: screen.width / 2,
    height: screen.height
  });
}
function setWindowTopHalf(window, screen) {
  Phoenix.log("setWindowTopHalf", window.title());
  window.setTopLeft({
    x: 0,
    y: 0
  });
  window.setSize({
    width: screen.width,
    height: screen.height / 2
  });
}

function setWindowBottomHalf(window, screen) {
  Phoenix.log("setWindowBottomHalf", window.title());
  window.setTopLeft({
    x: 0,
    y: screen.height / 2
  });
  window.setSize({
    width: screen.width,
    height: screen.height / 2
  });
}

function setWindowSplitRight(window, screen) {
  Phoenix.log("setWindowSplitRight", window.title());
  window.setTopLeft({
    x: screen.width / 2,
    y: 0
  });
  window.setSize({
    width: screen.width / 2,
    height: screen.height
  });
}

function isWindowMaximised(screen, window) {
  return (
    window.size().height === screen.height &&
    window.size().width === screen.width
  );
}

function isWindowCentered(window) {
  return (
    window.size().height === SMALL_WINDOW_HEIGHT &&
    window.size().width === SMALL_WINDOW_WIDTH
  );
}

function logProperties(screen, window) {
  if (screen) {
    Phoenix.log("Screen", screen.width, screen.height);
  }
  if (window) {
    Phoenix.log("Window", window.size().width, window.size().height);
  }
}
