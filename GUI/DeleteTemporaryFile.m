%Read Directories
run( 'ReadDirectories.m' );
%---

%Find all the temporary .csv file created by 'MyoDataCapture.exe'
%Allaways begin by 'emg-' following by 'random' (I think) numbers
if Directory_MyoCapture == 0 
    disp(' Empty directory '); 

else 
    DirectoryFiles = dir(Directory_MyoCapture); 
    [FileNumber,Column] = size(DirectoryFiles); %FileNumber include . and .., wich are the 2 first line of DirectoryFiles
                                                %Column not use.
                                                
    %Searching the right file. Begin by 'emg-', then numbers
    %FileName = '' ; %Initializing FileName as ''
    
    for i=3:FileNumber 
    % this assumes that the first and second files are '.' and '..'
            
        FileName = DirectoryFiles(i).name ;
        Length = length( FileName );
        if Length > 4
            
            Comparaison = strcmp( FileName(Length-3 : end) , '.csv' );
            if Comparaison == 1
                PathFileDelete = strcat ( Directory_MyoCapture, '\' , FileName );
                delete( PathFileDelete );
            end
            
        end
    end
    %---
end
%---