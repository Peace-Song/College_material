# NOTE: Class Mouse is already fully implemented for you.
class Mouse:
  def __init__(self):
    self.sensor = "xy wheels"
    self.buttons = ["button"]

  def click(self):
    print("button click!")

  def move(self):
    print("xy wheels sense the mouse move.")


class BallMouse(Mouse):
  # TODO: 1. IMPLEMENT BALL MOUSE.
  def __init__(self):
    self.sensor = "ball"
    self.buttons = ["left button", "right button"]

  def click(self, button):
    if button in self.buttons:
      print("{button} click!".format(button=button))

  def move(self):
    if self.sensor == None:
      print("No balls inside! Can not sense move!")
    
    else:
      print("ball senses the mouse move.")

  def remove_ball(self):
    print("Removed the ball from the mouse!")
    self.sensor = None


class WheeledBallMouse(BallMouse):
  # TODO: 2. IMPLEMENT WHEELED BALL MOUSE.
  def __init__(self):
    self.sensor = "ball"
    self.buttons = ["left button", "right button", "wheel"]

  def scroll(self, direction):
    if direction == "up" or direction == "down":
      print("Scrollinging {direction}...".format(direction=direction))


class OpticalMouse(WheeledBallMouse):
  # TODO: 3. IMPLEMENT OPTICAL MOUSE.
  def __init__(self):
    self.sensor = "light"
    self.buttons = ["left button", "right button", "wheel"]

  def move(self):
    print("light senses the mouse move.")

  def remove_ball(self):
    pass


class LaserMouse(OpticalMouse):
  # TODO: 4. IMPLEMENT LASER MOUSE.
  def __init__(self, *args):
    self.sensor = "laser"
    self.buttons = ["left button", "right button", "wheel"]
    
    for arg in args:
      self.buttons.append(arg)

  def move(self):
    print("laser senses the mouse move.")



# NOTE: DO NOT MODIFY BELOW.
# Test mouses.
if __name__ == "__main__":
  print("Meeting 4&5, Phase 2: Mouse")
  print("")

  # Test for Mouse
  mouse = Mouse()
  mouse.click()
  mouse.move()

  # Test for BallMouse
  ball_mouse = BallMouse()

  ball_mouse.click("left button")
  ball_mouse.click("right button")
  ball_mouse.click("wrong button")

  ball_mouse.move()
  ball_mouse.remove_ball()
  ball_mouse.move()

  # Test for WheeledBallMouse
  wheeled_ball_mouse = WheeledBallMouse()

  wheeled_ball_mouse.click("left button")
  wheeled_ball_mouse.click("right button")
  wheeled_ball_mouse.click("wheel")
  wheeled_ball_mouse.click("wrong button")

  wheeled_ball_mouse.move()
  wheeled_ball_mouse.remove_ball()
  wheeled_ball_mouse.move()

  wheeled_ball_mouse.scroll("up")
  wheeled_ball_mouse.scroll("down")
  wheeled_ball_mouse.scroll("side")

  # Test for OpticalMouse
  optical_mouse = OpticalMouse()

  optical_mouse.click("left button")
  optical_mouse.click("right button")
  optical_mouse.click("wheel")
  optical_mouse.click("wrong button")

  optical_mouse.move()
  optical_mouse.remove_ball()

  optical_mouse.scroll("up")
  optical_mouse.scroll("down")
  optical_mouse.scroll("side")

  # Test for LaserMouse
  laser_mouse = LaserMouse("backward", "forward")

  laser_mouse.click("left button")
  laser_mouse.click("right button")
  laser_mouse.click("wheel")
  laser_mouse.click("backward")
  laser_mouse.click("forward")
  laser_mouse.click("wrong button")

  laser_mouse.move()
  laser_mouse.remove_ball()

  laser_mouse.scroll("up")
  laser_mouse.scroll("down")
  laser_mouse.scroll("side")

  # The followings must raise AttributeError.
  try:
    mouse.remove_ball()
  except AttributeError:
    pass

  try:
    ball_mouse.scroll("up")
  except AttributeError:
    pass