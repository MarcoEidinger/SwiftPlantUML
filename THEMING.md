# Theming

> Customize your diagrams with themes

SwiftPlantUML generates PlantUML scripts and therefore supports its [theming capabilities](https://plantuml.com/theme) that are well documented. In a nutshell:

- None (default theme)
- Standard themes available in PlantUML
- Local themes
- Themes from the Internet

SwiftPlantUML will add the required `!theme` directive if you specify the respective element in your `.swiftplantuml.yml` configuration file.

```yaml
theme: amiga
```

will result in a generated PlantUML script that contains the `!theme` directive

```
@startuml
!theme amiga
class Example {}
@enduml
```

## None / Default Theme

No configuration in `.swiftplantuml.yml` configuration file is needed.

![default](.assets/themingExamples/default.svg)

## Recommended Standard Themes

PlantUML ships with a variety of themes. Some do not work well with class diagrams. Here is a list of examples that DO work well with class diagrams.

| Name              | Configuration                                                | Example                                                      |
| ----------------- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| amiga             | Add ```theme: amiga``` as top level element into your `.swiftplantuml.yml` file<br /> | ![amiga](.assets/themingExamples/amiga.svg)                  |
| carbon-gray       | Add ```theme: carbon-gray``` as top level element into your `.swiftplantuml.yml` file<br /> | ![carbon-gray](.assets/themingExamples/carbon-gray.svg)      |
| cloudscape-design | Add ```theme: cloudscape-design``` as top level element into your `.swiftplantuml.yml` file<br /> | ![cloudscape-design](.assets/themingExamples/cloudscape-design.svg) |
| Mars              | Add ```theme: mars``` as top level element into your `.swiftplantuml.yml` file<br /> | ![mars](.assets/themingExamples/mars.svg)                    |
| minty             | Add ```theme: minty``` as top level element into your `.swiftplantuml.yml` file<br /> | ![minty](.assets/themingExamples/minty.svg)                  |
| plain             | Add ```theme: plain``` as top level element into your `.swiftplantuml.yml` file<br /> | ![plain](.assets/themingExamples/plain.svg)                  |
| reddress-darkblue | Add ```theme: reddress-darkblue``` as top level element into your `.swiftplantuml.yml` file<br /> | ![reddress-darkblue](.assets/themingExamples/reddress-darkblue.svg) |
| sketchy           | Add ```theme: sketchy``` as top level element into your `.swiftplantuml.yml` file<br /> | ![sketchy](.assets/themingExamples/sketchy.svg)              |
| sketchy-outline   | Add ```theme: sketchy-outline``` as top level element into your `.swiftplantuml.yml` file<br /> | ![sketchy-outline](.assets/themingExamples/sketchy-outline.svg) |
| toy               | Add ```theme: toy``` as top level element into your `.swiftplantuml.yml` file<br /> | ![toy](.assets/themingExamples/toy.svg)                      |

## Legacy Theme

The previous default theme from PlantUML.

![legacy - skin rose](.assets/themingExamples/skinrose.svg)

 You cannot set this via `.swiftplantuml.yml` configuration as this is technically not a PlantUML theme.

You have to modify the generated PlantUML script and use `skin rose` directive.

Example

```
@startuml
skin rose
class Example {}
@enduml
```
