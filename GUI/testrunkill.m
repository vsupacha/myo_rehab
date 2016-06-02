%start your external task
dos('C:\Users\Kevin\Documents\GitHub\myo_rehab\GUI\Myo_Record\Myo Connect.exe &')
%wait for n seconds (defined by hand)
pause(10)
%kill the task
dos('taskkill /im <Myo Connect.exe>')