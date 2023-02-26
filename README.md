# NasaGallery
NasaGallery is the gallery of certain nasa images, User can tap on the image and can read about the image details.

# Project Details

## File Structure and Details of what each Folder contains

Grouping and MVMM - To create this project, groups are created. each group containing view has its own seperate files for View Model and View. Except that struct Model (NasaImage) is created to convert the json data in that format using JsonDecoder
NetworkManager Folder - It contains seperate DataService (named ProductionDataService) class, which is responsible to get the data from internet. Class does conform to DataServiceProtocol which contains 2 methods, one for  handling the response and another for returning a publisher<[ImageModel].self, Error>. This is a good practice as sometimes we might want to use dummy service for testing purposes we can make another service conform to that protocol and we can use that practice by avoiding the operation on production resources.
GridView Folder - It contains 2 files GridView (View) and GridViewModel (ViewModel of GridView). GridView is responsible to display the grid of the images received from the internet. By clicking on one of the image, user navigates to the detail view for that image.
DetailViewModule - It contains 2 files DetailView (View) and DetailViewModel (ViewModel). Detail view contains the detail of the image, which was clicked from the grid before the appearance of DetailView. Detail view contains the meta data for the image. User can also swipe to the previous or next image's Detail View
Utility Folder - It is created to work with array of colors. When the grid appears, if images are not downloaded yet, then different colors from this array are used to have placeholder boxes of different colors.


## Unit Tests

- This is a simple project of containing 2 screens only. Prime focus while writing unit tests was on getting the data correctly from the internet, decoding it correctly (Decoding of the data is getting us the [NasaImage] format or not) and diaplaying in an asked manner (for ex. Latest image first). 
- GridViewModel and DataService contained the main business logic for the application. To test if both the files are working as expected different files of unit tests is created for both.
- Tests get failed with proper message so that developer can understand what really example. For that when something gets wrong custom errors are thrown while developing the code. Ex. Decoding the data with wrong decoder, Status code of response was not in 200-300 range, Returned data is nil or returned response was not HTTPURL all contains the explicit errors. 
- It was desired that latest images must be first, so unit test is written for that too. 

## UI of the project 

*Ignore the quality of GIF, it has been reduced to upload here. As we can not upload file of more than 10 MB*

**- Colorful placeholder boxes in Grid when images are getting downloaded**

![Simulator Screen Shot - iPhone 14 - 2023-02-25 at 18 13 20](https://user-images.githubusercontent.com/68719677/221357461-f6368da9-42bb-4cf7-8803-22691bd29ea0.png)

**- Grid View after images gets downloaded** 

![Simulator Screen Shot - iPhone 14 - 2023-02-25 at 18 19 24](https://user-images.githubusercontent.com/68719677/221357716-4418eb64-d373-4098-a044-2f231d0c7c9c.png)

**- Detail View**

![DetailView](https://user-images.githubusercontent.com/68719677/221359655-fa237671-62a9-4705-a3bf-6037ed709b9c.gif)


**- Swiping feature to see previous or next image**
 
![SwipingToPreviousAndNext](https://user-images.githubusercontent.com/68719677/221360179-4bb56765-758a-4f88-b3da-2afdf70281a9.gif)

**- Error message When there is a problem getting images downloaded**

![Simulator Screen Shot - iPhone 14 - 2023-02-25 at 22 08 32](https://user-images.githubusercontent.com/68719677/221401015-74404e61-3b8d-4dc0-aa8d-26117bfe022a.png)

