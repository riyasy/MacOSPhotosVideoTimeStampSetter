# MacOSPhotosVideoTimeStampSetter
In macOS Photos app, when importing videos, for some file formats or files from some specific phones or cameras, the timestamp of the video is set as imported time instead of the actual time stamp of the video. The script corrects the timestamp of the video based on the timestamp from the file name. In future, setting from modified/created time stamp is planned.

# Usage

Prerequisite

The filename of the videos should start with the following format YYYYMMDD_HHMMSS
This can be easily done in any batch renaming tools, Exiftool etc.
The file renaming should be done before importing.

Steps
1. Download the script file to your mac.
2. Open Photos app
3. Open the script in Script Editor
4. Select the videos for which you want to correct the timestamp
5. Run the script
