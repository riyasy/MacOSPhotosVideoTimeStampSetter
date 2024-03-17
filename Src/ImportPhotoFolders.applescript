on run
	set folderList to (choose folder with multiple selections allowed)

	tell application "Photos"
		activate
		delay 2
	end tell

	repeat with baseFolder in folderList
		importEachSubFolder(baseFolder, null)
	end repeat
end run

to replaceText(someText, oldItem, newItem)
    (*
     replace all occurances of oldItem with newItem
          parameters -     someText [text]: the text containing the item(s) to change
                    oldItem [text, list of text]: the item to be replaced
                    newItem [text]: the item to replace with
          returns [text]:     the text with the item(s) replaced
    *)
	set {tempTID, AppleScript's text item delimiters} to {AppleScript's text item delimiters, oldItem}
	try
		set {itemList, AppleScript's text item delimiters} to {text items of someText, newItem}
		set {someText, AppleScript's text item delimiters} to {itemList as text, tempTID}
	on error errorMessage number errorNumber -- oops
		set AppleScript's text item delimiters to tempTID
		error errorMessage number errorNumber -- pass it on
	end try
	
	return someText
end replaceText

on importEachSubFolder(aFolder, parentFolder)
	tell application "Finder"
		set albumName to (name of aFolder as text)
		set subFolders to every folder of aFolder
	end tell

--	set albumName to replaceText(albumName, "_", space)   --if you want to change a special character (such as _ ) to spaces in Album names, uncomment this line
	if (count of subFolders) > 0 then
		set fotoFolder to createFotoFolder(aFolder, albumName, parentFolder)

		repeat with eachFolder in subFolders
			importEachSubFolder(eachFolder as alias, fotoFolder)
		end repeat
	else
		set fotoFolder to parentFolder
	end if

	importFotosV2(aFolder, albumName, fotoFolder)
end importEachSubFolder

on importFotos(aFolder, albumName, parentFolder)
	set imageList to getImageList(aFolder)
	if imageList is {} then return

	set fotoAlbum to createFotoAlbum(albumName, parentFolder)

	tell application "Photos"
		with timeout of (30 * 60) seconds
			import imageList into fotoAlbum skip check duplicates no
		end timeout
	end tell
end importFotos

on importFotosV2(aFolder, albumName, parentFolder)
	set imageList to getImageListV2(aFolder)
	if imageList is {} then return
	set fotoAlbum to createFotoAlbum(albumName, parentFolder)
	
	set imageSubList to {}
	repeat with i from 1 to count of imageList
		set the_item to item i of the imageList
		set end of imageSubList to the_item
		if 0 is i mod 500 then
			tell application "Photos"
				with timeout of (30 * 60) seconds
					import imageSubList into fotoAlbum skip check duplicates no
				end timeout
			end tell
			set imageSubList to {}
			tell application "Photos"
				quit
				delay 3
			end tell
			tell application "Photos"
				activate
				delay 3
			end tell
			
		end if
	end repeat
	tell application "Photos"
		with timeout of (30 * 60) seconds
			import imageSubList into fotoAlbum skip check duplicates no
		end timeout
	end tell
end importFotosV2

on createFotoFolder(aFolder, folderName, parentFolder)
	tell application "Photos"
		if parentFolder is null then
			make new folder named folderName
		else
			make new folder named folderName at parentFolder
		end if
	end tell
end createFotoFolder

on createFotoAlbum(albumName, parentFolder)
	tell application "Photos"
		if parentFolder is null then
			make new album named albumName
		else
			make new album named albumName at parentFolder
		end if
	end tell
end createFotoAlbum

on getImageList(aFolder)
	set extensionsList to {"jpg", "png", "tiff", "JPG", "jpeg", "gif", "JPEG", "PNG", "TIFF", "GIF", "MOV", "mov", "MP4", "mp4", "M4V", "m4v", "MPG", "mpg", "BMP", "bmp", "TIF", "tif", "AVI", "avi", "PSD", "psd", "ai", "AI", "orf", "ORF", "nef", "NEF", "crw", "CRW", "cr2", "CR2", "dng", "DNG", "PEF"}
	with timeout of (30 * 60) seconds
		tell application "Finder" to set theFiles to every file of aFolder whose name extension is in extensionsList
	end timeout
	set imageList to {}
	repeat with i from 1 to number of items in theFiles
		set thisItem to item i of theFiles as alias
		set the end of imageList to thisItem
	end repeat
	
	imageList
end getImageList

on getImageListV2(mSource_folder)
	-- set extensionsList to {"jpg", "png", "tiff", "JPG", "jpeg", "gif", "JPEG", "PNG", "TIFF", "GIF", "MOV", "mov", "MP4", "mp4", "M4V", "m4v", "MPG", "mpg", "BMP", "bmp", "TIF", "tif", "AVI", "avi", "PSD", "psd", "ai", "AI", "orf", "ORF", "nef", "NEF", "crw", "CRW", "cr2", "CR2", "dng", "DNG", "PEF"}
	
	set imageList to {}
	set item_list to ""
	tell application "System Events"
		set item_list to get the name of every file of mSource_folder
		--set item_list to every file of mSource_folder
	end tell
	
	set item_count to (get count of items in item_list)
	
	repeat with i from 1 to item_count
		set the_item to item i of the item_list
		if IsMedia(the_item as string) then
			
			--log (mSource_folder)
			--log the_item
			
			set the_item to ((mSource_folder & the_item) as string) as alias
			set end of imageList to the_item
		end if
	end repeat
	
	imageList
end getImageListV2

on IsMedia(fileName)
	set extensionsList to {"HEIC", "JPG", "JPEG", "NEF", "ARW", "TIFF", "MOV", "MP4", "PNG", "TIFF", "TIF", "AVI", "WMV", "GIF", "3GP", "M4V"}
	set itemCount to (get count of items in extensionsList)
	repeat with i from 1 to itemCount
		set ext to item i of the extensionsList
		if fileName contains ("." & ext) then
			return true
		end if
	end repeat
	return false
end IsMedia
