# MacOSPhotosAppTimeStampSetter
Usually when we import photos/videos into the Photos app in MacOS, the date is taken either from exif date or from the modified date. But in some cases (for some old cameras or file formats), we see that the photo/video date is set as the imported time. Taking each photo or video and correcting it is difficult. 
We can use Apple Scripts to automate this. But apple script in Photos does not have the option to take created/modified date of the original file. So we have to take the date either from exif data or from the file name. Since the exif data is different for different cameras and phones, the best way is to rename the files before importing so that the wanted date information is stored in the file name itself.

The workflow follwed is like this.

1. Use "advanced renamer" tool in windows or "exif tool (https://exiftool.org)" in MacOS to modify the file names to start with "YYYYMMDD_HHMMSS" format. For e.g. 20080413_094607 (Canon910IS).jpg
2. Then import the files to Photos app.
3. Open the script in Script Editor tool in Mac.
4. In Photos App, select all the files for which we need to set the date from the file name.
5. Run the script.
6. Voila, now we have all the wrong dates set to the correct date as seen in the file name.
