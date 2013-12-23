---

date: 2011-02-02
layout: page
title: "How to restore a Macintosh hard drive to its factory settings"
tags: [ "Macintosh" ]

---

Last week I needed to restore six MacBooks to their factory default
settings, deleting all data, accounts, network settings, and so on.
Here’s the procedure I used. It results in a pristine Mac hard drive,
right down to the multilingual welcome message and setup assistant to
get started. If you’re getting ready to sell an old Mac, I recommend
following these steps to give the buyer as much of a new Mac experience
as possible, while also protecting your personal data from strangers.

None of this is new information necessarily, but unfortunately many of
the support discussion boards that will be among the first results in a
search provide a great deal of misinformation, and some steps will vary
depending on whether you’re restoring to Mac OS X 10.5 or 10.6. This is
an attempt to bring everything to one page (and document for my own
future reference).

### What you’ll need:

-   A Mac in need of hard drive resetting.
-   A little bit of Mac know-how&mdash;we’ll be digging into Disk
    Utility to erase the hard drive, single user mode, and root access.
    If any of this scares you, stop now and ask somebody for help.
-   Installer discs for the software you wish to restore. I had Mac OS X
    10.5 (Leopard) and the included Applications installer for these
    MacBooks. These laptops actually shipped right as 10.6 (Snow
    Leopard) hit the shelves, so an extra installer disc for that was
    included. I wound up installing it, too.
-   A second Mac, an external hard drive, a Firewire cable, and disk
    cloning software, if you wish to image the pristine hard drive for
    use with other restorations (optional)
-   A wired Internet connection, to speed up large downloads a bit
    (optional)
-   Time. Depending on how securely you’re reformatting the hard drive,
    and how many updates you need to download, resetting a single
    computer can take several hours.

### The steps:

**Boot the Mac from the installer disc.** To do this, start your Mac
while holding down the C key on your keyboard. Insert the disc to boot.
In a few minutes you should see the language selection screen for the
Mac OS X installer. Select your preferred language to continue.

**Erase your hard drive.** Select Disk Utility from the Utilities menu
and select your hard drive. Note that secure reformatting techniques can
be very time-intensive. I went with the Zero Out Data option, which took
about 40 minutes to complete on a 160 GB hard drive.

**Install your operating system.** If you’ve ever installed a fresh copy
of your operating system, this step should feel pretty straightforward.
Complete the steps to install Mac OS on the computer, using default
settings. I skipped the disc installer validation step because I knew my
disc did not have any problems, but if you want the extra sense of
security plan on letting this step run for awhile.

**Enable the root user.** When the operating system installer is done,
restart your computer, but boot it again from the installer disc by
holding down the C key on your keyboard during startup. If you
accidentally boot from the hard drive, wait for the welcome video to
play through, then press command-Q to quit the installer and shut down
your computer. Start up again while holding down the C key to retry
booting from the installer.

Select your language again, then under Utilities choose the Reset
Password tool. Select the System Administrator (root) account and assign
it a temporary password. You’ll just be using this during setup, and
this password will be removed before you’re done. Write the password
down, if necessary; you’ll need to enter it several times as you install
updates to the operating system and any other software you install.
Click Save, then quit the Reset Password tool.

**Reboot in single user mode.** At this point you should still be booted
from the installer disc. Restart your computer, and this time hold down
command-S to boot into single user mode. If you’re not used to seeing
your Mac’s Unix guts, this step can feel daunting. You’re going to enter
a few commands here to trick the Mac into thinking it’s all set up, and
thus not try to walk you through the setup assistant each time.

When you see the <code>%</code> prompt followed by a cursor, begin
typing the following. <em>Do not type the <code>%</code> that starts
each line&mdash;I’ve included it for context.</em> Press return after
carefully typing each line to process that command.

    % /sbin/fsck -fy
    % /sbin/mount -uw /
    % touch /private/var/db/.AppleSetupDone
    % exit

After typing the last command, your computer should begin booting in a
more familiar fashion. In a moment you’ll see a login screen. Use the
System Administrator account. The username will be <code>root</code>,
and the password will be what you set in the Reset Password utility a
few moments ago.

