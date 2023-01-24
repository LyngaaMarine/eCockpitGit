@REM cd ..
@REM "C:\\Program Files (x86)\\WAGO Software\\e!COCKPIT\\e!COCKPIT.exe" --runscript='C:\O\LM\Shared - Docs\Application Shared Files\Git\eCockpit\importer.py' --scriptargs='%__CD__%'
cd ..
set location=%__CD__%
cd ..
"C:\\Program Files (x86)\\WAGO Software\\e!COCKPIT\\e!COCKPIT.exe" --runscript='%__CD__%importer.py' --scriptargs='%location%'