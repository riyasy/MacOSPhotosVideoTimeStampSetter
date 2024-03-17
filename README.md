## ExportSelectedPhotosFileNamesToTextFile
Select photos on Mac Photos app. Run the script. All the original file names of the selected photos are exported to a text file (macPhotosSelectedFiles.txt) on the desktop. 
Can be useful in the case of referenced photos in the library. When we delete from Mac Photos app, the actual files on disk are not deleted in case of referenced photos. This script can find the file names of the deleted photos and then we can manually or through scripting find and delete photos on actual disk.

## SetDateFromTitle
Usually when we import photos/videos into the Photos app in MacOS, the date is taken either from exif date or from the modified date. But in some cases (for some old cameras or file formats), we see that the photo/video date is set as the imported time. Taking each photo or video and correcting it is difficult. 
We can use Apple Scripts to automate this. But apple script in Photos does not have the option to take created/modified date of the original file. So we have to take the date either from exif data or from the file name. Since the exif data is different for different cameras and phones, the best way is to rename the files before importing so that the wanted date information is stored in the file name itself.

The workflow follwed is like this.

1. Use "advanced renamer" tool in windows or "exif tool (https://exiftool.org)" in MacOS to modify the file names to start with "YYYYMMDD_HHMMSS" format. For e.g. 20080413_094607 (Canon910IS).jpg
2. Then import the files to Photos app.
3. Open the script in Script Editor tool in Mac.
4. In Photos App, select all the files for which we need to set the date from the file name.
5. Run the script.
6. Voila, now we have all the wrong dates set to the correct date as seen in the file name.


SetDateFromTitle.scpt is the actual script file.
SetDateFromTitle.txt is to see the contents using github viewer.

## Import Photo Folders

Forked from codez/ImportPhotoFolders

Import a directory hierarchy as albums into OS X Photos (El Capitan).

Just download `ImportPhotoFolders.applescript`, open it in Script Editor and execute it from there.
You will be asked to select the directories to import.

### Example

Given the following directory structure:

* Pictures/
  * Mountains/
    * Asia/
      * everest.jpg
      * k2.jpg
    * Europe/
      * matterhorn.jpg
  * People/
    * i.jpg
    * mejenny.jpg
  * whatever.jpg

When selecting the `Pictures` directory to import, the following structure will be generated in Photos:

* Pictures/ (folder)
  * Mountains/ (folder)
    * Asia (album)
      * everest.jpg
      * k2.jpg
    * Europe (album)
      * matterhorn.jpg
  * People (album)
    * i.jpg
    * mejenny.jpg
  * Pictures (album)
    * whatever.jpg