Make any network connections you’ll need to download software updates at
this time. Again, these are just temporary and will be removed by the
end of the procedure. (If I had this to do over, I would have moved my
operation next to my router and plug in directly to an Ethernet port for
a bit of a speed boost over my 802.11n wireless connection.)

**Install software from the Applications Installer disc.** If you
haven’t done so already, you can eject your operating system installer
disc (don’t put it away yet; you’ll use it again in a bit). Insert the
Applications Installer disc that was included with your Mac. This disc
probably includes at least the iLife software bundle, which is included
on new Macs but does not get installed with the regular operating
system. Run the installer as normal. You probably will not need to
reboot afterward, but if you do let the computer boot to the login
screen and log in again as <code>root</code> to continue. You can eject
the Applications Installer disc when done with this step.

**Run software updates.** Strictly speaking, this is an optional step.
You can skip it if you want to leave the hard drive as it was when you
first opened your Mac. I opted to bring everything up-to-speed,
including the operating system itself and the bundled iLife software.
(Specifically, I updated the version of iLife that came with the
computer; I didn’t install the paid upgrade to iLife ’11.)

Run Software Update (under the Apple menu) to download and install
available updates for the computer. You’ll probably need to do this
several times, as some updates are dependent on others. You’ll also need
to restart your computer at least a couple of times, logging in each
time using the <code>root</code> user. This will probably be the most
time-intensive step of the process. On my high-speed cable Internet
connection, I spent at least an hour downloading and installing update
packages.

Once Software Update tells you your computer has no updates at this
time, you’re in the home stretch.

**Re-enable the setup assistant and welcome video.** You’ll need to get
back into your Mac’s command line one more time, but this time you can
just use Terminal. It’s located in <em>Applications \> Utilities</em>.
Open Terminal and carefully type everything following the \#:

    # rm /private/var/db/.AppleSetupDone

Press return to process. What you’ve done is remove a file that your Mac
looks for to see whether you’ve completed the Setup Assistant or not.
You can quit out of Terminal now.

**Re-disable the root user.** Launch Directory Utility. This utility has
been moved from its old home in <em>Applications \> Utilities</em>; now
you’ll need to open the top level of your hard drive and navigate to
<em>System \> Library \> Core Services \> Directory Utility</em> (this
directory is not searchable in Spotlight). If necessary, click the
padlock and enter your temporary root password to make changes. Under
the <em>Edit</em> menu, select <em>Disable Root User</em>. Quit out of
Directory Utility.

**Reset the root user.** Insert the Mac OS X installer disc, if
necessary, and boot from it once more. Under the Utilities menu, select
Reset Password. Select the <code>root</code> user and press the Reset
button to remove network settings, among other things that are no longer
needed.

**Check your work.** Restart the computer from the hard drive you’ve
just reset. Hold down the mouse button to eject the installer media and
boot from the hard drive. If all went according to plan, you should see
the Mac OS X welcome video, followed by the first step of the setup
assistant. Press command-Q to quit the assistant and shut down your Mac.
Congratulations, your Mac’s hard drive looks brand new!

### Cloning (optional)

If you need to restore several computers, as I did, I strongly recommend
cloning the hard drive in the computer you just restored to the other
computers. I did this using a second Mac (not one I was restoring), an
external hard drive, and SuperDuper! backup software, connecting the
restored MacBook to my second Mac via a Firewire cable and starting the
restored Mac in target disk mode. I’m sure there are countless other
ways I could have done this. Cloning and other backup techniques are
beyond the scope of this article, though I’ve included a few links in
the references section below.

### References:

-   [Create an updated OS X install on a to-be-sold
    Mac](http://hints.macworld.com/article.php?story=20090805215651603)
-   [Securely wipe your hard
    drive](http://www.macworld.com/article/141358/2009/06/securely_wipe_hard_drive.html)
    (Macworld)
-   [Enable root account in Snow
    Leopard](http://snowleopardtips.net/tips/enable-root-account-in-snow-leopard.html)
-   [Transferring files between two computers using
    Firewire](http://docs.info.apple.com/article.html?path=Mac/10.6/en/8443.html)
-   [SuperDuper! backup
    software](http://www.shirt-pocket.com/SuperDuper/SuperDuperDescription.html)

