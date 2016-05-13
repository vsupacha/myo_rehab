function ploter2 = ploter2(handles)
    A = size(handles.current_data);
    PP = zeros(A);
    if(handles.s1==1)
        PP(:,1) = handles.current_data(:,1);
    else
        PP(:,1) = 0;
    end
    if(handles.s2==1)
        PP(:,2) = handles.current_data(:,2);
    else
        PP(:,2) = 0;
    end
    if(handles.s3 == 1)
        PP(:,3) = handles.current_data(:,3);
    else
        PP(:,3) = 0;
    end
    if(handles.s4==1)
        PP(:,4) = handles.current_data(:,4);
    else
        PP(:,4) = 0;
    end
    if(handles.s5==1)
        PP(:,5) = handles.current_data(:,5);
    else
        PP(:,5) = 0;
    end
    if(handles.s6==1)
        PP(:,6) = handles.current_data(:,6);
    else
        PP(:,6) = 0;
    end
    if(handles.s7==1)
        PP(:,7) = handles.current_data(:,7);
    else
        PP(:,7) = 0;
    end
    if(handles.s8==1)
        PP(:,8) = handles.current_data(:,8);
    else
        PP(:,8) = 0;
    end
    
    j = 1;
    P2 = [];
    for ii  = 1:8
        if sum(PP(:,ii))~=0
            P2(:,j) = PP(:,ii);
            j = j+1;
        elseif sum(PP) == 0
            P2 = [];
            cla(handles.rawDataPlot)
        end
    end
    SS = P2;
    ploter2 = SS;
    
    if(handles.s9==1)
        axes(handles.rawDataPlot)
        plot(SS);
        ylim([-150 150])
    else
        axes(handles.rawDataPlot)
        plot(SS);
        ylim([-10 150])
    end
end