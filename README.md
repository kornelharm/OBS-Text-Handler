# About
OBS Text Handler (OTH) is a dedicated program to handling text sources in OBS Studio. Ideally, this saves time by being able to edit all relevant sources at one time, instead of navigating through various folders, scenes and other sources in OBS. At its core, OTH is really just a glorified text editor, but for many files at one time.

This project is quite simple and is therefore not under any specific active development. Instead, development is reserved for feedback or personal desires. If you would like to provide feedback on any existing or desired features, bugs, or have discussions about OTH, then [this Discord server](https://discord.gg/Gpft6x7u7y) is available for that purpose.

# Download
The latest releases can be found [here](https://github.com/kornelharm/OBS-Text-Handler/releases). Once downloaded, simply run and use.

# Usage
### 1. Creating a Handle
Handles refer to the files which OTH creates and modifies and then OBS reads into the scene. When OTH is opened, there is an empty handle ready to be used. Additional handles can be created with the `Add Handle` button at the top of the interface. 

### 2. Modifying Handles 
Each row in OTH represents a Handle. Within each handle, The label on the left refers to its descriptive name, only used within OTH, and can be modified by clicking on it. The handle can be linked to a file or  removed with the respective buttons, and the text can be edited with the text field in the middle. The text field will also display the current contents of the file when importing a configuration. To the right of the handle, there is a label displaying the filepath to the file which the handle is linked to.

### 3. Linking a Handle
To link a file, hit the respective button and either select an existing file or provide a filename and create a new one. Note that **linking to an existing file does not immediately overwrite the file**, as it might seem, but instead it is only updated once the handles are saved. Instead, a link to an already existing file will simply display its existing text in the text field and save future updates to the specified file.

### 4. Using handles in OBS
For a given text source, enable `Read from file` in its properties, and set the filepath to the linked handle file. At this point, OTH handles the rest.

### 5. Updating Handles
When a text field is edited, the linked file is not immediately updated and must be done so deliberately. This is done with the `Save` button at the bottom of the interface. This updates all handle files and the changes will show up in OBS when it notices an update to the file.

### 6. Using Configurations
Part of the magic is being able to properly organize and reuse a specific configuration of handles. This can be done so by using the `Import` and `Export` buttons. This encourages not only the reuse of specific configurations, but allows switching between configurations tailored for specific purposes. As an example, one could switch between two configurations, each one used to configure the text on separate and unrelated graphics.

# Where are my files stored?
OTH doesn't install to a specific location, encouraging flexibility in its use. However, while the configurations and handles are stored wherever they are saved, it is worth noting that OTH stores other information (such as caching previously accessed directories) in the user's application data directory. This directory is located at `...\AppData\Roaming\Godot\app_userdata\OBS Text Handler\` on Windows.