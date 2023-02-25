# NasaGallery
NasaGallery is the gallery of certain nasa images, User can tap on the image and can read about the image details.

# Project Details

## File Structure and Details of what each Folder contains

###### Grouping and MVMM - To create this project, groups are created. each group containing view has its own seperate files for View Model and View. Except that struct Model (NasaImage) is created to convert the json data in that format using JsonDecoder
###### NetworkManager Folder - It contains seperate DataService (named ProductionDataService) class, which is responsible to get the data from internet. Class does conform to DataServiceProtocol which contains 2 methods, one for  handling the response and another for returning a publisher<[ImageModel].self, Error>. This is a good practice as sometimes we might want to use dummy service for testing purposes we can make another service conform to that protocol and we can use that practice by avoiding the operation on production resources.
###### - GridView Folder - It contains 2 files GridView (View) and GridViewModel (ViewModel of GridView). GridView is responsible to display the grid of the images received from the internet. By clicking on one of the image, user navigates to the detail view for that image.
###### - DetailViewModule - It contains 2 files DetailView (View) and DetailViewModel (ViewModel). Detail view contains the detail of the image, which was clicked from the grid before the appearance of DetailView. Detail view contains the meta data for the image. User can also swipe to the previous or next image's Detail View
###### - Utility Folder - It is created to work with array of colors. When the grid appears, if images are not downloaded yet, then different colors from this array are used to have placeholder boxes of different colors.


## Unit Tests details written for this project



 
