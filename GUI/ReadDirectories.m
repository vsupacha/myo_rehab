%Have created this part of code because it is used multiple time.
%Read Directories.
Directory_Application = num2str( textread('Directory_Application.txt'), '%s' );
Directory_MyoConnect = num2str( textread('Directory_MyoConnect.txt'), '%s' );
Directory_MyoCapture = num2str( textread('Directory_MyoCapture.txt'), '%s' );
Directory_RootSave = num2str( textread('Directory_RootSave.txt'), '%s' );

% %Try to ameliorate the code, don't work because we get 'char' variables
% %for path which are not the longests.

% %Read Directories.
% Directories =  num2str( textread('SettingDirectories.txt'), '%s' );
% %---
% 
% %Put path into variables
% Directory_MyoConnect = Directories( 1,: );
% Directory_MyoCapture = Directories( 2,: );
% Directory_RootSave = Directories( 3,: );
% %---