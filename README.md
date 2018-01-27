## Intro

**invader Detector** can analyze the radar image and return if there's any invader existing. You can 

1. copy your radar image and put into `./radar_images/current_image.txt`
2. increase new known invader samples into `./known_invaders` with name `invader_*.txt`

We've collected radar image and invaders samples already, you're also free to just simply execute this script to check if there's any potential threat exists.

```
$ ruby execute.rb
```

## Usage

You can require the module by `require './lib/invader_detector'`
Then new a detector for invaders by

```
# image's type should be an arrya with string
# i.e. ["-----", "oooooo", "--o--"]
> invader_detector = Detector::Invader.new(image)
> invader.analysis
```

You can check your current radar image by calling

```
> invader_detector.radar_image
```

## Test

Use `Minitest` as unit test tool, make sure you've installed by

```
$ gem install minitest
```

and run the test with

```
$ ruby tests/invader_detector_test.rb
```
