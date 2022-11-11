# Run locally
##### Apple M1 Pro
##### Ventura 

Open terminal and run  
softwareupdate --install-rosetta  

In finder go to applications folder then to utilities and right click in Terminal.app choosse open with Rosetta.  

In the root folder of this App open terminal and check if it is Rosetta with the command: arch  
The output should be: i386  

and run the following steps:   

sudo gem uninstall cocoapods  
sudo gem uninstall ffi  
arch -arm64 brew install cocoapods  
pod install  
