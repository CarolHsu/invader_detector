## Intro

**invador Detector** can analyze the radar image and return if there's any invador existing. You can 

1. copy your radar image and put into `./radar_images/current_image.txt`
2. increase new known invador samples into `./known_invadors` with name `invador_*.txt`

We've collected radar image and invadors samples already, you're also free to just simply execute this script to check if there's any potential threat exists.

```
$ ruby execute.rb
```

## Usage

You can require the module by `require './lib/invador_detector'`
Then new a detector for invadors by

```
# image's type should be an arrya with string
# i.e. ["-----", "oooooo", "--o--"]
> invador_detector = Detector::Invador.new(image)
> invador.analysis
```

You can check your current radar image by calling

```
> invador_detector.radar_image
```

## Test

Use `Minitest` as unit test tool, make sure you've installed by

```
$ gem install minitest
```

and run the test with

```
$ ruby tests/invador_detector_test.rb
```