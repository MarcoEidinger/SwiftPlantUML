Re-create images by running `createImages.sh` which will
- read  `.stage1/source.swift` and create PlantUML scripts in `.stage2` folder
- read PlantUML scripts in `.stage2` folder and creates respective SVG files in this folder
  - requires that plantuml.jar exists in root directory of this repository