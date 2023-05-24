# e!Cockpit Github Converter
## Limitations
* Unit Conversion, External File, RecipeManager, Trace, Trend Recording Manager, Alarm Configuration Objects are unsupported
* Library Manager, GlobalTextList, Task Configuration, Visualization Manager must exist at the root of their respective structures
* Visualization, Visualization Manager, Task Configuration, PLC Logic, Project Settings are stored in the codesys XML format, and will not merge correctly, so changes to these must be handled manually
* WebVisu objects will not import, so these must be added manually after import
## How it works
### Exporter
The exporter script opens the src.ecp file located in the ecp folder, the runs through every object in the project, and exports the content of the files to seperate files located in the src folder, it also copies the ecp project to the ecp_backup folder, then deletes the src.ecp file.
### Importer
The importer script opens a fresh e!Cockpit project then for every file and folder in the src folder it recursivly tries to import the content of the file, it then saves the src.ecp file to the ecp folder.
## Setup
A project should be structured like the folder test_project. 
The batch files in the git folder need to point to the importer and exporter .py files.
One way is to have the files stored in a central location which the batch files can access, another is to store the files in the git folder itself.
Also copy the .gitignore file and uncomment to prevent large github storage use.
## How to use it
### Before working
To work with the project files, you execute the srcToEcp.bat file to convert the individual source files to an src.ecp project, which you can then open an perform you tasks.
### After working
To end working and commit changes, run the ecpTosrc.bat file, which will convert the src.ecp project to src files which can be committed.
## Troubleshooting/Reporting
The project is not completely bullet proof, and there may be error codes, this is why both the working file ecp/src.ecp, the file when exported ecp_at_export/src.ecp and the file when imported ecp_at_import/src.ecp are stored. Any errors discovered should be registered as issues in https://github.com/LyngaaMarine/eCockpitGit/issues

# Changelog
* ## 0.0.7 24-05-23
  #### Added automatic backup of ecp file when importing, to prevent accedential loss of ecp progress.
* ## 0.0.6 04-05-23
  #### Importer Performance gain
* ## 0.0.5 03-05-23
  #### Fixed issue with some objects exporting incorrectly when containing unicode characters
* ## 0.0.4 07-03-23
  #### Fixed limitations on object naming
  #### Fixed issue with nested folders inside function blocks
* ## 0.0.3 03-03-23
  #### Reworked library import/export to remove limitations
* ## 0.0.2 28-01-23
  #### Changed text output to be unicode encoded to prevent python error
  #### Turned off prints to improve import performance
* ## 0.0.1 Initial Release

