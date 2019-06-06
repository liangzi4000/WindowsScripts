rem Goto target folder and execute below command
DEL /F/Q/S *.* > NUL

rem /F -- forces the deletion of read-only files.
rem /Q -- enables quiet mode. You are not ask if it is ok to delete files (if you don't use this, you are asked for any file in the folder).
rem /S -- runs the command on all files in any folder under the selected structure.
rem *.* -- delete all files.
rem > NUL -- disables console output. This improves the process further, shaving off about one quarter of the processing time off of the console command.

rem Exit target folder and execute below command
RMDIR /Q/S foldername

rem /Q -- Quiet mode, won't prompt for confirmation to delete folders.
rem /S -- Run the operation on all folders of the selected path.
rem foldername -- The absolute path or relative folder name, e.g. o:/backup/test1 or test1