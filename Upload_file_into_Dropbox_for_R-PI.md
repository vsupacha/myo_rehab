1. DropBox account
First of all you need a DropBox account. Hop on over to DropBox and get one – it’s free.

2. Download and Set Up DropBox Uploader
Next, you need to get Dropbox Uploader onto your Pi

  cd ~ this ensures you are in /home/pi
  git clone https://github.com/andreafabrizi/Dropbox-Uploader.git
  ls

(If this fails, you may need to install git with sudo apt-get install git-core)

You should be able to see a directory called Dropbox-Uploader

cd Dropbox-Uploader
  ls

You should now see three files, one of which is called dropbox_uploader.sh. This is the script we’re going to use.


DropBox-Uploader files
3. Now the fiddly bit – API keys
Run the script with 
  ./dropbox_uploader.sh (if it fails, try chmod +x dropbox_uploader.sh)

You should see this…

Sorting out the DropBox API keys
You then need to visit this link 
  https://www.dropbox.com/developers/apps, login to DropBox and create an “app” by clicking the “create app” button.

Then choose “Dropbox API app”, “Files and Datastores”, and answer the final question “Can your app be limited to its own, private folder?” – either answer is OK, depending on your needs.

Then you need to give your app a unique name, and you will be assigned some keys to go with the name. Now you need to type in those keys here…

Entering your app’s DropBox API keys
Once you’ve entered your keys and answered the question “app” or “full”, your Pi will request an authorisation token and you will be given a web URL you need to visit to activate it…

DropBox API authorisation
This is the part which annoyed me, as I was using a different computer to ssh into the Pi and couldn’t cut and paste the “rather tricky to type accurately” URL. But once you’ve got past that hurdle it should all just work. :)

If it works, you should see this in your browser…

Your DropBox account connected to your “app”
4. Now you can use DropBox Uploader on your Raspberry Pi…
…from the command line like this…

  cd home/pi/Dropbox-Uploader
  ./dropbox_uploader.sh upload /home/pi/name_of_upload_file name_of_upload_file

This will upload the file you choose to your DropBox account.

…or use it in a Python script like this…

view plaincopy to clipboardprint?
from subprocess import call  
  photofile = "/home/pi/Dropbox-Uploader/dropbox_uploader.sh upload /home/pi/photo00001.jpg photo00001.jpg"   
  call ([photofile], shell=True)  
And, if you look at the DropBox Uploader documentation, there’s a lot more commands you can make use of…

  upload
  download
  delete
  move
  list
  share
  mkdir
I think this is brilliant. Yes you have to jump through a couple of hoops, but to be able to take a photo and see it on my PC, phone or Nexus 7 tablet within 30 seconds is pretty darned cool. I’ll jump through a couple of hoops for something that cool.

Here’s what it looks like in action, taking a photo and uploading to DropBox automatically. The DropBox upload photo part starts at 5m 7s.
