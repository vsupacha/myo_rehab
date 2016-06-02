function ploter = ploter(handles)

    if(handles.state1==1)
        handles.plot1 = handles.current_data2(:,1);
    else
        handles.plot1 = 0;
    end
    if(handles.state2==1)
        handles.plot2 = handles.current_data2(:,2);
    else
        handles.plot2 = 0;
    end
    if(handles.state3 == 1)
        handles.plot3 = handles.current_data2(:,3);
    else
        handles.plot3 = 0;
    end
    if(handles.state4==1)
        handles.plot4 = handles.current_data2(:,4);
    else
        handles.plot4 = 0;
    end
    if(handles.state5==1)
        handles.plot5 = handles.current_data2(:,5);
    else
        handles.plot5 = 0;
    end
    if(handles.state6==1)
        handles.plot6 = handles.current_data2(:,6);
    else
        handles.plot6 = 0;
    end
    if(handles.state7==1)
        handles.plot7 = handles.current_data2(:,7);
    else
        handles.plot7 = 0;
    end
    if(handles.state8==1)
        handles.plot8 = handles.current_data2(:,8);
    else
        handles.plot8 = 0;
    end
    
    handles.plot =  handles.plot1 + handles.plot2 + handles.plot3 + handles.plot4 + handles.plot5 + handles.plot6 + handles.plot7 + handles.plot8;
    handles.state = handles.state1+handles.state2+handles.state3+handles.state4+handles.state5+handles.state6+handles.state7+handles.state8;
    SS = (handles.plot/handles.state)';
    ploter = SS;
    
    if(handles.state9==1)
        Thres = envelop_hilbert_v2(SS,20,true,20,false);
        X = 1:length(SS);
        Y = max(SS)*Thres;
        axes(handles.processedDataPlot)
        plot(X,Y(1:length(SS)),X,SS);
        ylim([-10 150])
        zoom on;
        PP = zeros(length(SS),2);
        PP(:,1) = Y(1:length(SS));
        PP(:,2) = SS;
        ploter = PP;
        PowerCal(PP);
    else
        if(min(SS)<0)
            axes(handles.processedDataPlot)
            plot(SS);
            ylim([-150 150])
            zoom on;
        else
            axes(handles.processedDataPlot)
            plot(SS);
            ylim([-10 150])
            zoom on;
    end
end