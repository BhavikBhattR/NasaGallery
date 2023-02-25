# NasaGallery
NasaGallery is the gallery of certain nasa images, User can tap on the image and can read about the image details.

# Project Details

## Structure followed to create this swiftUI project

###### To create this project, groups are created. each group containing view has its own seperate files for View Model and View. 
###### Seperate DataService class is created. Class does conform to DataService protocol which contains 2 methods handling the response and returning a publisher<[ImageModel].self, Error>. This is a good practice as if we want to use dummy service for testing purposes we can make another service conform to that protocol and we can use that practice.

