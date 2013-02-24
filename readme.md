## ScrapeKit WorkBench ##
The ScrapeKit Workbench is does two things:

* Gives you a working example of how to invoke a [ScrapeKit](http://github.com/edwardaux/ScrapeKit) script to parse some HTML.
* Provides a useful development-time tool for you to write and debug your own scripts.

### Installation ###
* Clone this project into a directory on your local machine
* Open a Terminal prompt, navigate to the `ScrapeKitWorkbench/External/ScrapeKit` directory of this project, and type the following command `git submodule update --init --recursive`
* Open the project in Xcode, build and run.

This should display a window with two text views at the top.  Enter your script into left hand one, paste some sample data into the right hand one, and click on *Scrape*.

The Console at the bottom will display the ScrapeKit debugging information as the script proceeds.