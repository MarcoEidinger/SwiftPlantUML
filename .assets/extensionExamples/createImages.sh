# pre-cleanup
rm ShowExtensions.svg
rm HideExtensions.svg
rm MergeExtensions.svg
rm .stage2/ShowExtensions.txt
rm .stage2/MergeExtensions.txt
rm .stage2/HideExtensions.txt
cd ../..
# create PlantUML scripts in root directory
swift run swiftplantuml .assets/extensionExamples/.stage1/source.swift  --output consoleOnly > ShowExtensions.txt
swift run swiftplantuml .assets/extensionExamples/.stage1/source.swift --merge-extensions --output consoleOnly > MergeExtensions.txt
swift run swiftplantuml .assets/extensionExamples/.stage1/source.swift  --hide-extensions --output consoleOnly > HideExtensions.txt
# move scripts to this directory
mv ShowExtensions.txt .assets/extensionExamples/.stage2
mv MergeExtensions.txt .assets/extensionExamples/.stage2
mv HideExtensions.txt .assets/extensionExamples/.stage2
cd .assets/extensionExamples
# create images (!requires that plantuml.jar exists in root directory!)
java -jar ../../plantuml.jar .stage2 -tsvg -o ../

