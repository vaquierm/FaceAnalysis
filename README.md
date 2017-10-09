## FaceAnalysis
Simple iOS application using the Emotion API provided by Microsoft Azure.
Users can take pictures or load them from the photo library.
Once a picture is selected, it can be analyzed. Each emotion is associated with a score between 0 and 1.
The supported emotions are anger, contempt, disgust, fear, happiness, neutral, sadness, and surprise.

#Using the application
clone the git repository
`$ git clone https://github.com/vaquierm/FaceAnalysis`
Insert your subscription key in the ViewController.swift file in the `analyzeaction` function.
Change the region in the request url as appropriate.
Everything should then be in pllace to build and run the app properly.
